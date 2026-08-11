#!/bin/sh
# console-setup.sh — one-time TTY setup for Debian
# Sets: purple palette, VGA font, capslock -> control
# Run once with: sudo sh console-setup.sh

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Run me with sudo:  sudo sh $0" >&2
    exit 1
fi

# --- 1. Console font (DejaVu 20x36) ------------------------------------
# Persisted in /etc/default/console-setup, applied by the console-setup svc.
# Terminus at 20x36 is the largest chunky bitmap face;
FONT_FILE=/usr/share/consolefonts/Lat15-VGA32x16.psf.gz
if [ ! -f "$FONT_FILE" ]; then
    echo "VGA 16x32 font not found at $FONT_FILE."
    echo "Install it with:  sudo apt install xfonts-terminus console-setup"
    echo "Available terminus fonts:"
    ls /usr/share/consolefonts/ | grep -i terminus || true
    echo "Edit FONT_FILE in this script to match, then rerun."
    exit 1
fi

# console-setup uses FONTFACE + FONTSIZE rather than a raw path.
sed -i 's/^FONTFACE=.*/FONTFACE="VGA"/' /etc/default/console-setup
sed -i 's/^FONTSIZE=.*/FONTSIZE="16x32"/'        /etc/default/console-setup
grep -q '^FONTFACE=' /etc/default/console-setup || echo 'FONTFACE="VGA"' >> /etc/default/console-setup
grep -q '^FONTSIZE=' /etc/default/console-setup || echo 'FONTSIZE="16x32"'        >> /etc/default/console-setup
echo "Font set to VGA 16x32."

# --- 2. Capslock -> Control ----------------------------------------------
# Done via /etc/default/keyboard XKBOPTIONS — the safe, persistent way.
# (This is what broke before: loadkeys at runtime is fragile. This isn't.)
if grep -q '^XKBOPTIONS=' /etc/default/keyboard; then
    sed -i 's/^XKBOPTIONS=.*/XKBOPTIONS="ctrl:nocaps"/' /etc/default/keyboard
else
    echo 'XKBOPTIONS="ctrl:nocaps"' >> /etc/default/keyboard
fi
echo "Capslock remapped to Control."

# --- 3. Purple palette ----------------------------------------------------
# Palette can't live in console-setup; we write a tiny profile script that
# emits the escape codes only on a real VT. This is the ONE per-login piece,
# but it's pure cosmetic escape codes — no root, no loadkeys, nothing fragile.
cat > /etc/profile.d/console-palette.sh <<'EOF'
case "$(tty)" in
  /dev/tty[0-9]*)
    printf '\033]P0000000'   # 0 
    printf '\033]P8a433c4'   # 8 
    printf '\033]P1874474'   # 1 
    printf '\033]P9888888'   # 9 
    printf '\033]P2999999'   # 2 
    printf '\033]PAaaaaaa'   # A 
    printf '\033]P39543aa'   # 3 // comments and ... 
    printf '\033]PB999999'   # B 
    printf '\033]P4aa3391'   # 4 
    printf '\033]PCdd33bb'   # C 
    printf '\033]P5664466'   # 5 // mini buffer and search
    printf '\033]PD774477'   # D 
    printf '\033]P6641686'   # 6 //
    printf '\033]PE999999'   # E 
    printf '\033]P7aaaaaa'   # 7 
    printf '\033]PFbb99ba'   # F 
    printf '\033\014'         # repaint
    ;;
esac
EOF
chmod +x /etc/profile.d/console-palette.sh
echo "Purple palette installed to /etc/profile.d/."

# --- apply now without reboot --------------------------------------------
setupcon --force 2>/dev/null || true

echo
echo "Done. Font + capslock take effect now (or after a reboot to be safe)."
echo "Palette applies on your next console login."
