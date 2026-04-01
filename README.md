# jpconfig — Neovim Config

A modern Neovim setup built in Lua. Everything vanilla Neovim lacks out of the box.

---

## Installation

### 1. Install Neovim

**macOS (Homebrew):**
```sh
brew install neovim
```

Requires Neovim **0.9+**. Check with `nvim --version`.

### 2. Install dependencies

A few tools are expected to be available on your PATH:

```sh
# Fuzzy finder (telescope live grep)
brew install ripgrep

# Nerd Font for icons (pick any from nerdfonts.com, e.g. JetBrains Mono)
brew install --cask font-jetbrains-mono-nerd-font
```

> Set your terminal font to the installed Nerd Font so icons render correctly.

### 3. Apply the config

Clone this repo and symlink the config into Neovim's config directory:

```sh
git clone https://github.com/jordhancarvalho/nvim-mac-config.git ~/nvim-mac-config

# Back up any existing config first
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true

# Symlink
ln -s ~/nvim-mac-config/.config/nvim ~/.config/nvim
```

### 4. Open Neovim

```sh
nvim
```

On the first launch, **lazy.nvim** bootstraps itself and installs all plugins automatically. Wait for it to finish, then restart Neovim.

**Mason** will auto-install language servers on first use. Run `:Mason` to manage them manually.

### 5. Copilot (optional)

Run `:Copilot setup` inside Neovim and follow the authentication flow.

---

## Plugin Manager

**[lazy.nvim](https://github.com/folke/lazy.nvim)** — plugins load lazily (only when needed), keeping startup fast. Run `:Lazy` to open the UI.

---

## Features

### LSP — Language Server Protocol
Provides IDE-level intelligence: go-to-definition, hover docs, rename, code actions, diagnostics.

Managed by **[mason.nvim](https://github.com/williamboman/mason.nvim)** — auto-installs and updates servers. Run `:Mason` to manage them.

| Language | Server | Notes |
|---|---|---|
| Go | `gopls` | Auto-installed via Mason |
| TypeScript / JavaScript | `ts_ls` | Auto-installed via Mason |
| Lua | `lua_ls` | Auto-installed via Mason, pre-configured for Neovim globals |
| Python | `pyright` | Auto-installed via Mason |
| Dart | `dartls` | Requires Dart SDK installed separately |

### Autocompletion
**[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** with sources:
- LSP suggestions
- Buffer words
- File path completion
- Neovim Lua API
- Snippets (LuaSnip + friendly-snippets)

### Format on Save
**[conform.nvim](https://github.com/stevearc/conform.nvim)** — formats every file on save using the attached LSP formatter. No per-language configuration needed.

### Syntax Highlighting
**[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** — AST-based highlighting, far more accurate than regex. Supports: bash, css, dart, go, html, javascript, json, lua, markdown, python, rust, tsx, typescript, yaml.

**[rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)** — brackets and delimiters colored by nesting depth.

### Fuzzy Finder
**[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** — fuzzy search over files, text, diagnostics, buffers, git commits, and more with a live preview panel.

### File Explorer
**[nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)** — sidebar file tree with git status indicators, icons, and file operations (create, rename, delete, move).

### Git Integration
**[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** — shows added/changed/removed lines in the sign column, inline blame, hunk navigation and staging.

### Terminal
**[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** — floating terminal windows that persist between toggles. Pre-configured apps: lazygit, node REPL, ncdu, htop, python REPL.

### AI Completion
**[copilot.vim](https://github.com/github/copilot.vim)** — GitHub Copilot inline suggestions. Tab is reserved for nvim-cmp; use `<C-p>` to accept Copilot suggestions.

### Commenting
**[Comment.nvim](https://github.com/numToStr/Comment.nvim)** — smart commenting that understands JSX/TSX context (correct `//` vs `{/* */}` automatically).

### Auto-pairs
**[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** — auto-closes `()`, `[]`, `{}`, `""`, `''`. Treesitter-aware (won't close inside strings). `<M-e>` for fast-wrap: wrap the next word in a delimiter.

### Status Line & Bufferline
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** — status bar showing git branch, diagnostics, mode, diff stats, file type, cursor position.
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** — buffer tabs at the top with file icons and close buttons.

### Colorscheme
**[nightfly](https://github.com/bluz71/vim-nightfly-colors)** as default. **[tokyonight](https://github.com/folke/tokyonight.nvim)** also installed. Change in `lua/jpconfig/colorscheme.lua`.

### Misc
- **vim-autoread** — automatically reloads buffers when files change on disk (e.g. after a `git checkout`).
- Tmux integration — open new tmux windows/sessions directly from Neovim.

---

## Keymaps

**Leader key: `<Space>`**

### Navigation

| Key | Mode | Action |
|---|---|---|
| `<C-h>` | Normal / Terminal | Move to left window |
| `<C-j>` | Normal / Terminal | Move to window below |
| `<C-k>` | Normal / Terminal | Move to window above |
| `<C-l>` | Normal / Terminal | Move to right window |
| `<S-l>` | Normal | Next buffer |
| `<S-h>` | Normal | Previous buffer |
| `<C-Up>` | Normal | Resize split taller |
| `<C-Down>` | Normal | Resize split shorter |
| `<C-Left>` | Normal | Resize split narrower |
| `<C-Right>` | Normal | Resize split wider |

### LSP

| Key | Mode | Action |
|---|---|---|
| `K` | Normal | Hover documentation |
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gr` | Normal | List references |
| `gi` | Normal | Go to implementation |
| `gt` | Normal | Go to type definition |
| `<leader>r` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code action |
| `<leader>p` | Normal | Format buffer (manual) |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |

### Telescope (Fuzzy Finder)

| Key | Mode | Action |
|---|---|---|
| `<leader>f` | Normal | Find files (includes dotfiles, excludes `.git`) |
| `<leader>s` | Normal | Live grep (search text across project) |
| `<leader>[` | Normal | Show all LSP diagnostics |

**Inside Telescope:**

| Key | Action |
|---|---|
| `<C-j>` / `<C-k>` | Move selection down / up |
| `<CR>` | Open selected |
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<C-q>` | Send all results to quickfix |
| `<M-q>` | Send selected to quickfix |
| `<Esc>` | Close |

### File Explorer (nvim-tree)

| Key | Mode | Action |
|---|---|---|
| `<leader>e` | Normal | Toggle file explorer |

### Editing

| Key | Mode | Action |
|---|---|---|
| `d` | Normal / Visual Block | Delete without yanking (black hole register) |
| `p` | Visual / Visual Block | Paste without overwriting the yank register |
| `<` | Visual | Dedent (stays in visual mode) |
| `>` | Visual | Indent (stays in visual mode) |
| `<A-j>` | Visual | Move selection down |
| `<A-k>` | Visual | Move selection up |
| `J` | Visual Block | Move selection down |
| `K` | Visual Block | Move selection up |
| `gcc` | Normal | Toggle line comment |
| `gbc` | Normal | Toggle block comment |
| `gc` | Visual | Toggle comment on selection |
| `<M-e>` | Insert | Fast-wrap: wrap next word in a delimiter |

### Completion (nvim-cmp)

| Key | Mode | Action |
|---|---|---|
| `<C-j>` | Insert | Next completion item |
| `<C-k>` | Insert | Previous completion item |
| `<CR>` | Insert | Confirm selected item |
| `<C-Space>` | Insert | Trigger completion manually |
| `<C-e>` | Insert | Abort / close completion |
| `<C-b>` | Insert | Scroll docs up |
| `<C-f>` | Insert | Scroll docs down |
| `<Tab>` | Insert | Next item / expand snippet / jump to next snippet point |
| `<S-Tab>` | Insert | Previous item / jump to previous snippet point |

### AI (Copilot)

| Key | Mode | Action |
|---|---|---|
| `<C-p>` | Insert | Accept Copilot suggestion |

### Terminal (toggleterm)

| Key | Mode | Action |
|---|---|---|
| `<C-\>` | Normal | Toggle floating terminal |
| `<Esc>` | Terminal | Exit terminal mode (back to normal) |
| `<F1>` | Normal | Toggle lazygit |
| `<F2>` | Normal | Toggle Node.js REPL |
| `<F3>` | Normal | Toggle terminal #2 |
| `<F4>` | Normal | Toggle terminal #3 |

> Inside lazygit, `<Esc>` closes the window instead of entering normal mode.

### Tmux Integration

| Key | Mode | Action |
|---|---|---|
| `<C-w>` | Normal | Open tmux-windowizer (new tmux window) |
| `<C-s>` | Normal | Open tmux-sessionizer (new tmux session) |

---

## File Structure

```
nvim/
└── .config/nvim/
    ├── init.lua                  # Entry point: loads options, keymaps, plugins
    └── lua/jpconfig/
        ├── plugins.lua           # Plugin specs (lazy.nvim)
        ├── options.lua           # Vim options
        ├── keymaps.lua           # Global keymaps
        ├── colorscheme.lua       # Active colorscheme
        ├── mylsp.lua             # LSP + Mason setup
        ├── conform.lua           # Format on save
        ├── cmp.lua               # Completion engine
        ├── treesitter.lua        # Syntax highlighting
        ├── telescope.lua         # Fuzzy finder
        ├── nvim-tree.lua         # File explorer
        ├── bufferline.lua        # Buffer tabs
        ├── lualine.lua           # Status line
        ├── toggleterm.lua        # Terminal + app toggles
        ├── gitsigns.lua          # Git gutter signs
        ├── autopairs.lua         # Auto-close brackets
        └── comment.lua           # Commenting
```
