---
title: Linux on Dell XPS 15 
---
I'm blassed with a job that's actively looking to step up their hardware game. So after a few nights of googling, I went to our IT guy and I was able to pursuade him to order the new [Dell XPS 15 Non-touch 9550 P56F](http://www.dell.com/us/business/p/xps-15-9550-laptop/pd?oc=cax15w10s1630&model_id=xps-15-9550-laptop). My model has a Intel Core i7-6700HQ with 16GB of DDR4 RAM and a 512gb SSD on a PCI-e bus. Sickeningly awesome system. It hangs with my MBP but I still miss the trackpad. The MBP feels better and is less plastically, but the internals are better on the Dell side, and while it's a little thicker than the MBP, it's hardly noticable and Dell hides it pretty well. 

It's a good Linux laptop. Running Fedora 23 (I'll cover Ubuntu in a new post when work forces my hand to install it), it pretty much works entirely out of the box. Battery life *seems* roughly comparable to my MBP, but we'll see how that pans out as I use it. 

My thoughts so far: 

* Wireless: The Broadcom Wireless AC works well out of the gate. it connects to my 5GHz network, reconnects after standby, and seems speedy and reliable.  
* Bluetooth: Scans, seemingly works
* Battery: Gnome reports 4-6 hours at 100% depending... so far so good
* UEFI: Was able to perform the UEFI install and everything worked, did not try Secure Boot. Was having issues with hibernation in UEFI, might be user error. Regardless currently running in Legacy Mode.
* Suspend: Standby works reliably, wifi reconnects. Hibernation is a little flakier, tried configuring for hybrid-sleep, but couldn't't get it to suspend but it would save RAM to disk and resume from hibernation
* Touchpad: Multitouch works! It's very poorly configured, and I haven't had much luck taming it, but with touchegg I'm able to do two finger right click, four finger swipe to show the activities menu... but I haven't had a lot of luck improving on that, must be a software thing because the touchpad seems well supported by the OS.

i still need to test a few things, and would like to get a better measure on the battery life. I'm interested to get the [Dell Thunderbolt 3 Dock](http://amzn.com/B01C8PHW32) and see how that goes. Like the Surface Dock, it gives you one cable that charges the laptop and provides dual-head monitors, USB, Ethernet and everything.
