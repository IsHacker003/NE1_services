#!/system/bin/sh
# Set SELinux to Permissive mode
setenforce 0
# Turn on "Disable HW Overlays" (not working)
service call SurfaceFlinger 1008 i32 1
# drmserver is the last thing left of Digital Restrictions Management (DRM) in the ROM, which shall be taken care of by this Magisk module.
watch -n 0.8 killall drmserver -v
