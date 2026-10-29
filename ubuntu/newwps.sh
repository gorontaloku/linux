#!/data/data/com.termux/files/usr/bin/bash

set -Eeuo pipefail
ARCHIVE_NAME="debianmac.tar.xz"
DOWNLOAD="$HOME/storage/shared/Download"                                                    SHARED="$HOME/storage/shared"                                                               SCRIPT_PATH="$HOME/newwps.sh"
LOG="$HOME/newwps-restore.log"

# GitHub Personal Access Token
while [ -z "${TOKEN:-}" ]; do
    read -r -s -p "Siapa Kamu ?: " TOKEN
    echo

    if [ -z "$TOKEN" ]; then
        echo "Jawab dong!"
    fi
done

trap 'echo ""; echo "GAGAL. File master tidak dihapus. Periksa log: $LOG"' ERR
exec > >(tee -a "$LOG") 2>&1

clear

clear

printf '\033[32;1m'
printf '%s\n' '=============================================================='
printf '\033[33;1m'
printf '%s\n' '██╗    ██╗██████╗ ███████╗                                    '
printf '%s\n' '██║    ██║██╔══██╗██╔════╝                         Created By:'
printf '%s\n' '██║ █╗ ██║██████╔╝███████╗                  Bestmomen Software'
printf '%s\n' '██║███╗██║██╔═══╝ ╚════██║                     Info Pemasangan'
printf '%s\n' '╚███╔███╔╝██║     ███████║                          Hubungi No'
printf '%s\n' ' ╚══╝╚══╝ ╚═╝     ╚══════╝                      0823-1112-3196'
printf '\033[32;1m'
printf '%s\n' '=============================================================='
printf '\033[31;1m%s\033[0m\n' 'Dilarang keras menyebarkan/menjual kembali script ini'
printf '\033[36;1m'
printf '%s\n' '--------------------------------------------------------------'
printf '\033[33;1m'
printf '%s\n' '  Siapkan kopi dan cemilan dulu, yuuk!'
printf '%s\n' '  Proses instal akan segera dimulai.'
printf '\033[0m\n'

while true; do
    read -r -p "  Sudah siap? : " MULAI
    MULAI="${MULAI^^}"
    if [ "$MULAI" = "SIAP" ]; then
        break
    fi
    printf '\033[33;1m%s\033[0m\n' '  Jawab Dong!'
done

clear
printf '\033[32;1m'
printf '%s\n' '=============================================================='
printf '%s\n' '          MEMULAI PROSES INSTAL'
printf '%s\n' '=============================================================='
printf '\033[0m'
sleep 1

termux-setup-storage || true

pkg update -y
pkg install -y x11-repo
pkg install -y termux-x11-nightly pulseaudio dbus
pkg install -y bash proot-distro xz-utils

ARCHIVE=""
for f in "$DOWNLOAD/$ARCHIVE_NAME" "$SHARED/$ARCHIVE_NAME"; do
    if [ -f "$f" ]; then
        ARCHIVE="$f"
        break
    fi
done

if [ -z "$ARCHIVE" ]; then
    echo "ERROR: $ARCHIVE_NAME tidak ditemukan."
    echo "Letakkan arsip di folder Download."
    exit 1
fi

echo "Memeriksa arsip: $ARCHIVE"
xz -t "$ARCHIVE"
tar -tJf "$ARCHIVE" >/dev/null


echo ""
proot-distro list
echo ""
echo "PERINGATAN: Restore dapat mengganti Debian yang sudah ada."
read -r -p "Ketik RESTORE untuk melanjutkan: " jawab
[ "$jawab" = "RESTORE" ] || exit 1

echo "Memulihkan Debian..."
proot-distro restore "$ARCHIVE"

echo "Memeriksa Debian..."
proot-distro login debian -- /usr/bin/env bash -lc \
    'test -f /etc/os-release && cat /etc/os-release'

echo ""
echo "Proses berhasil melewati pemeriksaan."

echo ""
echo "=================================="
echo "Memasang utils.sh"
echo "=================================="

if curl -fsSL \
  -H "Authorization: Bearer $TOKEN" \
  -o "$HOME/utils.sh" \
  "https://raw.githubusercontent.com/gorontaloku/linux/main/ubuntu/utils.sh"; then
    chmod +x "$HOME/utils.sh"
    bash "$HOME/utils.sh" || {
        echo "GAGAL menjalankan utils.sh"
        exit 1
    }
else
    echo "GAGAL mengunduh utils.sh"
    exit 1
fi

echo ""
echo "=================================="
echo "Memasang termux.sh"
echo "=================================="

if curl -fsSL \
  -H "Authorization: Bearer $TOKEN" \
  -o "$HOME/termux.sh" \
  "https://raw.githubusercontent.com/gorontaloku/linux/main/style/termux.sh"; then
    chmod +x "$HOME/termux.sh"
    bash "$HOME/termux.sh" || {
        echo "GAGAL menjalankan termux.sh"
        exit 1
    }
else
    echo "GAGAL mengunduh termux.sh"
    exit 1
fi

echo ""
echo "Restore dan pemasangan script selesai."

echo "File berikut akan dihapus:"
echo "$ARCHIVE"
echo "$DOWNLOAD/newwps.sh"
echo "$SCRIPT_PATH"
read -r -p "Ketik HAPUS untuk menghapus file master: " hapus
if [ "$hapus" != "HAPUS" ]; then
    echo "File master tetap disimpan."
    echo "Instalasi Selesai"
    exit 0
fi

rm -f -- "$ARCHIVE"
rm -f -- "$DOWNLOAD/newwps.sh"
rm -f -- "$SCRIPT_PATH"

echo "Restore selesai. File master telah dihapus."
echo "Log tersimpan di $LOG"
