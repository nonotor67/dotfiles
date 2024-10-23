vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

return {
  auto_install = false,
  ensure_installed = {
    "lua",
    "html",
    "css",
    "javascript",
    "c",
    "cpp",
    "c_sharp",
    "rust",
    "markdown",
    "markdown_inline",
    "python",
    "ocaml",
  },
  autotag = { enable = true },
}
