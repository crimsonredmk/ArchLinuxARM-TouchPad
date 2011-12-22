- Enable developer mode with "webos20090606" in the Just Type Box. Use no password.

- "novaterm" into the device from your desktop with the webOS SDK installed.

- Run the following line by line, carefully, in novaterm connected to your TouchPad.

        mount -o rw,remount /boot
        cd /tmp
        curl -O http://moboot.googlecode.com/files/moboot_0.3.5.zip
        unzip moboot_0.3.5.zip
        mv uImage.moboot_0.3.5 /boot/uImage.moboot
        cd /boot
        rm uImage
        ln -s uImage.moboot uImage
        ln -s uImage-2.6.35-palm-tenderloin uImage.webOS
        echo "yes" > moboot.verbose.ArchLinuxARM
        sync
        curl -O http://archlinuxarm.org/mirror/touchpad/uImage.ArchLinuxARM
        cd /tmp
        pkill -SIGUSR1 cryptofs
        umount /media/internal
        echo "STOP HERE AND READ 'RESIZE FAT' BEFORE CONTINUING" # See below
        resizefat /dev/store/media ****M
        lvm.static lvresize -L -4096M /dev/store/media
        lvm.static lvcreate -L 4096M -n arch-root store
        mkfs.ext3 /dev/store/arch-root
        mkdir linux
        mount /dev/store/arch-root linux
        cd linux
        curl -O http://archlinuxarm.org/mirror/touchpad/ArchLinuxARM-touchpad-latest.tar.gz
        tar xzf ArchLinuxARM-touchpad-latest.tar.gz # Will take a long time
        rm ArchLinuxARM-touchpad-latest.tar.gz
        cd ..
        umount linux
        reboot # The first few times, this may error out - try again

### Resizing FAT webOS partition ###
To make room on your TouchPad for Arch Linux ARM, you need to take away space from the USB partition (FAT or /media/interal).

Run the following to get the currect size of your FAT partition. Then, subtract the number of megabytes you want to use for Arch Linux ARM.

This number will give you the remaining size of the FAT partition. The resizefat command will make sure no files are lost.

    lvm.static lvdisplay -c store/media | awk -F: '{print $7/2048}'

The 4096MB values for lvm.static above are arbitrary - you'll need at least 2GB (2048MB) to enjoy Arch Linux ARM.

Also, make sure you leave some space for FAT. webOS and webOS applications use it.