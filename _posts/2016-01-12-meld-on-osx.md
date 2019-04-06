---
title: Meld on OS X
---


Finding a good (free) diff tool is hard for OS X. Here, we'll setup Meld (a popular diff tool on linux) to run with OS X and git. 

First, install a decent Mac build of Meld, there's a few options but here's one I really like: 

https://github.com/yousseb/meld/releases/tag/osx-v1

Once this is installed, you need to make bash script so Meld is command-line executable and can be invoke through git. Name this file 'meld' and place it in a sourced directory that you can run commands from globally. I like to set up a ~/bin directory where I can put scripts like this and magerun so I can run them from anywhere, but you may have a better place for it on your system. You can source a directory by adding the following to the bottom of your ~/.zshrc or ~/.bash_profile:

~~~ bash
export PATH="/Users/User/bin:$PATH"
~~~
Create a 'meld' file in this directory and use the following contents:

***$ cat ~/bin/meld***

~~~ python
  #!/usr/bin/python
  
  import sys
  import os
  import subprocess
  
  if len(sys.argv) > 1:
    left = os.path.abspath(sys.argv[1]);
  else:
    left = ""
  
  if len(sys.argv) > 2:
    right = os.path.abspath(sys.argv[2]);
  else:
    right = ""
  
  if len(sys.argv) > 3:
    merged = os.path.abspath(sys.argv[3]);
  else:
    merged = ""
  
  MELDPATH = "/Applications/Meld.app"
  arguments = " -n " + MELDPATH + " --args " + left + " " + merged + " " + right
  
  p = subprocess.call(['open', '-W', '-a',  MELDPATH, '--args', left, merged, right])
~~~
  And finally, add the following to your ~/.gitconfig
~~~
  [mergetool "meld"]
          cmd = meld \"$LOCAL\" \"$REMOTE\" \"$MERGED\"
          trustexitcode = true
~~~

And give it a shot!
