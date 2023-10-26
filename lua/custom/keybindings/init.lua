-- Helper function to map keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    for k, v in pairs(opts or {}) do
        options[k] = v
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, {})
end

function applyBindings(keybindings)
    for mode, bindings in pairs(keybindings) do
        for key, command in pairs(bindings) do
            if type(command) == 'table' and command.desc then
                -- If the command has a description, use it
                vim.keymap.set(mode, key, command.cmd, { desc = command.desc })
            else
                -- Default behavior
                map(mode, key, command)
            end
        end
    end
end

require('which-key').register({
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
    ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
    ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
    ['<leader>ws'] = { name = '[W]indow [S]plit', _ = 'which_key_ignore' },
    ['<leader>wd'] = { name = '[W]orking [D]irectory', _ = 'which_key_ignore' },
    ['<leader>t'] = { name = '[T]erminal', _ = 'which_key_ignore' },
})

local gitKeybindings = {
    n = {
        ['<Leader>g']  = { cmd = ":G<CR>", desc = 'Run arbitrary Git command' },
        ['<Leader>gp'] = { cmd = ":Git push<CR>", desc = '[G]it Push' },
        ['<Leader>gf'] = { cmd = ":Git pull<CR>", desc = '[G]it Push' },
        ['<leader>gl'] = { cmd = ':Telescope git_commits<CR>', desc = '[G]it [C]ommits' },
        ['<leader>gb'] = { cmd = ':Telescope git_branches<CR>', desc = '[G]it [B]Branches' },
    },
}
applyBindings(gitKeybindings)

require('custom.keybindings.telescope')
require('custom.keybindings.splits')
require('custom.keybindings.lsp')
require('custom.keybindings.barbar')
require('custom.keybindings.terminal')
require('custom.keybindings.harpoon')
