### Overview ###
"Building" in this sense means recompiling the uImage kernel and the
initramfs that runs during boot, to set up LVM. If you're interested in
what comes after boot time, this is not the guide for you. Check out the
Arch Linux ARM PKGBUILD Github repository instead.

### WHAT YOU'LL NEED ###
- A Linux Box (x86 or x86_64)

- Git

- Your distro's "uboot-mkimage" or "uboot-envtools" package installed

- CodeSourcery's Toolchain (link below)

- Moboot 0.3.5 or later installed on your TouchPad.
  
### Building ###
First, we'll install the CodeSourcery toolchain.
Second, we'll build the initramfs.
Third, we'll build the kernel.
Finally, we'll boot it.

#### INSTALL CODESOURCERY ####
Download the "IA32 GNU/Linux Installer" here (works on x86_64 just fine):
https://sourcery.mentor.com/sgpp/lite/arm/portal/release1294

"Chmod +x" the file and run it. Install it, using defaults. It should be
placed into /home/youruser/CodeSourcery. Assuming it is, add the "bin"
folder to your PATH with:

    export PATH=/home/youruser/CodeSourcery/Sourcery_G++_Lite/bin:$PATH

Test to see if it works by running "arm-none-eabi-ar". The command
should be found. If not, your PATH is wrong.

#### Get the Kernel Source ####
    git clone https://github.com/CyanogenMod/hp-kernel-tenderloin.git

#### Building the initramfs ####
"better-initramfs" is a simple way to build an initramfs to load LVM
and switch into Arch Linux ARM. See better-initramfs/sourceroot/init
for our init script. Everything in sourceroot gets packed up into the 
initramfs.

To pack up an initramfs, run "make image" from inside the
better-initramfs directory. This will generate a "initramfs.cpio.gz".
Next, move the "initramfs.cpio.gz" file to your kernel directory,
"hp-kernel-tenderloin", and name it "img.gz".

You should now have an `hp-kernel-tenderloin/img.gz` file.

### Patching the Kernel ####
Grab the patches from http://code.google.com/p/touchpad-dev/ and
patch your kernel source in "hp-kernel-tenderloin".

#### Building the Kernel ####
Run the following from within the "hp-kernel-tenderloin" directory:

    make ARCH=arm CROSS_COMPILE=arm-none-eabi- clean
    make ARCH=arm CROSS_COMPILE=arm-none-eabi- mrproper
    make ARCH=arm CROSS_COMPILE=arm-none-eabi- tenderloin_defconfig
    make ARCH=arm CROSS_COMPILE=arm-none-eabi- menuconfig # SEE BELOW!
    make ARCH=arm CROSS_COMPILE=arm-none-eabi- uImage -j5 # number of CPU cores plus 1
    # THE FOLLOWING WILL ONLY WORK AFTER YOU'VE GENERATED A BETTER-INITRAMFS!!!
    mkimage -A arm -O linux -T ramdisk -C none -a 0x60000000 -e 0x60000000 -n "Image" -d ./img.gz arch/arm/boot/uRamdisk
    mkdir modpack
    make ARCH=arm CROSS_COMPILE=arm-none-eabi- modules -j5
    make INSTALL_MOD_PATH=modpack ARCH=arm CROSS_COMPILE=arm-none-eabi- modules_install
    mkimage -A arm -O linux -T ramdisk -C none -a 0x60000000 -e 0x60000000 -n "Image" -d ./img.gz arch/arm/boot/uRamdisk
    mkimage -A arm -O linux -T multi -a 0x40208000 -e 0x40208000 -C none -n "multi image" -d arch/arm/boot/uImage:arch/arm/boot/uRamdisk uImage.ArchLinuxARM
    tar czf ALARM-modpack.tar.gz modpack/lib

For "menuconfig", go to Drivers -> Staging -> Android and enable everything.

Then go to Drivers -> Multimedia and disable everything under V4L. V4L isn't
building so we'll disable it (and the camera won't work).

This will create a file named uImage.ArchLinuxARM. This is the file
you'll copy into your TouchPad's /boot/ directory.

When installing moboot 0.3.5 you'll also need to run:
echo "yes" > /boot/moboot.verbose.ArchLinuxARM

#### Other Goodies ####
For the touchscreen server/driver (ts_srv) and Xorg driver (xf86-video-msm),
see the Arch Linux ARM PKGBUILDs git repository (under "extra"). These
PKGBUILD files are basically human-readable scripts that build packages.
