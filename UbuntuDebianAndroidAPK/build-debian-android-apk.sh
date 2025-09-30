#!/bin/bash

# Build Debian Android APK with Ribit 2.0
# This script creates an APK that installs Ubuntu Debian environment with Ribit 2.0

set -e

# Colors
C_BLUE='\033[1;34m'
C_GREEN='\033[1;32m'
C_YELLOW='\033[1;33m'
C_RED='\033[1;31m'
C_RESET='\033[0m'

echo -e "${C_BLUE}Building Ribit 2.0 Debian Android APK...${C_RESET}"

# Create project structure
PROJECT_NAME="Ribit2DebianAndroid"
PACKAGE_NAME="com.ribit.debian.android"

echo -e "${C_YELLOW}Creating project structure...${C_RESET}"
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

# Initialize Cordova project
echo -e "${C_YELLOW}Initializing Cordova project...${C_RESET}"
cordova create . $PACKAGE_NAME "Ribit 2.0 Debian Android"

# Add Android platform
echo -e "${C_YELLOW}Adding Android platform...${C_RESET}"
cordova platform add android

# Create custom HTML interface
echo -e "${C_YELLOW}Creating custom interface...${C_RESET}"
cat > www/index.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ribit 2.0 Debian Android</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 100vh;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            text-align: center;
        }
        .logo {
            font-size: 2.5em;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .subtitle {
            font-size: 1.2em;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        .button {
            display: inline-block;
            padding: 15px 30px;
            margin: 10px;
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 10px;
            color: white;
            text-decoration: none;
            font-size: 1.1em;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        .button:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }
        .button.primary {
            background: #4CAF50;
            border-color: #4CAF50;
        }
        .status {
            margin: 20px 0;
            padding: 15px;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            font-family: monospace;
            text-align: left;
            max-height: 200px;
            overflow-y: auto;
        }
        .requirements {
            text-align: left;
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
        }
        .requirements h3 {
            margin-top: 0;
        }
        .requirements ul {
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">🤖 Ribit 2.0</div>
        <div class="subtitle">Ubuntu Debian Android Environment</div>
        
        <div class="requirements">
            <h3>📋 Requirements</h3>
            <ul>
                <li>Termux app installed</li>
                <li>VNC Viewer app (RealVNC, AVNC)</li>
                <li>4-5 GB free storage space</li>
                <li>Android 7.0+ recommended</li>
            </ul>
        </div>
        
        <a href="#" class="button primary" onclick="installEnvironment()">
            🚀 Install Ribit 2.0 Environment
        </a>
        
        <a href="#" class="button" onclick="openTermux()">
            📱 Open Termux
        </a>
        
        <a href="#" class="button" onclick="showInstructions()">
            📖 View Instructions
        </a>
        
        <a href="#" class="button" onclick="checkStatus()">
            ⚙️ Check Status
        </a>
        
        <div id="status" class="status" style="display: none;">
            <div id="statusText">Ready to install...</div>
        </div>
    </div>

    <script>
        function showStatus(message) {
            document.getElementById('status').style.display = 'block';
            document.getElementById('statusText').innerHTML = message;
        }
        
        function installEnvironment() {
            showStatus('Starting Ribit 2.0 installation...<br><br>Steps:<br>1. Opening Termux...<br>2. Downloading setup script...<br>3. Running installation...<br><br>Please follow the prompts in Termux!');
            
            // Create installation command
            const installCommand = `bash -c "$(curl -fsSL https://raw.githubusercontent.com/rabit232/the-rabits-android-development-sdk-tools-for-ribit-2.0/main/UbuntuDebianAndroidAPK/ribit-debian-android-setup.sh)"`;
            
            // Try to open Termux with the command
            const termuxIntent = `intent://com.termux/#Intent;scheme=com.termux;package=com.termux;S.com.termux.RUN_COMMAND=${encodeURIComponent(installCommand)};end`;
            
            setTimeout(() => {
                window.location.href = termuxIntent;
            }, 1000);
            
            // Fallback: show manual instructions
            setTimeout(() => {
                showStatus(`If Termux didn't open automatically, please:<br><br>1. Open Termux manually<br>2. Run this command:<br><br><code style="background: rgba(0,0,0,0.3); padding: 10px; display: block; border-radius: 5px; word-break: break-all;">${installCommand}</code>`);
            }, 3000);
        }
        
        function openTermux() {
            showStatus('Opening Termux...');
            window.location.href = 'intent://com.termux/#Intent;scheme=com.termux;package=com.termux;end';
        }
        
        function showInstructions() {
            showStatus(`
                <strong>🚀 Ribit 2.0 Installation Guide</strong><br><br>
                
                <strong>Step 1:</strong> Install Prerequisites<br>
                • Install Termux from F-Droid or Google Play<br>
                • Install VNC Viewer (RealVNC or AVNC)<br>
                • Ensure 4-5 GB free storage<br><br>
                
                <strong>Step 2:</strong> Run Installation<br>
                • Tap "Install Ribit 2.0 Environment"<br>
                • Follow prompts in Termux<br>
                • Create username and password<br><br>
                
                <strong>Step 3:</strong> Access Environment<br>
                • Type 'debian' in Termux<br>
                • Run 'startvnc' to start desktop<br>
                • Connect VNC to localhost:1<br><br>
                
                <strong>Step 4:</strong> Use Ribit 2.0<br>
                • Click Ribit 2.0 icon on desktop<br>
                • Access AI development tools<br>
                • Build Android apps with SDK<br><br>
                
                <strong>Commands:</strong><br>
                • debian - Enter environment<br>
                • startvnc - Start desktop<br>
                • ribit - Launch Ribit 2.0<br>
            `);
        }
        
        function checkStatus() {
            showStatus(`
                <strong>🔍 System Status Check</strong><br><br>
                
                <strong>Required Apps:</strong><br>
                • Termux: ${navigator.userAgent.includes('Termux') ? '✅ Detected' : '❓ Unknown'}<br>
                • VNC Viewer: Install manually<br><br>
                
                <strong>Device Info:</strong><br>
                • Platform: ${navigator.platform}<br>
                • User Agent: ${navigator.userAgent.substring(0, 50)}...<br><br>
                
                <strong>Storage:</strong><br>
                • Check available space in device settings<br>
                • Minimum 4GB required<br><br>
                
                <strong>Network:</strong><br>
                • Connection: ${navigator.onLine ? '✅ Online' : '❌ Offline'}<br>
            `);
        }
        
        // Auto-hide status after 30 seconds
        setInterval(() => {
            const status = document.getElementById('status');
            if (status.style.display === 'block') {
                setTimeout(() => {
                    status.style.display = 'none';
                }, 30000);
            }
        }, 1000);
    </script>
</body>
</html>
HTML

# Update config.xml with proper settings
echo -e "${C_YELLOW}Updating configuration...${C_RESET}"
cat > config.xml << 'CONFIG'
<?xml version='1.0' encoding='utf-8'?>
<widget id="com.ribit.debian.android" version="1.0.0" xmlns="http://www.w3.org/ns/widgets" xmlns:cdv="http://cordova.apache.org/ns/1.0">
    <name>Ribit 2.0 Debian Android</name>
    <description>
        Ubuntu Debian environment with Ribit 2.0 AI development tools for Android devices
    </description>
    <author email="support@ribit.ai" href="https://github.com/rabit232/the-rabits-android-development-sdk-tools-for-ribit-2.0">
        Ribit 2.0 Team
    </author>
    <content src="index.html" />
    <access origin="*" />
    <allow-intent href="http://*/*" />
    <allow-intent href="https://*/*" />
    <allow-intent href="tel:*" />
    <allow-intent href="sms:*" />
    <allow-intent href="mailto:*" />
    <allow-intent href="geo:*" />
    <platform name="android">
        <allow-intent href="market:*" />
        <preference name="android-minSdkVersion" value="21" />
        <preference name="android-targetSdkVersion" value="33" />
        <icon density="ldpi" src="www/res/icon/android/ldpi.png" />
        <icon density="mdpi" src="www/res/icon/android/mdpi.png" />
        <icon density="hdpi" src="www/res/icon/android/hdpi.png" />
        <icon density="xhdpi" src="www/res/icon/android/xhdpi.png" />
        <icon density="xxhdpi" src="www/res/icon/android/xxhdpi.png" />
        <icon density="xxxhdpi" src="www/res/icon/android/xxxhdpi.png" />
    </platform>
    <preference name="DisallowOverscroll" value="true" />
    <preference name="android-minSdkVersion" value="21" />
    <preference name="android-targetSdkVersion" value="33" />
    <preference name="BackupWebStorage" value="none" />
    <preference name="SplashMaintainAspectRatio" value="true" />
    <preference name="FadeSplashScreenDuration" value="300" />
    <preference name="SplashShowOnlyFirstTime" value="false" />
    <preference name="SplashScreen" value="screen" />
    <preference name="SplashScreenDelay" value="3000" />
</widget>
CONFIG

# Create app icons
echo -e "${C_YELLOW}Creating app icons...${C_RESET}"
mkdir -p www/res/icon/android

# Copy the existing icon from our previous project
if [ -f "../../MyAndroidApp/app/src/main/res/mipmap-hdpi/ic_launcher.png" ]; then
    cp ../../MyAndroidApp/app/src/main/res/mipmap-hdpi/ic_launcher.png www/res/icon/android/hdpi.png
    cp ../../MyAndroidApp/app/src/main/res/mipmap-hdpi/ic_launcher.png www/res/icon/android/mdpi.png
    cp ../../MyAndroidApp/app/src/main/res/mipmap-hdpi/ic_launcher.png www/res/icon/android/ldpi.png
    cp ../../MyAndroidApp/app/src/main/res/mipmap-hdpi/ic_launcher.png www/res/icon/android/xhdpi.png
    cp ../../MyAndroidApp/app/src/main/res/mipmap-hdpi/ic_launcher.png www/res/icon/android/xxhdpi.png
    cp ../../MyAndroidApp/app/src/main/res/mipmap-hdpi/ic_launcher.png www/res/icon/android/xxxhdpi.png
else
    echo "Warning: Icon not found, using default"
fi

# Build the APK
echo -e "${C_YELLOW}Building APK...${C_RESET}"
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

# Try building with cordova
if cordova build android; then
    echo -e "${C_GREEN}✅ APK built successfully!${C_RESET}"
    
    # Find and copy the APK
    if [ -f "platforms/android/app/build/outputs/apk/debug/app-debug.apk" ]; then
        cp platforms/android/app/build/outputs/apk/debug/app-debug.apk ../ribit-debian-android.apk
        echo -e "${C_GREEN}APK saved as: ribit-debian-android.apk${C_RESET}"
    fi
else
    echo -e "${C_RED}❌ APK build failed. Trying alternative method...${C_RESET}"
    
    # Create a simple APK structure manually
    mkdir -p ../manual-apk
    cd ../manual-apk
    
    # Create a basic Android project structure
    mkdir -p src/main/{java/com/ribit/debian/android,res/{layout,values,mipmap-hdpi}}
    
    # Create MainActivity
    cat > src/main/java/com/ribit/debian/android/MainActivity.java << 'JAVA'
package com.ribit.debian.android;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        TextView titleText = findViewById(R.id.titleText);
        Button installButton = findViewById(R.id.installButton);
        Button termuxButton = findViewById(R.id.termuxButton);
        
        installButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                installRibit();
            }
        });
        
        termuxButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                openTermux();
            }
        });
    }
    
    private void installRibit() {
        try {
            String command = "bash -c \"$(curl -fsSL https://raw.githubusercontent.com/rabit232/the-rabits-android-development-sdk-tools-for-ribit-2.0/main/UbuntuDebianAndroidAPK/ribit-debian-android-setup.sh)\"";
            
            Intent intent = new Intent();
            intent.setAction(Intent.ACTION_VIEW);
            intent.setData(Uri.parse("com.termux://"));
            intent.putExtra("com.termux.RUN_COMMAND", command);
            
            if (intent.resolveActivity(getPackageManager()) != null) {
                startActivity(intent);
            } else {
                Toast.makeText(this, "Please install Termux first", Toast.LENGTH_LONG).show();
            }
        } catch (Exception e) {
            Toast.makeText(this, "Error: " + e.getMessage(), Toast.LENGTH_LONG).show();
        }
    }
    
    private void openTermux() {
        try {
            Intent intent = getPackageManager().getLaunchIntentForPackage("com.termux");
            if (intent != null) {
                startActivity(intent);
            } else {
                Toast.makeText(this, "Termux not installed", Toast.LENGTH_SHORT).show();
            }
        } catch (Exception e) {
            Toast.makeText(this, "Error opening Termux", Toast.LENGTH_SHORT).show();
        }
    }
}
JAVA

    # Create layout
    cat > src/main/res/layout/activity_main.xml << 'XML'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="20dp"
    android:background="@android:color/white">

    <TextView
        android:id="@+id/titleText"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="🤖 Ribit 2.0\nDebian Android Environment"
        android:textSize="24sp"
        android:textStyle="bold"
        android:textColor="#333333"
        android:gravity="center"
        android:layout_marginBottom="30dp" />

    <TextView
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Transform your Android device into a powerful AI development environment with Ubuntu Debian and Ribit 2.0 tools."
        android:textSize="16sp"
        android:textColor="#666666"
        android:gravity="center"
        android:layout_marginBottom="40dp" />

    <Button
        android:id="@+id/installButton"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="🚀 Install Ribit 2.0 Environment"
        android:textSize="18sp"
        android:padding="15dp"
        android:layout_marginBottom="20dp"
        android:background="#4CAF50"
        android:textColor="@android:color/white" />

    <Button
        android:id="@+id/termuxButton"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="📱 Open Termux"
        android:textSize="16sp"
        android:padding="15dp"
        android:layout_marginBottom="20dp" />

    <TextView
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Requirements:\n• Termux app\n• VNC Viewer app\n• 4-5 GB free space\n• Android 7.0+"
        android:textSize="14sp"
        android:textColor="#888888"
        android:background="#f5f5f5"
        android:padding="15dp" />

</LinearLayout>
XML

    # Create strings
    cat > src/main/res/values/strings.xml << 'STRINGS'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Ribit 2.0 Debian Android</string>
</resources>
STRINGS

    # Create manifest
    cat > src/main/AndroidManifest.xml << 'MANIFEST'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.ribit.debian.android"
    android:versionCode="1"
    android:versionName="1.0">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:theme="@android:style/Theme.Material.Light">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
MANIFEST

    echo -e "${C_YELLOW}Manual APK structure created${C_RESET}"
fi

cd ..

echo -e "${C_GREEN}✅ Ribit 2.0 Debian Android APK build process completed!${C_RESET}"
echo ""
echo -e "${C_CYAN}Generated files:${C_RESET}"
echo "• ribit-debian-android.apk (if build successful)"
echo "• $PROJECT_NAME/ (Cordova project)"
echo "• manual-apk/ (Manual project structure)"
echo ""
echo -e "${C_YELLOW}Next steps:${C_RESET}"
echo "1. Install the APK on Android device"
echo "2. Run the app and follow installation instructions"
echo "3. Ensure Termux and VNC Viewer are installed"
echo ""
