#!/usr/bin/env python3
"""
Ribit 2.0 Debian Android App
A Python-based Android application that installs Ubuntu Debian environment with Ribit 2.0
"""

import os
import sys
import subprocess
import urllib.request
import json
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput
from kivy.uix.popup import Popup
from kivy.uix.progressbar import ProgressBar
from kivy.uix.scrollview import ScrollView
from kivy.clock import Clock
from kivy.utils import platform

class RibitDebianAndroidApp(App):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.title = "Ribit 2.0 Debian Android"
        self.installation_in_progress = False
        
    def build(self):
        # Main layout
        main_layout = BoxLayout(orientation='vertical', padding=20, spacing=10)
        
        # Title
        title_label = Label(
            text='🤖 Ribit 2.0\nUbuntu Debian Android Environment',
            font_size='24sp',
            size_hint_y=None,
            height='100dp',
            halign='center',
            valign='middle'
        )
        title_label.bind(size=title_label.setter('text_size'))
        main_layout.add_widget(title_label)
        
        # Description
        desc_label = Label(
            text='Transform your Android device into a powerful AI development environment\nwith Ubuntu Debian and Ribit 2.0 tools.',
            font_size='16sp',
            size_hint_y=None,
            height='80dp',
            halign='center',
            valign='middle'
        )
        desc_label.bind(size=desc_label.setter('text_size'))
        main_layout.add_widget(desc_label)
        
        # Requirements section
        req_layout = BoxLayout(orientation='vertical', size_hint_y=None, height='150dp')
        req_title = Label(
            text='📋 Requirements:',
            font_size='18sp',
            size_hint_y=None,
            height='30dp',
            halign='left'
        )
        req_title.bind(size=req_title.setter('text_size'))
        req_layout.add_widget(req_title)
        
        requirements = [
            '• Termux app installed',
            '• VNC Viewer app (RealVNC, AVNC)',
            '• 4-5 GB free storage space',
            '• Android 7.0+ recommended'
        ]
        
        for req in requirements:
            req_label = Label(
                text=req,
                font_size='14sp',
                size_hint_y=None,
                height='25dp',
                halign='left'
            )
            req_label.bind(size=req_label.setter('text_size'))
            req_layout.add_widget(req_label)
        
        main_layout.add_widget(req_layout)
        
        # Buttons
        button_layout = BoxLayout(orientation='vertical', spacing=10)
        
        # Install button
        install_btn = Button(
            text='🚀 Install Ribit 2.0 Environment',
            font_size='18sp',
            size_hint_y=None,
            height='60dp',
            background_color=(0.3, 0.7, 0.3, 1)
        )
        install_btn.bind(on_press=self.install_environment)
        button_layout.add_widget(install_btn)
        
        # Open Termux button
        termux_btn = Button(
            text='📱 Open Termux',
            font_size='16sp',
            size_hint_y=None,
            height='50dp'
        )
        termux_btn.bind(on_press=self.open_termux)
        button_layout.add_widget(termux_btn)
        
        # Instructions button
        instructions_btn = Button(
            text='📖 View Instructions',
            font_size='16sp',
            size_hint_y=None,
            height='50dp'
        )
        instructions_btn.bind(on_press=self.show_instructions)
        button_layout.add_widget(instructions_btn)
        
        # Status button
        status_btn = Button(
            text='⚙️ Check Status',
            font_size='16sp',
            size_hint_y=None,
            height='50dp'
        )
        status_btn.bind(on_press=self.check_status)
        button_layout.add_widget(status_btn)
        
        main_layout.add_widget(button_layout)
        
        # Status area
        self.status_label = Label(
            text='Ready to install Ribit 2.0 environment...',
            font_size='14sp',
            size_hint_y=None,
            height='60dp',
            halign='center',
            valign='middle'
        )
        self.status_label.bind(size=self.status_label.setter('text_size'))
        main_layout.add_widget(self.status_label)
        
        return main_layout
    
    def install_environment(self, instance):
        """Install Ribit 2.0 environment"""
        if self.installation_in_progress:
            self.show_popup("Installation in Progress", "Installation is already running. Please wait...")
            return
        
        self.installation_in_progress = True
        self.status_label.text = "Starting Ribit 2.0 installation...\nPlease follow prompts in Termux!"
        
        # Installation command
        install_command = 'bash -c "$(curl -fsSL https://raw.githubusercontent.com/rabit232/the-rabits-android-development-sdk-tools-for-ribit-2.0/main/UbuntuDebianAndroidAPK/ribit-debian-android-setup.sh)"'
        
        try:
            if platform == 'android':
                # Try to open Termux with the command
                from jnius import autoclass, cast
                
                Intent = autoclass('android.content.Intent')
                PythonActivity = autoclass('org.kivy.android.PythonActivity')
                
                intent = Intent()
                intent.setAction(Intent.ACTION_VIEW)
                intent.setData(autoclass('android.net.Uri').parse('com.termux://'))
                intent.putExtra('com.termux.RUN_COMMAND', install_command)
                
                currentActivity = cast('android.app.Activity', PythonActivity.mActivity)
                currentActivity.startActivity(intent)
                
                self.status_label.text = "Termux should open with installation command.\nFollow the prompts to complete setup."
                
            else:
                # Fallback for non-Android platforms
                self.show_popup("Manual Installation", 
                    f"Please run this command in Termux:\n\n{install_command}")
                
        except Exception as e:
            self.show_popup("Installation Error", 
                f"Could not automatically start installation.\n\nPlease manually:\n1. Open Termux\n2. Run: {install_command}\n\nError: {str(e)}")
        
        # Reset installation flag after delay
        Clock.schedule_once(lambda dt: setattr(self, 'installation_in_progress', False), 5)
    
    def open_termux(self, instance):
        """Open Termux app"""
        try:
            if platform == 'android':
                from jnius import autoclass, cast
                
                Intent = autoclass('android.content.Intent')
                PythonActivity = autoclass('org.kivy.android.PythonActivity')
                PackageManager = autoclass('android.content.pm.PackageManager')
                
                currentActivity = cast('android.app.Activity', PythonActivity.mActivity)
                packageManager = currentActivity.getPackageManager()
                
                intent = packageManager.getLaunchIntentForPackage('com.termux')
                if intent:
                    currentActivity.startActivity(intent)
                    self.status_label.text = "Opening Termux..."
                else:
                    self.show_popup("Termux Not Found", "Termux app is not installed.\nPlease install it from F-Droid or Google Play Store.")
            else:
                self.show_popup("Platform Not Supported", "This feature is only available on Android devices.")
                
        except Exception as e:
            self.show_popup("Error", f"Could not open Termux: {str(e)}")
    
    def show_instructions(self, instance):
        """Show detailed instructions"""
        instructions_text = """🚀 Ribit 2.0 Installation Guide

Step 1: Install Prerequisites
• Install Termux from F-Droid or Google Play
• Install VNC Viewer (RealVNC or AVNC)
• Ensure 4-5 GB free storage

Step 2: Run Installation
• Tap "Install Ribit 2.0 Environment"
• Follow prompts in Termux
• Create username and password

Step 3: Access Environment
• Type 'debian' in Termux
• Run 'startvnc' to start desktop
• Connect VNC to localhost:1

Step 4: Use Ribit 2.0
• Click Ribit 2.0 icon on desktop
• Access AI development tools
• Build Android apps with SDK

Commands:
• debian - Enter environment
• startvnc - Start desktop
• ribit - Launch Ribit 2.0

Features:
• Python 3 with AI/ML libraries
• Android SDK with Gradle
• Jupyter Notebook
• XFCE desktop environment
• Cross-platform development tools"""
        
        self.show_scrollable_popup("Installation Instructions", instructions_text)
    
    def check_status(self, instance):
        """Check system status"""
        status_info = f"""🔍 System Status Check

Platform: {platform}
Python Version: {sys.version.split()[0]}

Device Info:
• Platform: {platform}
• Python: {sys.version.split()[0]}

Required Apps:
• Termux: Install from F-Droid/Play Store
• VNC Viewer: Install RealVNC or AVNC

Storage:
• Check available space in device settings
• Minimum 4GB required

Network:
• Internet connection required for installation
• Downloads ~1-2GB of packages

Next Steps:
1. Ensure Termux is installed
2. Tap "Install Ribit 2.0 Environment"
3. Follow installation prompts
4. Access via VNC after setup"""
        
        self.show_scrollable_popup("System Status", status_info)
    
    def show_popup(self, title, content):
        """Show a simple popup"""
        popup_layout = BoxLayout(orientation='vertical', padding=10, spacing=10)
        
        content_label = Label(
            text=content,
            text_size=(None, None),
            halign='center',
            valign='middle'
        )
        popup_layout.add_widget(content_label)
        
        close_btn = Button(
            text='Close',
            size_hint_y=None,
            height='50dp'
        )
        popup_layout.add_widget(close_btn)
        
        popup = Popup(
            title=title,
            content=popup_layout,
            size_hint=(0.9, 0.7)
        )
        
        close_btn.bind(on_press=popup.dismiss)
        popup.open()
    
    def show_scrollable_popup(self, title, content):
        """Show a scrollable popup for long content"""
        popup_layout = BoxLayout(orientation='vertical', padding=10, spacing=10)
        
        content_label = Label(
            text=content,
            text_size=(None, None),
            halign='left',
            valign='top'
        )
        
        scroll = ScrollView()
        scroll.add_widget(content_label)
        popup_layout.add_widget(scroll)
        
        close_btn = Button(
            text='Close',
            size_hint_y=None,
            height='50dp'
        )
        popup_layout.add_widget(close_btn)
        
        popup = Popup(
            title=title,
            content=popup_layout,
            size_hint=(0.95, 0.8)
        )
        
        close_btn.bind(on_press=popup.dismiss)
        
        # Set text size after popup is created
        def set_text_size(dt):
            content_label.text_size = (popup.width * 0.85, None)
        
        Clock.schedule_once(set_text_size, 0.1)
        popup.open()

if __name__ == '__main__':
    RibitDebianAndroidApp().run()
