---
layout: post
current: post
navigation: false
date: '2019-06-01 15:00 -0400'
tags:
  - ''
  - demo
class: post-template
sub-class: post
author: superterran
published: true
title: WD MyCloud Home
cover: assets/posts/My_Cloud_Home_Lifestyle_1.0.jpg
---
[Jaja's Guide](https://community.wd.com/t/install-entware-on-wd-my-cloud-home-ssh-access-nfs-server-opkg-install-packages/228591/18)

So far this hasn't been the worst device. It's oftentimes provides snappy file transfers (but not always), has plex built in (which I haven't really used so far), and has some cool cloud integrations. The downside is it's utter lack for Linux support. Luckilly, under the hood this thing is running Android and we can pretty easily root it and add a few things.


# Managing the Device

## Enabling Root

This requires physical access to the drive, so you'll probably be voiding your warrentey as you tear this thing apart. It's a nesting dool mess of plastic, so good luck not scratching the case.

https://www.youtube.com/watch?v=CfLzUWs6R1c

Once dissembled, plug the drive into a Linux system, my system mounted the volumes automatically once they were detected.

Later, once you can use adb to shell into the running device, you'll find a /system directory with a build.prop file we need to modify. Find the mounted volume the coorosponds with `/dev/block/sataa19/` which we'll call `/run/media/me/sataa19` but will be different on your computer. Run `df -h` to see what mounted volumes to find the mount point. In this directory, edit the `build.prop` file and all the following to the top of the file:

```
persist.sys.usb.config=adb
ro.debuggable=1
ro.secure=0
```

On volume `/dev/block/sataa18/`...
* delete file  `disable_adb`
* create file `enable_root` 

At this point, you should be able to use adb to gain root access over the network. You can unplug the drive from the computer, and probably put your drive back together. 

## Getting a Terminal once Root is Enabled

In my router, I configured a router rule that provides a symbolic hostname so I don't have to remember the IP address:

![d2wZQeiIDU.png](/assets/posts/d2wZQeiIDU.png)

```sh
adb connect mycloud # or `adb connect 192.168.1.222`
adb root 
adb shell

```

## Install Busybox

## Setup Samba

## Setup Transmission
