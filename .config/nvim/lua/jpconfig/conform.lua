-- Format on save for all LSP-attached filetypes.
-- lsp_fallback=true means: use explicit formatters when configured,
-- otherwise fall back to whatever LSP is attached (gopls, ts_ls, dartls, lua_ls).
require("conform").setup({
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
})
