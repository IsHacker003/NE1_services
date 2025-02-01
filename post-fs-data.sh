#!/system/bin/sh
# Set SELinux to Permissive mode (to fix Developer Options crash)
setenforce 0
#Wait for boot completion
sleep 100
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
