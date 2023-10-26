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
