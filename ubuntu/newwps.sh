#!/data/data/com.termux/files/usr/bin/bash
termux-setup-storage || true
clear
set -Eeuo pipefail
DOWNLOAD="$HOME/storage/shared/Download"
SHARED="$HOME/storage/shared"
SCRIPT_PATH="$HOME/newwps.sh"
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

echo ""
echo "=================================="
echo "       PILIH OS"
echo "=================================="

read -r -p "Pilih OS: " pilih

if [ -z "$pilih" ]; then
    echo "Nama OS tidak boleh kosong!"
    exit 1
fi

ARCHIVE_NAME="${pilih}.tar.xz"
ARCHIVE=""

for f in "$DOWNLOAD/$ARCHIVE_NAME" "$SHARED/$ARCHIVE_NAME"; do
    if [ -f "$f" ]; then
        ARCHIVE="$f"
        break
    fi
done

if [ -z "$ARCHIVE" ]; then
    echo "ERROR: File $ARCHIVE_NAME tidak ditemukan."
    echo "Lokasi pencarian:"
    echo "$DOWNLOAD"
    echo "$SHARED"
    exit 1
fi

echo ""
echo "File ditemukan: $ARCHIVE"

clear
printf '\033[32;1m'
printf '%s\n' '=============================================================='
printf '%s\n' '          MEMULAI PROSES INSTAL'
printf '%s\n' '=============================================================='
printf '\033[0m'
sleep 1

#termux-setup-storage || true

pkg update -y
pkg install -y x11-repo
pkg install -y termux-x11-nightly pulseaudio dbus
pkg install -y bash proot-distro xz-utils
pkg install -y wget git

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
echo "PERINGATAN: Proses Ini Dapat Mengganti Isi Termux Yang Sudah Ada."
read -r -p "Ketik LANJUT untuk melanjutkan: " jawab
[ "$jawab" = "LANJUT" ] || exit 1

echo "Proses Sedang Berlangsung..."
proot-distro restore "$ARCHIVE"

echo "Memeriksa Proses..."
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
echo "ProsesInstall Telah selesai."


echo ""
echo "=================================="
echo "Menyiapkan Fitur Print Bestmomen"
echo "=================================="

# Paket Termux yang dibutuhkan untuk Print Watcher
pkg install -y inotify-tools termux-tools procps

# Folder konfigurasi paket
mkdir -p "$HOME/.bestmomen"
echo "win11" > "$HOME/.bestmomen/package"

# Folder pekerjaan print
PRINT_DIR="$HOME/PrintBestmomen/jobs"
mkdir -p "$PRINT_DIR"

# Membuat Print Watcher
cat > "$HOME/PrintBestmomen/watch-print.sh" <<'WATCHER'
#!/data/data/com.termux/files/usr/bin/bash

DIR="$HOME/storage/shared/PrintBestmomen/jobs"
PDF="$DIR/output.pdf"

mkdir -p "$DIR"

echo "Bestmomen Print Watcher aktif."
echo "Memantau: $PDF"

inotifywait -m -q -e close_write,moved_to --format '%f' "$DIR" |
while IFS= read -r FILE; do
    if [[ "$FILE" == "output.pdf" ]]; then
        echo "PDF selesai dibuat: $PDF"
        sleep 2

        if [[ -s "$PDF" ]]; then
            echo "Membuka NokoPrint..."
            termux-open --view "$PDF"
        else
            echo "PDF belum tersedia atau kosong."
        fi
    fi
done
WATCHER

chmod +x "$HOME/PrintBestmomen/watch-print.sh"

echo "Konfigurasi Print Watcher selesai."


# Tandai instalasi sebagai paket Windows 11 BESTMOMEN
mkdir -p "$HOME/.bestmomen"
echo "win11" > "$HOME/.bestmomen/package"

echo ""
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

echo "Sukses Yaa."
echo "Log tersimpan di $LOG"
