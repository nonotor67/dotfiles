vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- docs: https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
return {
  git = { enable = false },
  filters = {
    custom = { "node_modules", ".git", ".cache" },
    dotfiles = false,
    exclude = { ".gitignore", ".github" },
  },
  view = {
    side = "left",
  },
  renderer = { highlight_git = true },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = { enable = true, },
}
