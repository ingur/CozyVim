local function map(m, lhs, rhs, desc)
    local opts = { desc = desc }
    vim.keymap.set(m, lhs, rhs, opts)
end

map("n", ";", ":", "Command")

map("n", "<C-c>", "<esc><cmd>quit<cr>", "Quit")
map("i", "<C-c>", "<esc><cmd>quit<cr>", "Quit")
map("n", "<leader>qq", "<cmd>qa<cr>", "Quit all")

map("n", "<leader>l", "<cmd>Lazy<cr>", "Plugins")

map("n", "<leader>x", function()
    require('telescope.builtin').find_files({
        cwd = vim.fn.stdpath("config")
    })
end, "Neovim config files")

map("t", "<esc>", "<C-\\><C-n>", "Normal mode")
map("t", "<C-j>", "<C-\\><C-n><C-w>j", "Move to left window")
map("t", "<C-k>", "<C-\\><C-n><C-w>k", "Move to bottom window")
map("t", "<C-h>", "<C-\\><C-n><C-w>h", "Move to top window")
map("t", "<C-l>", "<C-\\><C-n><C-w>l", "Move to right window")
map("t", "<C-Up>", "<C-\\><C-n><cmd>resize -2<cr>", "Resize window up")
map("t", "<C-Down>", "<C-\\><C-n><cmd>resize +2<cr>", "Resize window down")
map("t", "<C-Left>", "<C-\\><C-n><cmd>vertical resize -2<cr>", "Resize window left")
map("t", "<C-Right>", "<C-\\><C-n><cmd>vertical resize +2<cr>", "Resize window right")
