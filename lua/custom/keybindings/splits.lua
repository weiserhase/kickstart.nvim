local windowKeybindings = {
    n = {
        ['<leader>wsv'] = { cmd = ':vsp<CR>', desc = '[W]indow [V]ertical split' },
        ['<leader>wsh'] = { cmd = ':sp<CR>', desc = '[W]indow [H]orizontal split' },
        ['<leader>wq'] = { cmd = ':q<CR>', desc = '[W]indow [Q]uit split' },
        ['<leader>wh'] = { cmd = '<C-w>h', desc = '[W]indow move left' },
        ['<leader>wH'] = { cmd = '<C-w>H', desc = '[W]indow move left' },
        ['<leader>wK'] = { cmd = '<C-w>K', desc = '[W]indow move left' },
        ['<leader>wj'] = { cmd = '<C-w>j', desc = '[W]indow move down' },
        ['<leader>wk'] = { cmd = '<C-w>k', desc = '[W]indow move up' },
        ['<leader>wl'] = { cmd = '<C-w>l', desc = '[W]indow move right' },
        ['<leader>w+'] = { cmd = '<C-w>+', desc = '[W]indow increase height' },
        ['<leader>w-'] = { cmd = '<C-w>-', desc = '[W]indow decrease height' },
        ['<leader>w_'] = { cmd = '<C-w>_', desc = '[W]indow Max height' },
        ['<leader>w|'] = { cmd = '<C-w>|', desc = '[W]indow decrease height' },
        ['<leader>w<'] = { cmd = '<C-w><', desc = '[W]indow decrease width' },
        ['<leader>w>'] = { cmd = '<C-w>>', desc = '[W]indow increase width' },
    }
}

applyBindings(windowKeybindings)
