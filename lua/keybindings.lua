-- vim.api.nvim_set_keymap({mode}, {keymap}, {mapped to}, {options})
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }
keymap('i', 'jk', '<ESC>', opts)
-- keymap('n', ' ', '<Leader>', opts)
vim.g.mapleader = ' '
-- vim.g.localleader= ';'

require('nvim-autopairs').setup({ disable_filetype = { "TelescopePrompt", "vim" } })

-- luasnips
keymap('i', '<c-j>', "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap('i', '<c-k>', "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap('i', '<c-,>', '', {})

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
-- keymap("n", '<Leader>R', ':vs | silent term rm corpus/d1.csv ', opts)
-- keymap("n", '<Leader>R', ':so %<CR>', opts)
-- keymap('n', '<Leader>wo', ":set ma | w out.log |  %<CR>", opts)
keymap('n', '<Leader>wo', ":lua SaveNotModifiable() <CR>", opts)

-- Telescope
-- keymap('n', '<Leader>f', ':Telescope find_files<cr>', {})
-- keymap('n', '<Leader>r', ':Telescope live_grep<cr>', {})

keymap('n', '<Leader>n', ':silent! NERDTreeToggle<cr>', {})
keymap('n', '<Leader>b', ':BufferLinePick<cr>', {})

keymap('v', '<Leader>w', "<esc>:'<,'>s/$/  /<cr>/added_whitespace<cr>", opts)
keymap('v', '<Leader>y', '"+y', opts)



function Get_visual_selection()
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")
    local n_lines = math.abs(s_end[2] - s_start[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end
    return table.concat(lines, '\n')
end

function Write_coords_to_tmp_xyz(coords)
    os.remove("tmp.xyz")
    local file = io.open("tmp.xyz", "w")

    if file == nil then
        print("Error opening file")
        return
    end
    -- print("Writing to file")
    local n_atoms = 0
    for _ in coords:gmatch("[^\r\n]+") do
        n_atoms = n_atoms + 1
    end
    print(coords)
    file:write(n_atoms)
    file:write("\n\n")
    file:write(coords)
    file:write("\n")
    file:close()

end

function Jmol_visual_xyz()
    local coords = Get_visual_selection()
    Write_coords_to_tmp_xyz(coords)
    print("Running jmol")
    print("jmol tmp.xyz")
    io.popen("jmol tmp.xyz")
end

function Pymol_visual_xyz()
    local coords = Get_visual_selection()
    Write_coords_to_tmp_xyz(coords)
    print("Running Pymol")
    print("pymol tmp.xyz")
    vim.cmd [[
        vs
        term pymol tmp.xyz
    ]]
end

function VMD_visual_xyz()
    local coords = Get_visual_selection()
    Write_coords_to_tmp_xyz(coords)
    print("Running VMD")
    print("vmd -e ~/vmd_setup.tcl tmp.xyz")
    io.popen("vmd -e ~/vmd_setup.tcl tmp.xyz")
    -- wait for vmd to finishes
    print("Finished")
end

keymap("v", "<Leader>v", ':lua VMD_visual_xyz()<CR>', opts)
keymap("v", "<Leader>p", ':lua Pymol_visual_xyz()<CR>', opts)
keymap("v", "<Leader>j", ':lua Jmol_visual_xyz()<CR>', opts)

-- keymap('n', '<Leader>F', ':Neoformat<cr>', {})
-- keymap('n', '<Leader>s', ':vs<cr>', {})

-- spell
keymap('n', '<Leader>z', '1z=', {})

keymap("n", '<Leader>lh', ":lua vim.diagnostic.hide()<cr>", {})
keymap("n", '<Leader>ls', ":lua vim.diagnostic.show()<cr>", {})
keymap("n", '<Leader>S', ":vs<cr>:e ~/.config/nvim/snippets<cr>5j", {})

keymap("n", "<C-S>H", ":vertical resize +5<cr>", opts)
keymap("n", "<C-S>L", ":vertical resize -5<cr>", opts)
keymap("n", "<C-S>J", ":horizontal resize +5<cr>", opts)
keymap("n", "<C-S>K", ":horijzontal resize -5<cr>", opts)

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

keymap("i", "<M-CR>", 'copilot#Accept("<CR>")', { expr = true })
keymap("i", "<C-f>", 'copilot#Accept("<CR>")', { expr = true })
vim.keymap.set('i', '<M-k>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<M-j>', '<Plug>(copilot-previous)')
vim.g.copilot_filetypes = {
    tex = false,
}



keymap('n', '[t', '<CMD>tabnext<CR>', opts)
keymap('n', ']t', '<CMD>tabprev<CR>', opts)
