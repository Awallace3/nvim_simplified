-- GetPath=function(str,sep)
--     sep=sep or'/'
--     return str:match("(.*"..sep..")")
-- end
-- -- get directory of python3_host_prog path
-- local nvim_format_bin = GetPath(vim.g.python3_host_prog)
--
-- Formatter = function()
--     local filetype = vim.bo.filetype
--     if filetype == "python" then
--         local cmd = nvim_format_bin .. "black --quiet" .. " " .. vim.fn.expand("%:p")
--         print(cmd)
--         vim.cmd(cmd)
--     elseif filetype == "htmldjango" then
--         vim.cmd("Format")
--     else
--         vim.lsp.buf.format()
--     end
-- end
