vim.cmd.colorscheme("dracula")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#282A36" })

vim.diagnostic.config({
    virtual_text = false,
})

local signs = { Error = "", Warn = "", Hint = "󰋗", Info = "󰋼" }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
