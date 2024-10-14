-- Register blade as a file type for syntax highlighting
local force_filetype = vim.api.nvim_create_augroup('force_filetype', { clear = true })
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = { '*.blade.php' },
    group = force_filetype,
    callback = function ()
        vim.bo.filetype = 'php'
    end,
})

-- This seems to have a loading order problem
-- vim.filetype.add {
--     -- C files
--     extension = {
--         h = 'c',
--     },
--     -- Blade files are normal PHP
--     pattern = {
--         ['.*.blade.php'] = 'php', -- Until we get proper blade parser
--     },
-- }
