*This is a quick-start guide for people in a hurry who just want to run
Arch Linux ARM on their HP TouchPad.*

*If you're interested in building everything from the ground up, see "Building.md".*

### Credits ###
- jcsullins and everyone from moboot
- jeanfrancisroy from Funtoo, for making LVM work
- s7mx1 from XDA for this post: http://forum.xda-developers.com/showthread.php?t=1332629
- slashbeast for the basis of the ALARM initramfs: https://github.com/slashbeast/better-initramfs

### Installation ###
See "Installation.md" for step-by-step instructions. Make sure you have the webOS SDK with novacom/novaterm installed.

### Todo ###
- Fix V4L2 building in the kernel so the camera will work
- Fix ALSA and sound
- Make Bluetooth work (and then fix the mouse pointer hiding)
- Enable compositing so Gnome Shell will work
- Matchbox-keyboard does not autostart, maybe it can be replaced with a better keyboard as well?

### FAQ ###
- **What are the passwords for root/su/sudo?**

  Following the username:password convention: root:root and linux:linux.

- **How do I force reboot the TouchPad?**

  Hold the top button and center button for about 15 seconds, or use the usual "sudo reboot" command.  

- **How do I remove Arch Linux ARM/Android/CyanogenMod?**

  Back on webOS, run the command "lvm" from novaterm. From there, the command "lvs"
  shows the logical volumes. Delete any you don't want, e.g. archlinuxarm or cm-data, etc.
  by running "lvremove store/name-of-volume". Then, resize your media partition with
  "lvresize -L +90000M store/media" (this will make "media" as big as possible).
  
- **How can I help?**

  Right now, installing and testing the alpha would be nice. Getting things crossed off the Todo list
  is what we really need though. Join us in #archlinuxarm on irc.freenode.net as well.