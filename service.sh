#!/system/bin/sh
#               Copyright (C) 2025  IsHacker
#
#     This Magisk module is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This Magisk module is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.

#Wait for boot completion
sleep 20
# Turn on "Disable HW Overlays" (not working)
service call SurfaceFlinger 1008 i32 1
# Disable Low Memory Killer (LMK)
chmod 666 /sys/module/lowmemorykiller/parameters/minfree
chown root /sys/module/lowmemorykiller/parameters/minfree
echo '0,0,0,0,0,0' > /sys/module/lowmemorykiller/parameters/minfree
#Try to simulate the behavior of MTK engineering mode, which force enables VoLTE (not working; use MTK Engineering mode instead)
setprop persist.radio.vilte_ut_support 1
setprop persist.ims.simulate 1
setprop persist.radio.vilte_downgrade 1
# drmserver is the last thing left of Digital Restrictions Management (DRM) in the ROM, which shall be taken care of by this Magisk module.
watch -n 0.8 killall drmserver -v
