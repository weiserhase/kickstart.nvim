-- Helper function to map keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    for k, v in pairs(opts or {}) do
        options[k] = v
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, {})
end

local function applyBindings(keybindings)
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

local function generate_find_command(excludes)
    local cmd = { 'rg', '--files', '--hidden', '--no-ignore-vcs' }

    for _, exclude in ipairs(excludes or {}) do
        table.insert(cmd, '--glob')
        table.insert(cmd, '!' .. exclude)
    end

    return cmd
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
        ['<Leader>g'] = { cmd = ":G<CR>", desc = 'Run arbitrary Git command' },
    },
}
applyBindings(gitKeybindings)

local function harpoon_nav_factory(x)
    return (function() require('harpoon.ui').nav_file(x) end)
end
local harpoonKeybindings = {
    n = {
        ['<leader>ha'] = { cmd = require('harpoon.mark').add_file, desc = '[H]arpoon [A]dd File' },
        ['<leader>ht'] = { cmd = require('harpoon.ui').toggle_quick_menu, desc = '[H]arpoon [T]oggle Menu' },
        ['<leader>h1'] = { cmd = harpoon_nav_factory(1), desc = '[H]arpoon Buffer [1]' },
        ['<leader>h2'] = { cmd = harpoon_nav_factory(2), desc = '[H]arpoon Buffer [2]' },
        ['<leader>h3'] = { cmd = harpoon_nav_factory(3), desc = '[H]arpoon Buffer [3]' },
        ['<leader>h4'] = { cmd = harpoon_nav_factory(4), desc = '[H]arpoon Buffer [4]' },
        ['<leader>h5'] = { cmd = harpoon_nav_factory(5), desc = '[H]arpoon Buffer [5]' },
        ['<leader>h6'] = { cmd = harpoon_nav_factory(6), desc = '[H]arpoon Buffer [6]' },
        ['<leader>h7'] = { cmd = harpoon_nav_factory(7), desc = '[H]arpoon Buffer [7]' },
        ['<leader>h8'] = { cmd = harpoon_nav_factory(8), desc = '[H]arpoon Buffer [8]' },
        ['<leader>h9'] = { cmd = harpoon_nav_factory(9), desc = '[H]arpoon Buffer [9]' },
        ['<leader>hc'] = { cmd = require('harpoon.ui').nav_next, desc = '[H]arpoon [C]ycle Buffer' },
        ['<leader>hl'] = { cmd = require('harpoon.ui').nav_next, desc = '[H]arpoon Next Buffer' },
        ['<leader>hh'] = { cmd = require('harpoon.ui').nav_prev, desc = '[H]arpoon Previous Buffer' },
    }
}
applyBindings(harpoonKeybindings)


local windowKeybindings = {
    n = {
        ['<leader>wsv'] = { cmd = ':vsp<CR>', desc = '[W]indow [V]ertical split' },
        ['<leader>wsh'] = { cmd = ':sp<CR>', desc = '[W]indow [H]orizontal split' },
        ['<leader>wq'] = { cmd = ':q<CR>', desc = '[W]indow [Q]uit split' },
        ['<leader>wh'] = { cmd = '<C-w>h', desc = '[W]indow move left' },
        ['<leader>wj'] = { cmd = '<C-w>j', desc = '[W]indow move down' },
        ['<leader>wk'] = { cmd = '<C-w>k', desc = '[W]indow move up' },
        ['<leader>wl'] = { cmd = '<C-w>l', desc = '[W]indow move right' },
        ['<leader>w+'] = { cmd = '<C-w>+', desc = '[W]indow increase height' },
        ['<leader>w-'] = { cmd = '<C-w>-', desc = '[W]indow decrease height' },
        ['<leader>w<'] = { cmd = '<C-w><', desc = '[W]indow decrease width' },
        ['<leader>w>'] = { cmd = '<C-w>>', desc = '[W]indow increase width' },
    }
}

applyBindings(windowKeybindings)

local lspKeybindings = {
    n = {
        ['<leader>rn'] = { cmd = vim.lsp.buf.rename, desc = '[R]e[n]ame' },
        ['<leader>ca'] = { cmd = vim.lsp.buf.code_action, desc = '[C]ode [A]ction' },
        ['gd'] = { cmd = vim.lsp.buf.definition, desc = '[G]oto [D]efinition' },
        -- ['ho'] = { cmd = require('telescope._extensions').hoogle.list, desc = "Hoogle" }
        ['gr'] = { cmd = require('telescope.builtin').lsp_references, desc = '[G]oto [R]eferences' },
        ['gI'] = { cmd = require('telescope.builtin').lsp_implementations, desc = '[G]oto [I]mplementation' },
        ['<leader>D'] = { cmd = vim.lsp.buf.type_definition, desc = 'Type [D]efinition' },
        ['<leader>ds'] = { cmd = require('telescope.builtin').lsp_document_symbols, desc = '[D]ocument [S]ymbols' },
        ['<leader>wds'] = { cmd = require('telescope.builtin').lsp_dynamic_workspace_symbols, desc =
        '[W]orkspace [S]ymbols' },
        ['K'] = { cmd = vim.lsp.buf.hover, desc = 'Hover Documentation' },
        ['<C-s>'] = { cmd = vim.lsp.buf.signature_help, desc = 'Signature Documentation' },
        ['gD'] = { cmd = vim.lsp.buf.declaration, desc = '[G]oto [D]eclaration' },
        ['<leader>wda'] = { cmd = vim.lsp.buf.add_workspace_folder, desc = '[W]orkspace [A]dd Folder' },
        ['<leader>wdr'] = { cmd = vim.lsp.buf.remove_workspace_folder, desc = '[W]orkspace [R]emove Folder' },
        ['<leader>wdl'] = {
            cmd = function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            desc = '[W]orkspace [L]ist Folders'
        },
    },
    i = {

        ['<C-s>'] = { cmd = vim.lsp.buf.signature_help, desc = 'Signature Documentation' },
    }
}

applyBindings(lspKeybindings)
local telescopeKeybindings = {
    n = {
        ['<leader>?'] = { cmd = require('telescope.builtin').oldfiles, desc = '[?] Find recently opened files' },
        ['<leader><space>'] = { cmd = require('telescope.builtin').buffers, desc = '[ ] Find existing buffers' },
        ['<leader>/'] = {
            cmd = function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end,
            desc = '[/] Fuzzily search in current buffer'
        },
        ['<leader>gf'] = { cmd = require('telescope.builtin').git_files, desc = 'Search [G]it [F]iles' },
        ['<leader>f'] = { cmd = require('telescope.builtin').find_files, desc = 'Search [F]iles' },
        ['<leader>sh'] = { cmd = require('telescope.builtin').help_tags, desc = '[S]earch [H]elp' },

        ['<leader>sa'] = {
            cmd = function()
                local excludes = {}
                require('telescope.builtin').find_files({
                    find_command = generate_find_command(excludes)
                })
            end,
            desc = '[S]earch [A]ll Files'
        },
        ['<leader>si'] = {
            cmd = function()
                local excludes = { '**/.git/*', '**/node_modules/*', '**/*.log', '**/.bloop/*' }
                require('telescope.builtin').find_files({
                    find_command = generate_find_command(excludes)
                })
            end,
            desc = '[S]earch [I]gnored Files with custom excludes'
        },

        ['<leader>sw'] = { cmd = require('telescope.builtin').grep_string, desc = '[S]earch current [W]ord' },
        ['<leader>sg'] = { cmd = require('telescope.builtin').live_grep, desc = '[S]earch by [G]rep' },
        ['<leader>sd'] = { cmd = require('telescope.builtin').diagnostics, desc = '[S]earch [D]iagnostics' },
        ['<leader>sr'] = { cmd = require('telescope.builtin').resume, desc = '[S]earch [R]esume' },
    }
}

applyBindings(telescopeKeybindings)


local barbarKeybindings = {

    n = {
        -- Barbar Tabs
        -- Move to previous/next
        ['<A-,>'] = '<Cmd>BufferPrevious<CR>',
        ['<A-.>'] = '<Cmd>BufferNext<CR>',
        -- Re-order to previous/next
        ['<A-<>'] = '<Cmd>BufferMovePrevious<CR>',
        ['<A->>'] = '<Cmd>BufferMoveNext<CR>',
        -- Goto buffer in position...
        ['<A-1>'] = '<Cmd>BufferGoto 1<CR>',
        ['<A-2>'] = '<Cmd>BufferGoto 2<CR>',
        ['<A-3>'] = '<Cmd>BufferGoto 3<CR>',
        ['<A-4>'] = '<Cmd>BufferGoto 4<CR>',
        ['<A-5>'] = '<Cmd>BufferGoto 5<CR>',
        ['<A-6>'] = '<Cmd>BufferGoto 6<CR>',
        ['<A-7>'] = '<Cmd>BufferGoto 7<CR>',
        ['<A-8>'] = '<Cmd>BufferGoto 8<CR>',
        ['<A-9>'] = '<Cmd>BufferGoto 9<CR>',
        ['<A-0>'] = '<Cmd>BufferLast<CR>',
        -- Pin/unpin buffer
        ['<A-p>'] = '<Cmd>BufferPin<CR>',
        -- Close buffer
        ['<A-c>'] = '<Cmd>BufferClose<CR>',
        ['<C-p>'] = '<Cmd>BufferPick<CR>',
        -- Sort automatically by...
        ['<leader>bb'] = '<Cmd>BufferOrderByBufferNumber<CR>',
        ['<leader>bd'] = '<Cmd>BufferOrderByDirectory<CR>',
        ['<leader>bl'] = '<Cmd>BufferOrderByLanguage<CR>',
        ['<leader>bw'] = '<Cmd>BufferOrderByWindowNumber<CR>',

    },
}
applyBindings(barbarKeybindings)

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
