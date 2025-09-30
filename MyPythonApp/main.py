#!/usr/bin/env python3

from kivy.app import App
from kivy.uix.label import Label
from kivy.uix.boxlayout import BoxLayout


class MyApp(App):
    def build(self):
        layout = BoxLayout(orientation='vertical', padding=50, spacing=20)
        
        title_label = Label(
            text='Hello, Android World!',
            font_size='24sp',
            size_hint=(1, 0.3),
            color=(0, 0.5, 1, 1)  # Blue color
        )
        
        subtitle_label = Label(
            text='This is a simple Android APK created with Python!',
            font_size='16sp',
            size_hint=(1, 0.7),
            text_size=(None, None),
            halign='center',
            valign='middle'
        )
        
        layout.add_widget(title_label)
        layout.add_widget(subtitle_label)
        
        return layout


if __name__ == '__main__':
    MyApp().run()
