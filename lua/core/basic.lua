vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- Global
vim.opt.autoread = true
vim.opt.autowriteall = true
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<"
vim.opt.mouse = ""
vim.opt.smartcase = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.updatetime = 50

--- Window
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.wrap = false

--- Buffer
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.complete = ".,w,b,u,t,i,kspell"
vim.opt.spelllang = "en_us"
vim.opt.swapfile = false
vim.opt.undofile = true

-- Options
vim.api.nvim_set_option("termguicolors", true)
vim.api.nvim_set_option("background", "dark")

--- Keys
vim.keymap.set("x", "<leader>p", '"_dP', { noremap = true, desc = "Replace without overwriting registry" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Esc from terminal mode" })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

--- Aucmd
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local custom_au_cmd_group = vim.api.nvim_create_augroup("CustomAuCmd", { clear = true })
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { group = custom_au_cmd_group, pattern = "*", command = [[:%s/\s\+$//e]] }
)

vim.api.nvim_create_autocmd(
    { "CursorHold", "CursorHoldI", "FocusGained", "BufEnter" },
    { group = custom_au_cmd_group, pattern = "*", command = [[:checktime]] }
)
