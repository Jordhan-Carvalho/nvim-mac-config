local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

-- ts-context-commentstring v0.8+ changed API: setup the plugin first,
-- then use the official comment.nvim integration hook
require("ts_context_commentstring").setup({ enable_autocmd = false })

comment.setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
