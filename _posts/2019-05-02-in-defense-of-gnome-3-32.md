---
layout: post
current: post
navigation: false
date: '2019-05-02 21:55 -0400'
class: post-template
sub-class: post
author: superterran
published: false
title: In Defense of GNOME 3.32
cover: assets/posts/gnome332-816x345.jpg
---
It's fair to say gnome-shell is, and always has been, polarizing. There's folks like me who love it and think it's picked up Apple's mantle of driving the workstation desktop. There are others who see it as a spartan waste of good screen realestate. These two perspectives are at odds, and the GNOME community has gained a reputation for dismissing the latter and shoving the former down everyones throats. If you spend a few minutes appreciating the GNOME design philosophy or flipping through their [Human Interface Guidelines](https://developer.gnome.org/hig/stable/), they are on on the right track here.  

I came across [this critique of GNOME](https://jatan.tech/2019/05/01/gnome-3-32-is-awesome-but-still-has-key-areas-for-improvements/) the other day on Reddit. What's been interesting is that the GNOME reddit community has been very supportive of the article, even prompting discussion within the GNOME team about interface changes. When I read the article, I thought he was far off the mark. 

They might not have had threaded multi-tasking in Windows 95, but the the GUI concepts it introduced still hang around today. The icon-covered desktop is a good example. My father, from the moment he installed Windows 95, til this day running Mojave, has more desktop icons than desktop realestate. The Desktop also becomes a dumping ground for any and every file, the ever present drop point for everything you drag. 'Create A Document' features lead to a sea of `New Text Document (x).docx`. Sometimes, what seems like a feature is really a curse. 

The icon-laden desktop, which seems like a convenience, actually encourages disorganization. GNOME is a general purpose desktop environment, I sometimes use it on a laptop screen where I typically have a single maximized window. Sometimes dock it to my desktop ultra-wide monitor, where I'll have multiple windows overlaping against the desktop background. Do I really want ugly icons poking out behind my windows, burning into my screen? 

GNOME solves the icon clutter by simply removing desktop icons altogther, and adopting a more mobile-like aproach around the activities menu which is an overlay you can trigger with the Windows key, or a trackpad gesture, or touching the top-left corner with your mouse cursor. There you will find a Dock, a full screen applications menu, and a virual desktop manager. Pretty much everything you could ask for in a DE. Except for the one issue the article didn't address, the sobering lack of transluceny and color in the core desktop experience. Microsoft and Apple infuses the background color into their UX, Adawata chose an off-grey color to nod to that effect. GNOME needs to start delivering the goods here.

Another real pain-point with gnome-shell is how it's constantly fumbling notifications. Earlier releases of Gnome Shell, the 3.6's and  3.8's had a notification shelf on the bottom of the screen that was reminisent 
of Chat Heads and honestly one of the best notification implementations I've used. 

![chat-bubble.png]({{site.baseurl}}/assets/posts/chat-bubble.png)

It's since devolved into a something, I can hardly explain what at this point. 3.8 notifications were deserving of a better Chat app than Empathy. Perhaps Slack and Hipchat killed that momentum. Maybe they're back at the drawing board remaking it into a Macos/Windows-like Notification center that flies out from the right of the screen. 

Notifications spoke to a real problem, messages and notifications should be a first-class citizen, and application agnostic. This is the GNOME way, take the problems of yesteryear - namely that notifications in Empathy and programs like Xchat and Pidgin were a mess, and implement a DE-level solution as eloquently as possible. You still see this thinking everywhere with GNOME> Just open GNOME Boxes and compare it to Virtualbox. Look at how minimal the Files app is. With chat they fell short, but I'm sure they'll try again.

I have used GNOME for a long time, the lesson I learned when I decided to stop evaluating desktops was that desktop environments were generally short-sighted and will put a ton of effort in what amounts to dumb frivilous features and visual crap. When the parent DE shifts, it all gets thrown away, or worse, locked in place never to get upstream updates again. GNOME is a project that wants to shed old ideas, most desktop environments wants to collect them and package them as a greatest hits collection. That might appeal to some, but I prefer a desktop that's thinking these things through.