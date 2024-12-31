#!/bin/bash

#Start script
cat <<'EOF' > start
#!/bin/bash

# Start PulseAudio
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1 > /dev/null 2>&1

XDG_RUNTIME_DIR=${TMPDIR} termux-x11 :1.0 & > /dev/null 2>&1
sleep 1

am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

virgl_test_server_android --angle-gl & > /dev/null 2>&1

env DISPLAY=:1.0 GALLIUM_DRIVER=virpipe dbus-launch --exit-with-session startxfce4 & > /dev/null 2>&1

#pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1

# Kill all old processes
killall -9 termux-x11 Xwayland pulseaudio virgl_test_server_android termux-wake-lock


sleep 3


# Log in to proot debian and start the desktop environment. Note that startxfce4 at the end is used to start the XFCE4 desktop.
proot-distro login debian --user user --shared-tmp -- bash -c "export PULSE_SERVER=127.0.0.1 > /dev/null 2>&1 "

EOF

chmod +x start
mv start $PREFIX/bin

#Stop script
cat <<'EOF' > stop
#!/bin/bash

pkill -f com.termux.x11

EOF

chmod +x stop
mv stop $PREFIX/bin



