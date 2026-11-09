#!/bin/bash

#Start script
cat <<'EOF' > start

#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# BESTMOMEN START - SHARED SCRIPT
# macOS + Windows 11
# ==========================================

PAKET_BESTMOMEN=$(cat "$HOME/.bestmomen/package" 2>/dev/null)

# ==========================================
# CLEAN START TERMUX X11
# ==========================================

echo "Membersihkan sesi lama..."

am force-stop com.termux.x11 2>/dev/null || true

killall -9 termux-x11 Xwayland pulseaudio \
    virgl_test_server_android termux-wake-lock 2>/dev/null || true

sleep 2

export XDG_RUNTIME_DIR="$TMPDIR"

echo "Menjalankan server X11..."

termux-x11 :0 -ac &

sleep 3

echo "Membuka aplikasi Termux:X11..."

am start --user 0 -n \
    com.termux.x11/com.termux.x11.MainActivity

sleep 2

# ==========================================
# START PULSEAUDIO
# ==========================================

pulseaudio --start \
    --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" \
    --exit-idle-time=-1

pacmd load-module module-native-protocol-tcp \
    auth-ip-acl=127.0.0.1 auth-anonymous=1 2>/dev/null || true

# ==========================================
# START VIRGL
# ==========================================

MESA_NO_ERROR=1 \
MESA_GL_VERSION_OVERRIDE=4.3COMPAT \
MESA_GLES_VERSION_OVERRIDE=3.2 \
GALLIUM_DRIVER=virpipe \
virgl_test_server_android --angle-gl >/dev/null 2>&1 &

# ==========================================
# WINDOWS 11 - CUPS + USB
# ==========================================

if [[ "$PAKET_BESTMOMEN" == "win11" ]]; then

    echo "Paket Windows 11 terdeteksi."

    USB_PATH="$(awk '$2 ~ /^\/storage\/[^/]+$/ && $2 != "/storage/emulated" {print $2; exit}' /proc/mounts)"

    if [[ -n "$USB_PATH" && -d "$USB_PATH" ]]; then

        echo "Flashdisk terdeteksi: $USB_PATH"

        proot-distro login debian \
            --user user \
            --shared-tmp \
            --bind "$USB_PATH:/mnt/flashdisk" \
            -- bash -c '
                export DISPLAY=:0
                export PULSE_SERVER=tcp:127.0.0.1

                echo "Mengaktifkan CUPS..."

                if sudo -n service cups start; then
                    echo "CUPS berhasil dijalankan."
                    sleep 2
                    lpstat -t
                else
                    echo "PERINGATAN: CUPS gagal dijalankan."
                    echo "Periksa konfigurasi sudoers."
                fi

                dbus-launch --exit-with-session startxfce4
            '

    else

        echo "Flashdisk tidak terdeteksi."
        echo "Desktop dijalankan tanpa bind USB."

        proot-distro login debian \
            --user user \
            --shared-tmp \
            -- bash -c '
                export DISPLAY=:0
                export PULSE_SERVER=tcp:127.0.0.1

                echo "Mengaktifkan CUPS..."

                if sudo -n service cups start; then
                    echo "CUPS berhasil dijalankan."
                    sleep 2
                    lpstat -t
                else
                    echo "PERINGATAN: CUPS gagal dijalankan."
                    echo "Periksa konfigurasi sudoers."
                fi

                dbus-launch --exit-with-session startxfce4
            '
    fi

else

    # ==========================================
    # MACOS PACKAGE
    # ==========================================

    echo "Paket macOS terdeteksi."

    proot-distro login debian \
        --user user \
        --shared-tmp \
        -- bash -c '
            export DISPLAY=:0
            export PULSE_SERVER=tcp:127.0.0.1

            dbus-launch --exit-with-session startxfce4
        '

fi

# ==========================================
# RETURN TO BESTMOMEN MENU
# ==========================================

echo "Desktop Linux telah dihentikan."
sleep 1

exec zsh


EOF

chmod +x start
#cp start .shortcuts
mv start $PREFIX/bin

#Stop script
cat <<'EOF' > Tutup
#!/bin/bash

pkill -f com.termux.x11

EOF

chmod +x Tutup
cp Tutup .shortcuts
mv Tutup $PREFIX/bin

wget https://raw.githubusercontent.com/gorontaloku/debian/main/files/wib/Setting
chmod +x Setting

wget https://raw.githubusercontent.com/gorontaloku/debian/main/files/wib/setting
chmod +x setting
