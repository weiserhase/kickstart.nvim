function isWindows()
    return package.config:sub(1, 1) == "\\"
end

local function save_hook(action)
    vim.cmd('silent write')
end
return {
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
        'voldikss/vim-floaterm',
        config = function()
            if isWindows() then
                vim.g.floaterm_shell = "pwsh"
            end
        end
    }, { -- Ayu theme
    'Shatur/neovim-ayu',
    lazy = false,
    priority = 1000,
    opts = { mirage = false },
    config = function()
        vim.opt.background = "dark"
        require("ayu").setup({
            mirage = true
        })
        require("ayu").colorscheme()
    end
},
    -- Detect tabstop and shiftwidth automatically
    -- 'tpope/vim-sleuth',
    { 'nvim-lua/plenary.nvim' },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },
    --  The configuration is done below. Search for lspconfig to find it below.

    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = { text = { spinner = "moon" }, done = "✔ ", } },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',

        },
    },
    {
        'jayp0521/mason-null-ls.nvim',
        config = function()
            require('mason-null-ls').setup({
                ensure_installed = { "black", "flake8" },
                automatic_installation = true,
            })
        end
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({

                sources = {
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.diagnostics.flake8,
                },
                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentFormattingProvider then
                        vim.cmd([[
              augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ timeout_ms = 1000 })
              augroup END
            ]])
                    end
                end,
            })
        end
    },
    -- Idris2 Lsp
    { 'edwinb/idris2-vim',       ft = { 'idris2' } },
    { 'mfussenegger/nvim-jdtls', },
    {
        'ShinKage/idris2-nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'MunifTanjim/nui.nvim' },
        opts = {
            client = {
                hover = {
                    use_split = false,         -- Persistent split instead of popups for hover
                    split_size = '30%',        -- Size of persistent split, if used
                    auto_resize_split = false, -- Should resize split to use minimum space
                    split_position = 'bottom', -- bottom, top, left or right
                    with_history = false,      -- Show history of hovers instead of only last
                    use_as_popup = false,      -- Close the split on cursor movement
                },
            },
            code_action_post_hook = save_hook,

            autostart_semantic = true,            -- Should start and refresh semantic highlight automatically
            se_default_semantic_hl_groups = true, -- Set default highlight groups for semantic tokens
            default_regexp_syntax = true,         -- Enable default highlight groups for traditional syntax based highlighting

        }

    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest featureset
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            })
        end
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP ompletion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },

    -- Useful plugin to show you pending keybinds.
    {
        'folke/which-key.nvim',
        opts = {},
        dependencies = { 'echasnovski/mini.icons', 'nvim-tree/nvim-web-devicons' },
    },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Preview git hunk' })

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ 'n', 'v' }, ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
                vim.keymap.set({ 'n', 'v' }, '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
            end,
        },
    },
    {
        -- Theme inspired by Atom
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'onedark'
        end,
    },
    --[[ {
    "marko-cerovac/material.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'material-deep-ocean'
      -- vim.g.material_style = "deep ocean"
    end

  }, ]]
    { "nvim-neotest/nvim-nio" },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = 'onedark',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    { "neovimhaskell/haskell-vim" },
    {
        'mrcjkb/haskell-tools.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        version = '^3', -- Recommended
        ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
            icons = {
                buffer_index = true
            }
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    undo = {
                        -- telescope-undo.nvim config, see below
                    },
                },
            })
            require("telescope").load_extension("undo")
            vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    -- {
    --   -- Add indentation guides even on blank lines
    --   'lukas-reineke/indent-blankline.nvim',
    --   -- Enable `lukas-reineke/indent-blankline.nvim`
    --   -- See `:help indent_blankline.txt`
    --   main = "ibl",
    --   opts = {},
    -- },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim',  opts = {} },
    -- Harpoon
    {
        'ThePrimeagen/harpoon',
        -- opts = {
        --     tabline = true
        -- }
    },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'psiska/telescope-hoogle.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            -- vim: ts=8 sw=8 sts=8 noet:		{
            'nvim-telescope/telescope-fzf-native.nvim',
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    {
        'nvim-treesitter/nvim-treesitter-context'
    },

    -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
    --       These are some example plugins that I've included in the kickstart repository.
    --       Uncomment any of the lines below to enable them.
    -- require 'kickstart.plugins.autoformat',
    require 'kickstart.plugins.debug',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
    --    up-to-date with whatever is in the kickstart repo.
    --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    { import = 'custom.plugins' },

}
