vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, keys, func, desc)
	vim.keymap.set(mode, keys, func, { desc = desc })
end

-- Clear search highlight
map("n", "<Esc>", vim.cmd.nohlsearch, "Clear search highlight")

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":M '<-2<CR>gv=gv", "Move selection up")

-- Do not copy with x or paste over
map("n", "x", "\"_x", "Delete without copying")
map("v", "p", "\"_dP", "Paste without copying")

-- Splits management
map("n", "<leader>vs", "<C-w>v", "Vertical split")
map("n", "<leader>hs", "<C-w>h", "Horizontal split")
map("n", "<leader>xs", ":close<CR>", "Close split")

map("n", "<C-j>", "<C-w>j", "Move to split below")
map("n", "<C-h>", "<C-w>h", "Move to split left")
map("n", "<C-k>", "<C-w>k", "Move to split above")
map("n", "<C-l>", "<C-w>l", "Move to split right")

-- Buffer management
map("n", "<leader>b", ":enew<CR>", "New buffer")
map("n", "<leader>xb", ":bdelete<CR>", "Close buffer")
map("n", "<leader>xxb", ":bdelete!<CR>", "Force close buffer")

map("n", "<TAB>", ":bnext<CR>", "Next buffer")
map("n", "<S-TAB>", ":bprevious<CR>", "Previous buffer")

-- Stay in visual mode when indenting
map("v", ">", ">gv", ">Indent and stay in visual mode")
map("v", "<", "<gv", "<Indent and stay in visual mode")

-- Center when using down and up
map("n", "<C-d>", "<C-d>zz", "Scroll down and center")
map("n", "<C-u>", "<C-u>zz", "Scroll up and center")

-- Fold management
map("n", "<leader>f", vim.cmd.foldtoggle, "Toggle fold")
map("n", "+", vim.cmd.foldopen, "Open fold")
map("n", "-", vim.cmd.foldclose, "Close fold")

