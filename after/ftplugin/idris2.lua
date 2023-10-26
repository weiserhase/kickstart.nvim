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

local idris2Keybindings = {
    n = {
        ['<leader>cs'] = { cmd = require('idris2.code_action').case_split, desc = 'Idris2 [C]ase [S]plit' },
        ['<leader>cd'] = { cmd = require('idris2.code_action').generate_def, desc = 'Idris2 Generate [D]efinition' },
        ['<leader>ch'] = { cmd = require('idris2.code_action').refine_hole, desc = 'Idris2 Refine [H]ole' },
    }
}

pcall(applyBindings, idris2Keybindings)
