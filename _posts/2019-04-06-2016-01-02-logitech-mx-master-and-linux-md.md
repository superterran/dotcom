---
layout: post
current: post
navigation: false
date: '2016-01-02 13:20 -0400'
class: post-template
sub-class: post
author: superterran
published: false
title: 2016-01-02-logitech-mx-master-and-linux.md
---
---
title: Logitech MX Master and Linux
---

Logitech's MX Master is perhaps one of the best mice available at the moment. Supporting both Bluetooth and the Unifying Receiver, loads of buttons, a vertical scroll wheel and micro-usb rechargable battery, it's hard to go wrong with this thing. Unfortunately, the default key mappings on my linux desktop (Gnome 3) are terrible. The thumb button doesn't do anything, and the vertical scroll does god knows what.


![Keyboard Setting to Change to get Expose Thumb]( /assets/2016/logitech_thumbbutton.png)

The vertical scroll button is a little harder to configure. Personally, I want the vertical scroll to do page zooming.

In Fedora 23, I had to install the following packages:

~~~ bash
  $ sudo dnf install xautomation xbindkeys
~~~

xbindkeys is a daemon that lets you remap keybindings. xautomation contains xte, which is a little app that let's you emulate keystrokes. Using the two, we can remap the mouse buttons to simulate

and give xbindkeys the following config:

*somewhere inside ~/.xbindkeysrc*

~~~ini
#zoom-in
   "xte 'keydown Control_L' 'keydown Shift_L' 'key plus' 'keyup Shift_L' 'keyup Control_L'"
    b:6
#zoom-out
  "xte 'keydown Control_L' 'key minus' 'keyup Control_L'"
    b:7
~~~

I'm emulating ctrl+shift+plus for Zoom out in order to respect the default Zoom Out bindings for nautilus. All the browsers I use also support the binding so it so it's works out well. Zoom-in doesn't need it for some reason.  


You can try this configuration by running xbindkeys in a terminal. It should daemonize, but will not run on restart. Fedora doesn't have this working with systemd out of the box, so I had to improvise to get this working on login. I made a desktop file in ~/.config/autostart

***~/.config/autostart/xbindkeys.desktop***

~~~ini
  [Desktop Entry]
    Type=Application
    Name=xbindkeys
    Exec=/usr/bin/xbindkeys
    Comment=Autostart xbindkeys for custom mouse/keybindings
    Terminal=false
~~~

I really like this setup. I've also gotten into the habit of pairing the mouse via bluetooth to my desktop computer for a slightly smoother mousing experience compared to the sometimes laggy Unifiying Receiver. Now if only they'd bake in bluetooth with their K800!