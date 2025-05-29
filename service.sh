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
# Set CPU frequency and governor
for i in `seq 0 3`; do
    chmod 0644 /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor
    echo "performance" > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor
    chmod 0644 /sys/devices/system/cpu/cpu$i/cpufreq/scaling_min_freq
    echo "1248000" > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_min_freq
done
# Power-efficient workqueues
chmod 0644 /sys/module/workqueue/parameters/power_efficient
echo 'Y' > /sys/module/workqueue/parameters/power_efficient
# Increase RQ affinity (improves disk R/W speed)
echo '2' > /sys/block/mmcblk0/queue/rq_affinity
echo '2' > /sys/block/mmcblk1/queue/rq_affinity
# Set GPU frequency
echo "650000" > /proc/gpufreq/gpufreq_opp_freq
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
