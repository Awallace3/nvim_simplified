-- vim.api.nvim_set_keymap({mode}, {keymap}, {mapped to}, {options})
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true}
keymap('i', 'jj', '<ESC>', opts)
-- keymap('n', ' ', '<Leader>', opts)
vim.g.mapleader = ' '
-- vim.g.localleader= ';'

require('nvim-autopairs').setup({disable_filetype = {"TelescopePrompt", "vim"}})

keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<ESC>:w<CR>a', {})
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)
keymap("n", "<A-H>", ":vertical resize +5<cr>", opts)
keymap("n", "<A-L>", ":vertical resize -5<cr>", opts)
keymap("n", "<A-J>", ":resize +5<cr>", opts)
keymap("n", "<A-K>", ":resize -5<cr>", opts)


keymap('n', ']b', ':bn<cr>', opts)
keymap('n', '[b', ':bprevious<cr>', opts)
-- improved indenting
-- vmap <Tab> >gv
-- vmap <S-Tab> <gv
keymap('v', '>', ">gv", opts)
keymap('v', '<', "<gv", opts)


-- keymap('n', '<Leader>R', ":lua Test()<CR>", opts)
-- keymap('n', '<Leader>R', ":lua File_type(%)", opts)
-- keymap('n', '<Leader>R', ":terminal /Users/austinwallace/.config/nvim/lua/run-module/file_type.lua ", opts)

function SaveNotModifiable()
    vim.cmd [[
    set ma
    w out.log
    bd
    vs out.log
    set nowrap
    ]]
end

function Python_term()
    vim.cmd [[
    vs
    term python3 main.py
    ]]
end


function Python_term_dftd4()
    vim.cmd [[
    vs
    term python3 main.py -m RMSE -d BJ
    ]]
end


keymap('n', '<Leader>L', ":terminal lua %<CR>", opts)
-- keymap('n', '<Leader>P', ":vsplit | terminal python3 %<CR>", opts)
keymap('n', '<Leader>P', ":lua Python_term() <CR>", opts)
keymap('n', '<Leader>d', ":lua Python_term_dftd4() <CR>", opts)
--keymap("n", '<Leader>R', ':vs | silent term rm corpus/d1.csv ', opts)
-- keymap("n", '<Leader>R', ':so %<CR>', opts)
-- keymap('n', '<Leader>wo', ":set ma | w out.log |  %<CR>", opts)
keymap('n', '<Leader>wo', ":lua SaveNotModifiable() <CR>", opts)

-- Telescope
-- keymap('n', '<Leader>f', ':Telescope find_files<cr>', {})
-- keymap('n', '<Leader>r', ':Telescope live_grep<cr>', {})

keymap('n', '<Leader>n', ':NERDTreeToggle<cr>', {})
keymap('n', '<Leader>b', ':BufferLinePick<cr>', {})

keymap('v', '<Leader>w', "<esc>:'<,'>s/$/  /<cr>/added_whitespace<cr>", opts)
keymap('v', '<Leader>y', '"+y', opts)


keymap('n', '<Leader>F', ':Neoformat<cr>', {})
keymap('n', '<Leader>s', ':vs<cr>', {})

-- spell
keymap('n', '<Leader>z', '1z=', {})

keymap("n", '<Leader>lh', ":lua vim.diagnostic.hide()<cr>", {})
keymap("n", '<Leader>ls', ":lua vim.diagnostic.show()<cr>", {})
keymap("n", '<Leader>S', ":vs<cr>:e ~/.config/nvim/snippets<cr>5j", {})


vim.g['copilot_no_tab_map'] = true

