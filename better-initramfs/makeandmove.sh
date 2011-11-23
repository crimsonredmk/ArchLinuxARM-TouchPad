#!/bin/bash
rm ../hp-kernel-tenderloin/img.gz
make image
mv initramfs.cpio.gz ../hp-kernel-tenderloin/img.gz
