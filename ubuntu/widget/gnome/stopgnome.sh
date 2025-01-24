cat <<'EOF' > stop
#!/bin/bash

pkill -f com.termux.x11

EOF

chmod +x stop
mv stop $PREFIX/bin
