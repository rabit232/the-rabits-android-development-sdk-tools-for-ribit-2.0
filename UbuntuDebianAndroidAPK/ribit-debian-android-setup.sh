#!/bin/bash

# Ribit 2.0 Ubuntu Debian Android Setup Script
# This script installs a full Ubuntu/Debian environment on Android with Ribit 2.0 capabilities
# Based on debian-on-android project with Ribit 2.0 enhancements

set -e

# --- Color Definitions ---
C_BLUE='\033[1;34m'
C_GREEN='\033[1;32m'
C_YELLOW='\033[1;33m'
C_CYAN='\033[1;36m'
C_RED='\033[1;31m'
C_RESET='\033[0m'

# --- Welcome Message ---
clear
echo -e "${C_CYAN}"
cat << "EOF"
 ____  _ _     _ _     ____   ___  
|  _ \(_) |__ (_) |_  |___ \ / _ \ 
| |_) | | '_ \| | __|   __) | | | |
|  _ <| | |_) | | |_   / __/| |_| |
|_| \_\_|_.__/|_|\__| |_____|\___/ 
                                  
Ubuntu Debian Android Environment
with Ribit 2.0 AI Development Tools
EOF
echo -e "${C_RESET}"

echo -e "${C_GREEN}Welcome to the Ribit 2.0 Ubuntu Debian Android Setup!${C_RESET}"
echo "Configuring the environment on your device..."
echo ""

# --- [1/8] User Input ---
echo -e "${C_YELLOW}>>> [1/8] Let's create your user account.${C_RESET}"
read -p "Please enter a username: " NEW_USER
read -s -p "Please enter a password for '$NEW_USER': " NEW_PASS
echo ""
read -s -p "Retype password: " NEW_PASS_CONFIRM
echo ""

if [ "$NEW_PASS" != "$NEW_PASS_CONFIRM" ]; then
    echo "Passwords do not match. Aborting."
    exit 1
fi

# --- [2/8] Base System Setup (in Termux) ---
echo -e "${C_BLUE}>>> [2/8] Updating base system packages...${C_RESET}"
pkg update -y && pkg upgrade -y

echo -e "${C_BLUE}>>> [2/8] Installing proot-distro...${C_RESET}"
pkg install proot-distro -y

echo -e "${C_BLUE}>>> [2/8] Installing Debian...${C_RESET}"
proot-distro install debian

# --- [3/8] Debian Configuration (as root) ---
echo -e "${C_BLUE}>>> [3/8] Configuring Debian system as root...${C_RESET}"

run_in_debian() {
    proot-distro login debian --shared-tmp -- /bin/bash -c "$@"
}

echo "--> Updating Debian's package list and upgrading packages..."
run_in_debian "apt-get update && apt-get upgrade -y"

echo "--> Installing required packages: sudo, nano, adduser..."
run_in_debian "apt-get install -y sudo nano adduser"

echo "--> Setting timezone to Asia/Tehran..."
run_in_debian "ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime"

echo "--> Creating user account..."
run_in_debian "adduser --disabled-password --gecos '' $NEW_USER"
run_in_debian "echo '$NEW_USER:$NEW_PASS' | chpasswd"
run_in_debian "usermod -aG sudo $NEW_USER"

echo "--> Installing desktop environment and essential software..."
run_in_debian "apt-get install -y xfce4 xfce4-goodies firefox-esr libreoffice tigervnc-standalone-server tigervnc-common"

echo "--> Installing development tools for Ribit 2.0..."
run_in_debian "apt-get install -y python3 python3-pip nodejs npm git curl wget build-essential"

echo "--> Installing Android development tools..."
run_in_debian "apt-get install -y openjdk-17-jdk android-sdk gradle"

echo "--> Installing AI/ML development tools..."
run_in_debian "apt-get install -y python3-numpy python3-scipy python3-matplotlib python3-pandas python3-sklearn"

# --- [4/8] Ribit 2.0 Installation ---
echo -e "${C_BLUE}>>> [4/8] Installing Ribit 2.0 AI Development Environment...${C_RESET}"

# Create Ribit 2.0 installation script
cat > /tmp/install_ribit.sh << 'RIBIT_SCRIPT'
#!/bin/bash

# Install Python dependencies for Ribit 2.0
pip3 install --user torch torchvision transformers openai anthropic kivy buildozer cython

# Install Node.js dependencies
npm install -g @angular/cli react-native-cli cordova

# Create Ribit 2.0 workspace
mkdir -p /home/$1/ribit-workspace/{projects,models,datasets,tools}

# Install additional AI tools
pip3 install --user jupyter notebook ipython matplotlib seaborn plotly

# Create Ribit 2.0 launcher script
cat > /home/$1/ribit-workspace/ribit-launcher.py << 'LAUNCHER'
#!/usr/bin/env python3
"""
Ribit 2.0 AI Development Environment Launcher
Provides access to AI development tools and Android SDK
"""

import os
import sys
import subprocess
import tkinter as tk
from tkinter import ttk, messagebox

class RibitLauncher:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Ribit 2.0 AI Development Environment")
        self.root.geometry("600x400")
        self.setup_ui()
    
    def setup_ui(self):
        # Main frame
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Title
        title_label = ttk.Label(main_frame, text="Ribit 2.0 AI Development Environment", 
                               font=("Arial", 16, "bold"))
        title_label.grid(row=0, column=0, columnspan=2, pady=10)
        
        # Buttons
        buttons = [
            ("Launch Jupyter Notebook", self.launch_jupyter),
            ("Open Android Studio", self.launch_android_studio),
            ("Start Python REPL", self.launch_python),
            ("Open File Manager", self.launch_filemanager),
            ("Launch VS Code", self.launch_vscode),
            ("Open Terminal", self.launch_terminal),
            ("Check System Status", self.check_status),
            ("Install Packages", self.install_packages)
        ]
        
        for i, (text, command) in enumerate(buttons):
            btn = ttk.Button(main_frame, text=text, command=command, width=25)
            btn.grid(row=(i//2)+1, column=i%2, padx=5, pady=5, sticky=tk.W+tk.E)
    
    def launch_jupyter(self):
        subprocess.Popen(["jupyter", "notebook", "--no-browser"])
        messagebox.showinfo("Ribit 2.0", "Jupyter Notebook started! Access via VNC browser.")
    
    def launch_android_studio(self):
        os.environ["ANDROID_HOME"] = "/usr/lib/android-sdk"
        subprocess.Popen(["gradle", "--version"])
        messagebox.showinfo("Ribit 2.0", "Android development environment ready!")
    
    def launch_python(self):
        subprocess.Popen(["python3", "-i"])
    
    def launch_filemanager(self):
        subprocess.Popen(["thunar"])
    
    def launch_vscode(self):
        try:
            subprocess.Popen(["code"])
        except FileNotFoundError:
            messagebox.showwarning("Ribit 2.0", "VS Code not installed. Install via: apt install code")
    
    def launch_terminal(self):
        subprocess.Popen(["xfce4-terminal"])
    
    def check_status(self):
        status = "Ribit 2.0 System Status:\n\n"
        status += f"Python: {sys.version}\n"
        status += f"Android SDK: {os.environ.get('ANDROID_HOME', 'Not set')}\n"
        status += f"Workspace: {os.path.expanduser('~/ribit-workspace')}\n"
        messagebox.showinfo("System Status", status)
    
    def install_packages(self):
        messagebox.showinfo("Ribit 2.0", "Use 'pip3 install package_name' or 'apt install package_name'")
    
    def run(self):
        self.root.mainloop()

if __name__ == "__main__":
    app = RibitLauncher()
    app.run()
LAUNCHER

chmod +x /home/$1/ribit-workspace/ribit-launcher.py

# Create desktop shortcut
mkdir -p /home/$1/Desktop
cat > /home/$1/Desktop/Ribit2.0.desktop << 'DESKTOP'
[Desktop Entry]
Version=1.0
Type=Application
Name=Ribit 2.0
Comment=AI Development Environment
Exec=python3 /home/$1/ribit-workspace/ribit-launcher.py
Icon=applications-development
Terminal=false
Categories=Development;
DESKTOP

chmod +x /home/$1/Desktop/Ribit2.0.desktop
chown -R $1:$1 /home/$1/ribit-workspace /home/$1/Desktop
RIBIT_SCRIPT

run_in_debian "bash /tmp/install_ribit.sh $NEW_USER"

# --- [5/8] VNC Server Configuration ---
echo -e "${C_BLUE}>>> [5/8] Configuring VNC server...${C_RESET}"

# Create VNC startup script
cat > /tmp/setup_vnc.sh << 'VNC_SCRIPT'
#!/bin/bash
USER=$1

# Create VNC startup script
cat > /home/$USER/startvnc << 'STARTVNC'
#!/bin/bash

# Check if VNC server is already running
if pgrep -f "Xvnc.*:1" > /dev/null; then
    echo "VNC server is already running on display :1"
    exit 1
fi

# Prompt for screen resolution if not set
if [ ! -f ~/.vnc_resolution ]; then
    echo "Select screen resolution:"
    echo "1) 1024x768"
    echo "2) 1280x720"
    echo "3) 1366x768"
    echo "4) 1920x1080"
    echo "5) Custom"
    read -p "Enter choice (1-5): " choice
    
    case $choice in
        1) RESOLUTION="1024x768" ;;
        2) RESOLUTION="1280x720" ;;
        3) RESOLUTION="1366x768" ;;
        4) RESOLUTION="1920x1080" ;;
        5) read -p "Enter custom resolution (WIDTHxHEIGHT): " RESOLUTION ;;
        *) RESOLUTION="1024x768" ;;
    esac
    
    echo $RESOLUTION > ~/.vnc_resolution
else
    RESOLUTION=$(cat ~/.vnc_resolution)
fi

# Start VNC server
vncserver :1 -geometry $RESOLUTION -depth 24 -xstartup ~/.vnc/xstartup

echo "VNC server started on display :1 with resolution $RESOLUTION"
echo "Connect using VNC viewer to: localhost:1"
STARTVNC

# Create VNC stop script
cat > /home/$USER/stopvnc << 'STOPVNC'
#!/bin/bash
vncserver -kill :1
echo "VNC server stopped"
STOPVNC

# Create VNC xstartup script
mkdir -p /home/$USER/.vnc
cat > /home/$USER/.vnc/xstartup << 'XSTARTUP'
#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4
XSTARTUP

chmod +x /home/$USER/startvnc /home/$USER/stopvnc /home/$USER/.vnc/xstartup
chown -R $USER:$USER /home/$USER/.vnc /home/$USER/startvnc /home/$USER/stopvnc

# Set VNC password
su - $USER -c "vncpasswd"
VNC_SCRIPT

run_in_debian "bash /tmp/setup_vnc.sh $NEW_USER"

# --- [6/8] Create Termux Aliases ---
echo -e "${C_BLUE}>>> [6/8] Creating convenient aliases...${C_RESET}"

# Create debian alias in Termux
echo "alias debian='proot-distro login debian --user $NEW_USER'" >> ~/.bashrc
echo "alias debian-root='proot-distro login debian'" >> ~/.bashrc
echo "alias ribit='proot-distro login debian --user $NEW_USER -- python3 /home/$NEW_USER/ribit-workspace/ribit-launcher.py'" >> ~/.bashrc

# --- [7/8] Android SDK Configuration ---
echo -e "${C_BLUE}>>> [7/8] Configuring Android SDK for Ribit 2.0...${C_RESET}"

cat > /tmp/setup_android.sh << 'ANDROID_SCRIPT'
#!/bin/bash
USER=$1

# Set up Android environment
echo 'export ANDROID_HOME=/usr/lib/android-sdk' >> /home/$USER/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools' >> /home/$USER/.bashrc

# Create Android development helper script
cat > /home/$USER/ribit-workspace/tools/android-helper.py << 'ANDROID_HELPER'
#!/usr/bin/env python3
"""
Ribit 2.0 Android Development Helper
Simplifies Android app development tasks
"""

import os
import subprocess
import sys

class AndroidHelper:
    def __init__(self):
        self.android_home = "/usr/lib/android-sdk"
        os.environ["ANDROID_HOME"] = self.android_home
    
    def create_project(self, name, package):
        """Create new Android project"""
        print(f"Creating Android project: {name}")
        # Use cordova for cross-platform development
        subprocess.run(["cordova", "create", name, package, name])
        os.chdir(name)
        subprocess.run(["cordova", "platform", "add", "android"])
        print(f"Project {name} created successfully!")
    
    def build_apk(self, project_path="."):
        """Build APK from current project"""
        print("Building APK...")
        os.chdir(project_path)
        result = subprocess.run(["cordova", "build", "android"], capture_output=True, text=True)
        if result.returncode == 0:
            print("APK built successfully!")
        else:
            print(f"Build failed: {result.stderr}")
    
    def install_apk(self, apk_path):
        """Install APK to connected device"""
        print(f"Installing APK: {apk_path}")
        subprocess.run(["adb", "install", apk_path])
    
    def list_devices(self):
        """List connected Android devices"""
        print("Connected devices:")
        subprocess.run(["adb", "devices"])

if __name__ == "__main__":
    helper = AndroidHelper()
    
    if len(sys.argv) < 2:
        print("Usage: python3 android-helper.py <command> [args]")
        print("Commands: create, build, install, devices")
        sys.exit(1)
    
    command = sys.argv[1]
    
    if command == "create" and len(sys.argv) >= 4:
        helper.create_project(sys.argv[2], sys.argv[3])
    elif command == "build":
        helper.build_apk()
    elif command == "install" and len(sys.argv) >= 3:
        helper.install_apk(sys.argv[2])
    elif command == "devices":
        helper.list_devices()
    else:
        print("Invalid command or missing arguments")
ANDROID_HELPER

chmod +x /home/$USER/ribit-workspace/tools/android-helper.py
chown -R $USER:$USER /home/$USER/ribit-workspace
ANDROID_SCRIPT

run_in_debian "bash /tmp/setup_android.sh $NEW_USER"

# --- [8/8] Final Setup ---
echo -e "${C_BLUE}>>> [8/8] Finalizing installation...${C_RESET}"

# Create welcome script
cat > /tmp/create_welcome.sh << 'WELCOME_SCRIPT'
#!/bin/bash
USER=$1

cat > /home/$USER/RIBIT_README.md << 'README'
# Ribit 2.0 Ubuntu Debian Android Environment

Welcome to your Ribit 2.0 AI development environment running on Android!

## Quick Start

1. **Access your environment**: Type `debian` in Termux
2. **Start desktop**: Run `startvnc` in Debian
3. **Connect VNC**: Use VNC viewer app, connect to `localhost:1`
4. **Launch Ribit 2.0**: Click the Ribit 2.0 icon on desktop

## Available Tools

### AI Development
- Python 3 with AI/ML libraries (numpy, scipy, matplotlib, pandas, sklearn)
- Jupyter Notebook for interactive development
- PyTorch and Transformers for deep learning
- OpenAI and Anthropic API clients

### Android Development
- Android SDK with Gradle build system
- Cordova for cross-platform development
- Android Helper script for common tasks
- APK building and deployment tools

### General Development
- Node.js and npm
- Git version control
- Build tools and compilers
- XFCE desktop environment

## Commands

### In Termux:
- `debian` - Enter Debian environment
- `debian-root` - Enter as root user
- `ribit` - Launch Ribit 2.0 directly

### In Debian:
- `startvnc` - Start VNC server
- `stopvnc` - Stop VNC server
- `python3 ~/ribit-workspace/ribit-launcher.py` - Launch Ribit 2.0 GUI

### Android Development:
```bash
cd ~/ribit-workspace/tools
python3 android-helper.py create MyApp com.example.myapp
python3 android-helper.py build
python3 android-helper.py devices
```

## Workspace Structure

```
~/ribit-workspace/
├── projects/     # Your development projects
├── models/       # AI models and datasets
├── datasets/     # Training data
├── tools/        # Development utilities
└── ribit-launcher.py  # Main launcher
```

## Tips

1. **Storage**: This environment uses ~4-5GB. Keep projects organized.
2. **Performance**: Close unused apps to free memory.
3. **Updates**: Run `apt update && apt upgrade` regularly.
4. **Backup**: Important projects should be synced to cloud storage.

## Troubleshooting

- **VNC not connecting**: Check if startvnc completed successfully
- **Android build fails**: Ensure ANDROID_HOME is set correctly
- **Python packages missing**: Use `pip3 install package_name`
- **Permission issues**: Use `sudo` for system-level changes

## Support

This environment is part of the Ribit 2.0 ecosystem. For more information:
- GitHub: https://github.com/rabit232/the-rabits-android-development-sdk-tools-for-ribit-2.0
- Check the UbuntuDebianAndroidAPK directory for additional tools

Happy coding with Ribit 2.0! 🚀
README

chown $USER:$USER /home/$USER/RIBIT_README.md
WELCOME_SCRIPT

run_in_debian "bash /tmp/create_welcome.sh $NEW_USER"

# --- Completion ---
echo ""
echo -e "${C_GREEN}🎉 Ribit 2.0 Ubuntu Debian Android Environment Setup Complete! 🎉${C_RESET}"
echo ""
echo -e "${C_CYAN}Next Steps:${C_RESET}"
echo "1. Type 'debian' to enter your Debian environment"
echo "2. Run 'startvnc' to start the desktop"
echo "3. Connect with VNC viewer to 'localhost:1'"
echo "4. Launch Ribit 2.0 from the desktop icon"
echo ""
echo -e "${C_YELLOW}Useful Commands:${C_RESET}"
echo "• debian          - Enter Debian environment"
echo "• ribit           - Launch Ribit 2.0 directly"
echo "• startvnc        - Start VNC desktop"
echo "• stopvnc         - Stop VNC desktop"
echo ""
echo -e "${C_BLUE}Read ~/RIBIT_README.md for detailed instructions!${C_RESET}"
echo ""
echo -e "${C_GREEN}Welcome to Ribit 2.0! 🤖✨${C_RESET}"
