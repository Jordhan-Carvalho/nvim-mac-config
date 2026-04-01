#!/usr/bin/env bash
set -e

FONT_CASK="font-jetbrains-mono-nerd-font"
FONT_NAME="JetBrainsMono Nerd Font"
FONT_POSTSCRIPT="JetBrainsMono-Regular-Nerd-Font-Complete"

info()    { echo "[info]  $*"; }
success() { echo "[ok]    $*"; }
warn()    { echo "[warn]  $*"; }
die()     { echo "[error] $*" >&2; exit 1; }

# ── install font via homebrew ──────────────────────────────────────────────────
install_font() {
  command -v brew &>/dev/null || die "Homebrew not found. Install it from https://brew.sh"

  if brew list --cask "$FONT_CASK" &>/dev/null; then
    info "$FONT_NAME already installed — skipping."
  else
    info "Installing $FONT_NAME via Homebrew..."
    brew tap homebrew/cask-fonts 2>/dev/null || true
    brew install --cask "$FONT_CASK"
    success "Font installed."
  fi
}

# ── configure iTerm2 ───────────────────────────────────────────────────────────
configure_iterm2() {
  local plist="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
  if [ ! -f "$plist" ]; then
    return 1
  fi

  info "Configuring iTerm2 font..."
  # Write font preference via defaults — sets the Normal font for the Default profile
  /usr/libexec/PlistBuddy \
    -c "Set :\"New Bookmarks\":0:\"Normal Font\" \"$FONT_NAME Mono 13\"" \
    "$plist" 2>/dev/null || \
  /usr/libexec/PlistBuddy \
    -c "Add :\"New Bookmarks\":0:\"Normal Font\" string \"$FONT_NAME Mono 13\"" \
    "$plist" 2>/dev/null || true

  # Also set Non-ASCII font
  /usr/libexec/PlistBuddy \
    -c "Set :\"New Bookmarks\":0:\"Non Ascii Font\" \"$FONT_NAME Mono 13\"" \
    "$plist" 2>/dev/null || \
  /usr/libexec/PlistBuddy \
    -c "Add :\"New Bookmarks\":0:\"Non Ascii Font\" string \"$FONT_NAME Mono 13\"" \
    "$plist" 2>/dev/null || true

  success "iTerm2 configured. Restart iTerm2 to apply."
  return 0
}

# ── configure Kitty ────────────────────────────────────────────────────────────
configure_kitty() {
  local conf="$HOME/.config/kitty/kitty.conf"
  if [ ! -f "$conf" ] && ! command -v kitty &>/dev/null; then
    return 1
  fi

  info "Configuring Kitty font..."
  mkdir -p "$HOME/.config/kitty"

  if grep -q "^font_family" "$conf" 2>/dev/null; then
    sed -i '' "s|^font_family.*|font_family      $FONT_NAME|" "$conf"
  else
    echo "font_family      $FONT_NAME" >> "$conf"
  fi

  if grep -q "^font_size" "$conf" 2>/dev/null; then
    sed -i '' "s|^font_size.*|font_size        13.0|" "$conf"
  else
    echo "font_size        13.0" >> "$conf"
  fi

  success "Kitty configured. Reload with Ctrl+Shift+F5."
  return 0
}

# ── configure Alacritty ────────────────────────────────────────────────────────
configure_alacritty() {
  local conf="$HOME/.config/alacritty/alacritty.toml"
  local conf_old="$HOME/.config/alacritty/alacritty.yml"

  if [ ! -f "$conf" ] && [ ! -f "$conf_old" ] && ! command -v alacritty &>/dev/null; then
    return 1
  fi

  info "Configuring Alacritty font..."
  mkdir -p "$HOME/.config/alacritty"

  if [ ! -f "$conf" ]; then
    cat > "$conf" <<EOF
[font]
normal = { family = "$FONT_NAME", style = "Regular" }
size = 13.0
EOF
  elif grep -q '^\[font\]' "$conf"; then
    warn "Alacritty config already has [font] section — update it manually:"
    warn "  normal = { family = \"$FONT_NAME\", style = \"Regular\" }"
  else
    printf '\n[font]\nnormal = { family = "%s", style = "Regular" }\nsize = 13.0\n' "$FONT_NAME" >> "$conf"
  fi

  success "Alacritty configured. Restart to apply."
  return 0
}

# ── main ───────────────────────────────────────────────────────────────────────
main() {
  echo "==> jpconfig — Nerd Font installer"
  echo ""

  install_font

  echo ""
  info "Detecting terminal..."

  configured=false
  configure_iterm2  && configured=true
  configure_kitty   && configured=true
  configure_alacritty && configured=true

  if [ "$configured" = false ]; then
    warn "Could not detect iTerm2, Kitty, or Alacritty."
    warn "Set your terminal font manually to: $FONT_NAME"
  fi

  echo ""
  success "Done!"
}

main
