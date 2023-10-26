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
        ['<leader>sgf'] = { cmd = require('telescope.builtin').git_files, desc = 'Search [G]it [F]iles' },
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
