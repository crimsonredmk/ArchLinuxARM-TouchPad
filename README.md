*This is a quick-start guide for people in a hurry who just want to run
Arch Linux ARM on their HP TouchPad.*

*If you're interested in building everything from the ground up, see "Building.md".*

### Credits ###
- jcsullins and everyone from moboot
- jeanfrancisroy from Funtoo, for making LVM work
- s7mx1 from XDA for this post: http://forum.xda-developers.com/showthread.php?t=1332629
- slashbeast for the basis of the ALARM initramfs: https://github.com/slashbeast/better-initramfs

### Quick Start ###
#### You will need: ####
- A TouchPad
- A USB micro cable
- HP's webOS SDK installed (with novacom and novaterm)
- To read the whole guide before starting

#### Installation ####
See "Installation.md" for step-by-step instructions.

### Todo ###
- Fix V4L2 building in the kernel so the camera will work
- Fix ALSA and sound
- Work on the touch support
- Enable compositing so Gnome Shell will work
- Matchbox-keyboard does not autostart, maybe it can be replaced with a better keyboard as well?

### FAQ ###
- **What are the passwords for root/su/sudo?**

  Following the username:password convention: root:root and linux:linux.

- **What does uImage.ArchLinuxARM do?**

  uImage.ArchLinuxARM is a kernel and minimal environment to boot Arch Linux ARM, compatible with moboot 0.3.5 and up.

- **How do I force reboot the TouchPad?**

  Hold the top button and center button for about 15 seconds, or use the usual "sudo reboot" command.

- **How do I remove Arch Linux ARM/Android/CyanogenMod?**

  Back on webOS, run the command "lvm" from novaterm. From there, the command "lvs"
  shows the logical volumes. Delete any you don't want, e.g. archlinuxarm or cm-data, etc.
  by running "lvremove store/name-of-volume". Then, resize your media partition with
  "lvresize -L +90000M store/media" (this will make "media" as big as possible).