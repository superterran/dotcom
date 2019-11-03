---
title: WD My Cloud Home
date: 2019-06-01 19:00:00 Z
layout: post
current: post
navigation: false
tags:
- ''
- demo
class: post-template
sub-class: post
author: superterran
cover: assets/posts/My_Cloud_Home_Lifestyle_1.0.jpg
---

WD's My Cloud Home is not a traditional NAS, but it does provide some good cloud integrations that provide some nicieties in Windows and Mac. It also has WD Red NAS drives inside, and a fairly powerful ARM chip. It's also far quieter than it's predesseor, a slip Dell Optiplex of yester-year I named Closet. So far, this hasn't been the worst device. It's oftentimes provides snappy file transfers at around 90-110MBps. Sometimes it goes 10-20MBps, but at it's slowest it's still faster than the optiplex at it's fastest. It also has  plex built in, which seems to work well and quickly replaced Closet's plex library. The downside is it's utter lack for Linux support. Luckilly, under the hood this thing is running Android and we can pretty easily root it and add a few things. Let's see if we can turn this thing into a proper NAS.

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


Seems like Transmission doesn't have the space to work in it's default directory, let's put it in a more roomy spot...

```sh
/system/bin/transmission.sh stop
mv /opt/etc/transmission /data/wd/diskVolume0/
ln -s /data/wd/diskVolume0/transmission /opt/etc/transmission
/system/bin/transmission.sh start
```

## RClone

Very annoyingly, most of the drive's volumes don't have enough space to really install anything. I had to get a bit creative to install rclone.

```sh
 cd /data/wd/diskVolume0/
 mkdir rclone
 cd rclone
 curl https://downloads.rclone.org/v1.47.0/rclone-v1.47.0-linux-arm.zip > rclone.zip
 unzip rclone.zip
 /system/bin/mount -o rw,remount /
 /system/bin/mount -o rw,remount /system
 ln -s /data/wd/diskVolume0/rclone/rclone-v1.47.0-linux-arm/rclone /system/bin/rclone
 /system/bin/mount -o ro,remount /system
 /system/bin/mount -o ro,remount /
```

Once you install it, you can configure it with the following...

```sh
rclone config
```

On my system this won't save a file because everything is out of space, so take the outputted contents of the config file, and paste it into `/data/wd/diskVolume0/rclone/rclone.config`


```sh
rclone --config /data/wd/diskVolume0/rclone/rclone.config lsd remote:
rclone --config /data/wd/diskVolume0/rclone/rclone.config 
rclone --config /data/wd/diskVolume0/rclone/rclone.config sync /data/data/com.plexapp.mediaserver.smb/auth0\|5ceb23ba2271ff0f67034534 remote:superterran-mycloud
```

Then edit crontab to automate it...

`vi /system/etc/cron/root`

```
0 0 * * 0 rclone --config /data/wd/diskVolume0/rclone/rclone.config sync /data/data/com.plexapp.mediaserver.smb/auth0\|5ceb23ba2271ff0f67034534 remote:superterran-mycloud
```


## References

* [Juju's Guide](https://community.wd.com/t/install-entware-on-wd-my-cloud-home-ssh-access-nfs-server-opkg-install-packages/228591/18)
