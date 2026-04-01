local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function lsp_highlight_document(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local on_attach = function(client, bufnr)
  lsp_highlight_document(client, bufnr)

  local bufopts = { buffer = bufnr }
  vim.keymap.set("n", "K",          vim.lsp.buf.hover,         bufopts)
  vim.keymap.set("n", "gd",         vim.lsp.buf.definition,    bufopts)
  vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,   bufopts)
  vim.keymap.set("n", "gr",         vim.lsp.buf.references,    bufopts)
  vim.keymap.set("n", "gi",         vim.lsp.buf.implementation,bufopts)
  vim.keymap.set("n", "gt",         vim.lsp.buf.type_definition,bufopts)
  vim.keymap.set("n", "<leader>p",  vim.lsp.buf.format,        bufopts)
  vim.keymap.set("n", "<leader>r",  vim.lsp.buf.rename,        bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,   bufopts)
end

-- Diagnostic navigation (global, not buffer-local)
local diag_opts = { noremap = true, silent = true }
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, diag_opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, diag_opts)

-- Mason: GUI for installing/managing LSP servers
require("mason").setup({ ui = { border = "rounded" } })

-- mason-lspconfig: auto-install and bridge mason → lspconfig
require("mason-lspconfig").setup({
  ensure_installed = { "gopls", "ts_ls", "lua_ls" },
  automatic_installation = true,
})

local lspconfig = require("lspconfig")

-- Default handler: applies to all mason-managed servers
require("mason-lspconfig").setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,

  -- lua_ls needs extra config to recognise the vim global
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })
  end,
})

-- dartls is bundled with the Dart SDK, not managed by mason
lspconfig.dartls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
