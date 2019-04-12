---
layout: post
current: post
navigation: false
date: '2019-04-11 23:17 -0400'
class: post-template
sub-class: post
author: superterran
published: true
title: 'Crostini, GPU Acceleration and Steam'
cover: assets/posts/chrome-generic-hero.png
---
With ChromeOS 75 hitting the dev channel, we're starting to see budding 3D support on the Pixel Slate. It's still unstable, and not a lot works with it, but it may be worth playing around with if you're interested in gaming on this great little tablet.

A small primer, ChromeOS has it's own developer shell that you can access by typing `Ctrl+Alt+T`. This opens in a new tab.

If you install Crostini, the Linux subsystem, you should have a command called vmc. If you run `vmc list` you will see a listing of the linux containers, `termina` is an option, if you click on the Terminal icon in your app drawer, this terminal is where you're dropped into.

You can enable gpu support by stopping the running container with `vmc stop termina`, and then `vmc start --enable-gpu termina`. This should drop you into a crostini shell with gpu enablement. Hit `Ctrl-D` to drop from this. At this point, you can launch Terminal or Steam from the App drawer and you should be accelerated.

Supposedly you can confirm this by running `glxinfo -B` and confirming it's using `virgl`. My system hangs on this command, but I will update when it doesn't. 

I've been playing Little Interno as a demo for GPU support, in software rendering this is a very choppy experience, but the touch controls all work great. With 3d support enabled, it runs very smoothly and still with great touch support. With 3D support enabled, Civ 5 finally launches and can play a game, albeit it's very slow. Folks online tell me that their Pixelbook runs Civ 5 well, so I'm hoping it's only a matter of time!
