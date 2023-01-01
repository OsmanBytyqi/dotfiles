require("osmani.packer")
require("osmani.keymap")
require("osmani.set")
require("osmani.statusline")

local augroup = vim.api.nvim_create_augroup
Osmani = augroup('osmani', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufEnter", "BufWinEnter", "TabEnter"}, {
    group = Osmani,
    pattern = "*.rs",
    callback = function()
        require("lsp_extensions").inlay_hints{}
    end
})

autocmd('VimLeave', {
    pattern = "*.tex",
    command = "!texclear %"
})

autocmd({"BufRead","BufNewFile","VimLeave"},{
        pattern ="*.tex",
        command ="set filetype=tex"
})


autocmd({"BufRead","BufNewFile"},{
        pattern ="*.md",
        command ="set filetype=markdown"
})

autocmd({"BufRead","BufNewFile"},{
        pattern =".diff",
        command ="TSToggle highlight"
})


autocmd({"BufRead","BufNewFile"},{
        pattern ="*.ms,*.me,*.man,*.mom",
        command ="set filetype=groff"
})

autocmd({"BufRead", "BufNewFile"},{
    pattern="xresources",
    command="set filetype=xdefaults"
})

autocmd({"BufWritePost"},{
    pattern="xresources",
    command="!xrdb %",

})

autocmd({"BufWritePre"}, {
    group = Osmani,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

vim.opt.laststatus = 0
function toggle_status()
    if vim.opt.laststatus._value == 0 then
        vim.opt.laststatus = 2
    else
        vim.opt.laststatus = 0
    end
end

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0

vim.g.netrw_winsize = 25
