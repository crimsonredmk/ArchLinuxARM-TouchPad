- Enable developer mode with "webos20090606" in the Just Type Box. Use no password.

- "novaterm" into the device from your desktop with the webOS SDK installed.

- Run the following, line by line:
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
        resizefat /dev/store/media ****M #(See "Finding FAT Size" below right now!)
        lvm.static lvresize -L -4096M /dev/store/media
        lvm.static lvcreate -L 4096M -n arch-root store
        mkfs.ext3 /dev/store/arch-root
        mkdir linux
        mount /dev/store/arch-root linux
        cd linux
        curl -O http://archlinuxarm.org/mirror/touchpad/ArchLinuxARM-armv7h-tenderloin-alpha1.tar.gz
        tar xzf ArchLinuxARM-armv7h-tenderloin-alpha1.tar.gz # Will take a long time
        rm ArchLinuxARM-armv7h-tenderloin-alpha1.tar.gz
        cd ..
        umount linux
        reboot # The first few times, this may error out - try again
