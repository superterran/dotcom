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

So far, I have used adb to shell in to poke around with bash. Once rooted, you can install [busybox](https://busybox.net/) and use that to install `entware` which can be used to run any number of things. 

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

The version of busybox bundled in the system doesn't work well, so download this one https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-armv7l to your host system and rename to `busybox`, and we'll use `adb push` to update the MyCloud.

On mycloud:

```sh
/system/bin/mount -o rw,remount /
/system/bin/mount -o rw,remount /system
mkdir /opt
mkdir /data/entware.arm
mount -o bind /data/entware.arm /opt
```

On the host system, run the following to push the busybox fil: 
```
adb push /path/to/downloads/busybox /system/bin
```

On mycloud:

```sh
/system/bin/busybox --install /system/bin
/system/bin/mount -o ro,remount /system
/system/bin/mount -o ro,remount /
```

## Modify Crontab

Put volume in RW mode:

`/system/bin/mount -o rw,remount /`


Then edit crontab...

`vi /system/etc/cron/root`

```
*/3 * * * * /system/bin/transmission.sh start
```
Put volume back in RO mode:

`/system/bin/mount -o ro,remount /`



## Setup Samba

To make this thing useful for linux systems, add the following to the bundled samba configuration located at `/data/wd/samba/etc/samba/smb.conf`:

```
[Storage]                                                                       
path = /data/data/com.plexapp.mediaserver.smb/auth0|5ceb23ba2271ff0f67034534                                        
writable = yes                                                                 
guest ok = yes 
```

## Setup Transmission

Install the package...

```sh
/opt/bin/opkg install transmission-daemon-web
```


Create this file in `/system/bin/transmission.sh`

```
#!/system/bin/sh

PIDFILE="/opt/var/run/transmission.pid"

transmission_status ()
{
        [ -f $PIDFILE ] && [ -d /proc/`cat $PIDFILE` ]
}


start()
{
	/opt/bin/transmission-daemon --pid-file=$PIDFILE
        sleep 2
}

stop()
{
        kill `cat $PIDFILE`
}
case "$1" in
        start)
                if transmission_status
                then
                        echo transmission already running
                else
                        start
                fi
                ;;
        stop)
                if transmission_status
                then
                        stop
                else
                        echo transmission is not running
                fi
                ;;
        status)
                if transmission_status
                then
                        echo transmission already running
                else
                        echo transmission is not running
                fi
                ;;

        restart)
                stop
                sleep 3
                start
                ;;
        *)
                echo "Usage: $0 {start|stop|restart|status}"
                ;;
esac
```

Then call with a cron! Need to come up with a better way to run these things!
