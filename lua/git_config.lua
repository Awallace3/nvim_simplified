
vim.g.gitgutter_sign_added = '+'
vim.g.gitgutter_sign_modified = '>'
vim.g.gitgutter_sign_removed = '-'
vim.g.gitgutter_sign_removed_first_line = '^'
vim.g.gitgutter_sign_modified_removed = '<'
vim.cmd[[
    set updatetime=250
]]
-- GitGutter: Hunks

-- https://github.com/rhysd/conflict-marker.vim
-- <LEADER> ct for theirs, co for ours, cn for none and cb for both.
-- [x for next, ]x for previous
