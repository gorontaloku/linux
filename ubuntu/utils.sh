#!/bin/bash

#Start script
cat <<'EOF' > start

#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# BESTMOMEN START - SHARED SCRIPT (OPTIMIZED)
# macOS + Windows 11
# ==========================================

PAKET_BESTMOMEN=$(cat "$HOME/.bestmomen/package" 2>/dev/null)

T0=$(date +%s)
ts() { printf '[%2ss] %s\n' "$(( $(date +%s) - T0 ))" "$*"; }

export XDG_RUNTIME_DIR="$TMPDIR"
XSOCK="$TMPDIR/.X11-unix/X0"
XLOG="$TMPDIR/termux-x11.log"
INNER="$TMPDIR/xfce-inner.sh"
CUPS_FLAG="$TMPDIR/.cups-on"

# ==========================================
# 1. BERSIHKAN SESI LAMA
# ==========================================

ts "membersihkan sesi lama..."
am force-stop com.termux.x11 2>/dev/null || true
killall -9 termux-x11 pulseaudio virgl_test_server_android \
    termux-wake-lock 2>/dev/null || true
rm -f "$XSOCK" "$XSOCK-lock"
rm -rf "$TMPDIR/.X11-unix"
mkdir -p "$TMPDIR/.X11-unix"

termux-wake-lock >/dev/null 2>&1 || true

# ==========================================
# 2. SERVER X11 + APP (PARALEL)
# ==========================================

ts "menjalankan server X11..."
termux-x11 :0 -ac -nolisten tcp >"$XLOG" 2>&1 &
XPID=$!

ts "membuka aplikasi Termux:X11..."
am start --user 0 -n \
    com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1 &

for _ in $(seq 1 300); do
    [ -S "$XSOCK" ] && break
    kill -0 "$XPID" 2>/dev/null || break
    sleep 0.05
done

if [ ! -S "$XSOCK" ]; then
    ts "GAGAL: socket X tidak muncul"
    cat "$XLOG"
    exit 1
fi
ts "X server siap"

# ==========================================
# 3. START PULSEAUDIO (NON-BLOCKING)
# ==========================================

(
    pulseaudio --start --exit-idle-time=-1 >/dev/null 2>&1
    for _ in $(seq 1 15); do
        pactl load-module module-native-protocol-tcp \
            auth-ip-acl=127.0.0.1 auth-anonymous=1 >/dev/null 2>&1 && break
        sleep 0.2
    done
) &

# ==========================================
# 4. START VIRGL
# ==========================================

MESA_NO_ERROR=1 \
MESA_GL_VERSION_OVERRIDE=4.3COMPAT \
MESA_GLES_VERSION_OVERRIDE=3.2 \
GALLIUM_DRIVER=virpipe \
virgl_test_server_android --angle-gl >/dev/null 2>&1 &

# ==========================================
# 5. SCRIPT SESI DI DALAM DEBIAN
# ==========================================

{
    cat <<'INNER'
export DISPLAY=:0
export PULSE_SERVER=tcp:127.0.0.1:4713

# ---- INI YANG MEMOTONG DELAY 25-50 DETIK ----
export NO_AT_BRIDGE=1
export GTK_A11Y=none
export QT_ACCESSIBILITY=0
export XDG_RUNTIME_DIR=/tmp/runtime-$(id -u)
mkdir -p "$XDG_RUNTIME_DIR" 2>/dev/null
chmod 700 "$XDG_RUNTIME_DIR" 2>/dev/null

if [ ! -s /var/lib/dbus/machine-id ]; then
    mkdir -p /var/lib/dbus
    dbus-uuidgen > /var/lib/dbus/machine-id 2>/dev/null
fi
[ -s /etc/machine-id ] || cp /var/lib/dbus/machine-id /etc/machine-id 2>/dev/null

rm -f /tmp/.X0-lock 2>/dev/null

if [ -f /tmp/.cups-on ]; then
    (
        if sudo -n service cups start >/tmp/cups.log 2>&1; then
            echo "CUPS berhasil dijalankan." >>/tmp/cups.log
        else
            echo "PERINGATAN: CUPS gagal dijalankan." >>/tmp/cups.log
            echo "Periksa konfigurasi sudoers." >>/tmp/cups.log
        fi
        lpstat -t >>/tmp/cups.log 2>&1
    ) &
fi

if command -v dbus-run-session >/dev/null 2>&1; then
    exec dbus-run-session -- startxfce4
else
    exec dbus-launch --exit-with-session startxfce4
fi
INNER
} > "$INNER"

# ==========================================
# 6. JALANKAN DESKTOP
# ==========================================

run_desktop() {
    local usb_path="${1:-}"
    local -a extra=()
    [ -n "$usb_path" ] && extra=(--bind "$usb_path:/mnt/flashdisk")

    proot-distro login debian \
        --user user \
        --shared-tmp \
        "${extra[@]}" \
        -- bash /tmp/xfce-inner.sh
}

if [[ "$PAKET_BESTMOMEN" == "win11" ]]; then

    echo "Paket Windows 11 terdeteksi."
    touch "$CUPS_FLAG"

    USB_PATH="$(awk '$2 ~ /^\/storage\/[^/]+$/ && $2 != "/storage/emulated" {print $2; exit}' /proc/mounts)"

    if [[ -n "$USB_PATH" && -d "$USB_PATH" ]]; then
        echo "Flashdisk terdeteksi: $USB_PATH"
        run_desktop "$USB_PATH"
    else
        echo "Flashdisk tidak terdeteksi."
        echo "Desktop dijalankan tanpa bind USB."
        run_desktop
    fi

else

    echo "Paket macOS terdeteksi."
    rm -f "$CUPS_FLAG"
    run_desktop

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
