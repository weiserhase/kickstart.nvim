local function harpoon_nav_factory(x)
    return (function() require('harpoon.ui').nav_file(x) end)
end
local harpoonKeybindings = {
    n = {
        ['<C-h>'] = { cmd = require('harpoon.ui').toggle_quick_menu, desc = '[H]arpoon [T]oggle Menu' },
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
