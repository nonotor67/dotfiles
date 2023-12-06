vim.o.number = true
vim.o.relativenumber = true

vim.o.expandtab = true
vim.o.shiftwidth = 4

vim.o.colorcolumn = "80,100"
vim.o.cursorline = true
vim.o.wrap = false

vim.o.swapfile = false

vim.o.termguicolors = true
vim.o.mouse = "a"

vim.o.timeout = true
vim.o.timeoutlen = 300

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.o.nocp = true

vim.g.material_terminal_italics = 1
vim.g.material_theme_style = "darker-community"
-- vim.g.material_style = "darker"

vim.g.polyglot_disabled = {"sensible"}

require "paq" {
  "savq/paq-nvim";

  "kaicataldo/material.vim";
  -- "marko-cerovac/material.nvim";

  { "nvim-treesitter/nvim-treesitter", run = function() vim.cmd("TSUpdate") end };
  "nvim-treesitter/nvim-treesitter-context";
  "nvim-treesitter/playground";

  "hrsh7th/cmp-nvim-lsp";
  "hrsh7th/cmp-buffer";
  "hrsh7th/cmp-path";
  "hrsh7th/cmp-cmdline";
  "hrsh7th/nvim-cmp";

  "hrsh7th/vim-vsnip";
  "hrsh7th/vim-vsnip-integ";

  "neovim/nvim-lspconfig";

  "windwp/nvim-autopairs";

  "editorconfig/editorconfig-vim";
  "lewis6991/gitsigns.nvim";

  "sheerun/vim-polyglot";
  "jakewvincent/mkdnflow.nvim";
  
  -- "nvim-tree/nvim-tree.lua";
  "folke/which-key.nvim";
  "RRethy/vim-illuminate";
}

-- --
-- -- material.nvim
-- --
-- 
-- require"material".setup {
--   contrast = {
--     terminal = false, -- Enable contrast for the built-in terminal
--     sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
--     floating_windows = false, -- Enable contrast for floating windows
--     cursor_line = false, -- Enable darker background for the cursor line
--     non_current_windows = false, -- Enable contrasted background for non-current windows
--     filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
--   },
--   styles = { -- Give comments style such as bold, italic, underline etc.
--     comments = { --[[ italic = true ]] },
--     strings = { --[[ bold = true ]] },
--     keywords = { --[[ underline = true ]] },
--     functions = { --[[ bold = true, undercurl = true ]] },
--     variables = {},
--     operators = {},
--     types = {},
--   },
--   plugins = { -- Uncomment the plugins that you use to highlight them
--     -- Available plugins:
--     -- "dap",
--     -- "dashboard",
--     "gitsigns",
--     -- "hop",
--     -- "indent-blankline",
--     -- "lspsaga",
--     -- "mini",
--     -- "neogit",
--     -- "neorg",
--     "nvim-cmp",
--     -- "nvim-navic",
--     "nvim-tree",
--     -- "nvim-web-devicons",
--     -- "sneak",
--     -- "telescope",
--     -- "trouble",
--     "which-key",
--   },
--   disable = {
--     colored_cursor = false, -- Disable the colored cursor
--     borders = false, -- Disable borders between verticaly split windows
--     background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
--     term_colors = false, -- Prevent the theme from setting terminal colors
--     eob_lines = false -- Hide the end-of-buffer lines
--   },
--   high_visibility = {
--     lighter = false, -- Enable higher contrast text for lighter style
--     darker = false, -- Enable higher contrast text for darker style
--   },
--   lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
--   async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
--   custom_colors = nil, -- If you want to everride the default colors, set this to a function
--   custom_highlights = {}, -- Overwrite highlights with your own
-- }

vim.cmd("colorscheme material")

--
-- nvim-lspconfig
--

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

--
-- nvim-treesitter
--

require"nvim-treesitter.configs".setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "lua", "vim" },
}

--
-- nvim-treesitter-context
--

require "treesitter-context".setup {}

--
-- Vim functions
--

vim.cmd([[
function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
]])

--
-- mkdnflow
--

require "mkdnflow".setup {}

--
-- nvim-cmp
--

local cmp = require"cmp"

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    -- ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources(
    {
      { name = "nvim_lsp" },
      { name = "vsnip" }, -- For vsnip users.
      -- { name = "luasnip" }, -- For luasnip users.
      -- { name = "ultisnips" }, -- For ultisnips users.
      -- { name = "snippy" }, -- For snippy users.
    },
    {
      { name = "buffer" },
    }
  )
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})

-- gray
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg="NONE", strikethrough=true, fg="#808080" })
-- blue
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg="NONE", fg="#569CD6" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link="CmpIntemAbbrMatch" })
-- light blue
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg="NONE", fg="#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link="CmpItemKindVariable" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { link="CmpItemKindVariable" })
-- pink
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg="NONE", fg="#C586C0" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link="CmpItemKindFunction" })
-- front
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg="NONE", fg="#D4D4D4" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link="CmpItemKindKeyword" })
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link="CmpItemKindKeyword" })

-- Set up lspconfig.
local capabilities = require"cmp_nvim_lsp".default_capabilities()

--
-- nvim-lspconfig
--

local nvim_lsp = require"lspconfig"

nvim_lsp.clangd.setup {
    on_attach = on_attach,
}

nvim_lsp.pyright.setup {
    on_attach = on_attach,
}

--
-- nvim-autopairs
--

require"nvim-autopairs".setup {}

-- If you want insert `(` after select function or method item
local cmp_autopairs = require"nvim-autopairs.completion.cmp"
local cmp = require"cmp"
cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done()
)

--
-- gitsigns
--

require"gitsigns".setup {}

--
-- nvim-tree.lua
--

-- require"nvim-tree".setup {}

--
-- which-key.nvim
--

require"which-key".setup {}

--
-- vim-illuminate
--

require"illuminate".configure {
  filetypes_denylist = {
    "",
    "text",
  },
}

--
-- playground
--

require"nvim-treesitter.configs".setup {}
