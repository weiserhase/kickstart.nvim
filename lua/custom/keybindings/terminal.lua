local terminalKeybindings = {
    n = {
        -- Terminal related mappings
        ['<C-t>'] = ':FloatermToggle<CR>',
        ['<Leader>tt'] = ':FloatermToggle<CR>',
        ['<Leader>tn'] = ':FloatermNew<CR>',
        ['<Leader>tl'] = ':FloatermNext<CR>',
        ['<Leader>th'] = ':FloatermPrev<CR>',
    },
    t = {
        ["<C-t>"] = '<C-\\><C-n>:FloatermToggle<CR>',
        ["<C-l>"] = '<C-\\><C-n>:FloatermNext<CR>',
        ["<C-h>"] = '<C-\\><C-n>:FloatermPrev<CR>',
        ["<C-o>"] = '<C-\\><C-n>:FloatermNew<CR>',
    },
    i = {
        ["<C-t>"] = '<C-\\><C-n>:FloatermToggle<CR>',
    }

}

applyBindings(terminalKeybindings)
