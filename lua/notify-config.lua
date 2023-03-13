
require("notify").setup({
  background_colour = "#000000",
})
vim.notify = require("notify")
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end
