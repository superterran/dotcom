---
title: Chromcast Audio to PC Line-in as Multi-room Solution
---


Ever since I've moved into a bigger apartment I've lusted over a multi-room speaker setup so we can play audio everywhere in the house. Google's new Chromecast Audio gives me the makings of this, with the recent update it lets you place Chromecasts in a 'group' where they all play simutaniously. In my house, I made such a group and named it 'Everwhere'. You can play Youtube or Spotify to 'everywhere' and in every room it starts playing (pretty much) in sync. 

I'm cheap though, and the only equipment I was willing to invest in is a couple of Chromecasts. Luckilly, I have computers  in each room with decent speakers. So what I ended up doing was plugging the Chromecast Audio into my PC's line-in and perform some software wizardtry to play the line-in feed through the speakers. This also gives you the ability to tune the system sound and chromecast sound. It's all very trivial in Windows, as Microsoft's supported this kind of thing since the dawn of time. 

To get this working, select 'Listen to this Device' in the Line Out properties:

![Thing to click in Windows 10 to enable Line Out passthrough](/assets/2016/2016-01-10.png)

Getting this to work in Linux (Fedora 23 w/ Gnome 3.18) was a little tricker, but not by much. In my config, there's not a menu option like 'Listen to this Device', but running the following in the terminal enables a 'loopback' device that will play the line-out through your default speaker:

~~~bash
  $ pactl load-module module-loopback
~~~

And boom, it starts working! You may need to tweak the sound settings so this sounds good, but you can control the volue through software and play the chromcast stream mixed with your system audio. It works pretty well, and really completes the solution as far as multi-room sound goes.

But wait, you restarted your box and the settings didn't persist, huh? Well, I have an autostart entry that solves this problem:

In ~/.config/autostart/lineout.desktop

~~~ini 
[Desktop Entry]
  Type=Application
  Name=lineout mods
  Exec=pactl load-module module-loopback
  Comment=pushes line-in to the default out for Chromecast Audio support
  Terminal=false
  OnlyShowIn=GNOME
~~~

The constraint here is that it only starts when logged in. There's probably a better way to invoke this. If I figure it out, i'll be sure to update!

I was also running into some crackling and distortions. To rememdy, I plugged the Chromecast Audio directly into the wall with the supplied USB wall outlet. Apperantly powering from my PC's USB port is no good and was adding a ton of distortions.
