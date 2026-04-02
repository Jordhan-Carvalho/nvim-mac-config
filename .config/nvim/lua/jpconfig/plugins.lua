-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Core utilities
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  -- Colorscheme (lazy=false + priority=1000 ensures it loads before everything)
  {
    "bluz71/vim-nightfly-colors",
    lazy = false,
    priority = 1000,
    config = function()
      require("jpconfig.colorscheme")
    end,
  },
  { "folke/tokyonight.nvim", lazy = true },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("jpconfig.nvim-tree")
    end,
  },

  -- Buffer tabs
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("jpconfig.bufferline")
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("jpconfig.lualine")
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("jpconfig.toggleterm")
    end,
  },

  -- Auto-close brackets/pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("jpconfig.autopairs")
    end,
  },

  -- Commenting (gcc / gbc)
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("jpconfig.comment")
    end,
  },

  -- Auto-reload when files change on disk
  "djoshea/vim-autoread",

  -- GitHub Copilot
  "github/copilot.vim",

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("jpconfig.cmp")
    end,
  },

  -- LSP: mason for server management + lspconfig for configuration
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("jpconfig.mylsp")
    end,
  },

  -- Formatter (format-on-save for all LSP-attached filetypes)
  {
    "stevearc/conform.nvim",
    config = function()
      require("jpconfig.conform")
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("jpconfig.telescope")
    end,
  },

  -- Syntax highlighting + AST
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "HiPhish/rainbow-delimiters.nvim", -- modern replacement for nvim-ts-rainbow
    },
    config = function()
      require("jpconfig.treesitter")
    end,
  },

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("jpconfig.gitsigns")
    end,
  },
}, {
  ui = { border = "rounded" },
  rocks = { enabled = false },
})
