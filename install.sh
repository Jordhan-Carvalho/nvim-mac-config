#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/Jordhan-Carvalho/nvim-mac-config.git"
REPO_DIR="$HOME/nvim-mac-config"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.bak.$(date +%Y%m%d_%H%M%S)"

# ── helpers ────────────────────────────────────────────────────────────────────
info()    { echo "[info]  $*"; }
success() { echo "[ok]    $*"; }
warn()    { echo "[warn]  $*"; }
die()     { echo "[error] $*" >&2; exit 1; }

check_deps() {
  for cmd in git nvim; do
    command -v "$cmd" &>/dev/null || die "'$cmd' is not installed. Install it and re-run."
  done
}

# ── clone / update repo ────────────────────────────────────────────────────────
fetch_repo() {
  if [ -d "$REPO_DIR/.git" ]; then
    info "Repo already exists at $REPO_DIR — pulling latest..."
    git -C "$REPO_DIR" fetch origin
    git -C "$REPO_DIR" reset --hard origin/main
  else
    info "Cloning repo to $REPO_DIR..."
    git clone "$REPO_URL" "$REPO_DIR"
  fi
  success "Repo ready."
}

# ── backup existing config ─────────────────────────────────────────────────────
backup_existing() {
  if [ -e "$NVIM_CONFIG_DIR" ] || [ -L "$NVIM_CONFIG_DIR" ]; then
    warn "Existing Neovim config found — backing up to $BACKUP_DIR"
    mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
    success "Backup created at $BACKUP_DIR"
  fi
}

# ── remove legacy packer plugins ───────────────────────────────────────────────
remove_packer() {
  local packer_dir="$HOME/.local/share/nvim/site/pack/packer"
  if [ -d "$packer_dir" ]; then
    warn "Found old packer plugin directory — removing to avoid conflicts with lazy.nvim..."
    rm -rf "$packer_dir"
    success "Removed $packer_dir"
  fi
}

# ── symlink ────────────────────────────────────────────────────────────────────
link_config() {
  mkdir -p "$HOME/.config"
  ln -s "$REPO_DIR/.config/nvim" "$NVIM_CONFIG_DIR"
  success "Symlinked $REPO_DIR/.config/nvim → $NVIM_CONFIG_DIR"
}

# ── main ───────────────────────────────────────────────────────────────────────
main() {
  echo "==> jpconfig — Neovim config installer"
  echo ""

  check_deps
  fetch_repo
  backup_existing
  remove_packer
  link_config

  echo ""
  success "Done! Open Neovim with 'nvim' and wait for lazy.nvim to install plugins."
  info    "On first launch Mason will auto-install language servers."
  info    "Run :Copilot setup to authenticate GitHub Copilot (optional)."
}

main
