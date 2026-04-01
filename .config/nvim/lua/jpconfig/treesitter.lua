local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  -- Explicit list instead of "all" — avoids 5-10 min install on first run
  ensure_installed = {
    "bash", "css", "dart", "go", "gomod", "html",
    "javascript", "json", "lua", "markdown", "python",
    "rust", "tsx", "typescript", "yaml",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    -- false: rely purely on treesitter (better performance)
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml" } },
  autopairs = { enable = true },
  -- context_commentstring is handled by ts-context-commentstring plugin directly
})
