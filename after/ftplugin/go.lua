-- Set the tab width to 4 spaces
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

-- Enable auto-indentation
vim.bo.autoindent = true

-- Enable syntax highlighting
vim.cmd("syntax enable")
vim.cmd("syntax on")

-- Define additional key mappings specific to Golang
vim.api.nvim_buf_set_keymap(0, "n", "<F9>", ":!go run %<CR>", { noremap = true })
vim.api.nvim_buf_set_keymap(0, "n", "<F10>", ":!go build %<CR>", { noremap = true })
