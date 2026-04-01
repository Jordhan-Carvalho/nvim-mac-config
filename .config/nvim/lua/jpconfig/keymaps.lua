local opts = { noremap = true, silent = true }

-- Leader key (must be set before lazy.nvim loads plugins)
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.copilot_no_tab_map = true

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Delete without yanking
vim.keymap.set("n", "d", '"_d', opts)
vim.keymap.set("x", "d", '"_d', opts)

-- Resize splits
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Copilot accept (Tab is reserved for cmp)
vim.keymap.set("i", "<C-p>", 'copilot#Accept("<CR>")', { expr = true, silent = true, replace_keycodes = false })

-- Stay in indent mode after indent/dedent
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up/down in visual mode
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
vim.keymap.set("v", "p", '"_dP', opts)

-- Move text up/down in visual block mode
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
vim.keymap.set("x", "p", '"_dP', opts)

-- Terminal: navigate windows without exiting insert mode
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })

-- Telescope
vim.keymap.set("n", "<leader>f", function()
  require("telescope.builtin").find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
end, opts)
vim.keymap.set("n", "<leader>s", "<cmd>Telescope live_grep<cr>", opts)
vim.keymap.set("n", "<leader>[", "<cmd>Telescope diagnostics<cr>", opts)

-- File explorer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- ToggleTerm apps
vim.keymap.set("n", "<F1>", ":lua _LAZYGIT_TOGGLE()<CR>", opts)
vim.keymap.set("n", "<F2>", ":lua _NODE_TOGGLE()<cr>", opts)
vim.keymap.set("n", "<F3>", ":2ToggleTerm<cr>", opts)
vim.keymap.set("n", "<F4>", ":3ToggleTerm<cr>", opts)

-- Tmux integration
vim.keymap.set("n", "<C-w>", ":silent !tmux neww tmux-windowizer<cr>", opts)
vim.keymap.set("n", "<C-s>", ":silent !tmux neww tmux-sessionizer<cr>", opts)
