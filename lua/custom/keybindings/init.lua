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
local lspKeybindings = {
	n = {
		['<leader>rn'] = { cmd = vim.lsp.buf.rename, desc = '[R]e[n]ame' },
		['<leader>ca'] = { cmd = vim.lsp.buf.code_action, desc = '[C]ode [A]ction' },
		['gd'] = { cmd = vim.lsp.buf.definition, desc = '[G]oto [D]efinition' },
		['gr'] = { cmd = require('telescope.builtin').lsp_references, desc = '[G]oto [R]eferences' },
		['gI'] = { cmd = require('telescope.builtin').lsp_implementations, desc = '[G]oto [I]mplementation' },
		['<leader>D'] = { cmd = vim.lsp.buf.type_definition, desc = 'Type [D]efinition' },
		['<leader>ds'] = { cmd = require('telescope.builtin').lsp_document_symbols, desc = '[D]ocument [S]ymbols' },
		['<leader>ws'] = { cmd = require('telescope.builtin').lsp_dynamic_workspace_symbols, desc =
		'[W]orkspace [S]ymbols' },
		['K'] = { cmd = vim.lsp.buf.hover, desc = 'Hover Documentation' },
		['<C-s>'] = { cmd = vim.lsp.buf.signature_help, desc = 'Signature Documentation' },
		['gD'] = { cmd = vim.lsp.buf.declaration, desc = '[G]oto [D]eclaration' },
		['<leader>wa'] = { cmd = vim.lsp.buf.add_workspace_folder, desc = '[W]orkspace [A]dd Folder' },
		['<leader>wr'] = { cmd = vim.lsp.buf.remove_workspace_folder, desc = '[W]orkspace [R]emove Folder' },
		['<leader>wl'] = {
			cmd = function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			desc = '[W]orkspace [L]ist Folders'
		},
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
		['<leader>f'] = { cmd = require('telescope.builtin').find_files, desc = '[S]earch [F]iles' },
		['<leader>sh'] = { cmd = require('telescope.builtin').help_tags, desc = '[S]earch [H]elp' },
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
		['<Space>bb'] = '<Cmd>BufferOrderByBufferNumber<CR>',
		['<Space>bd'] = '<Cmd>BufferOrderByDirectory<CR>',
		['<Space>bl'] = '<Cmd>BufferOrderByLanguage<CR>',
		['<Space>bw'] = '<Cmd>BufferOrderByWindowNumber<CR>',

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
	},
	i = {
		["<C-t>"] = '<C-\\><C-n>:FloatermToggle<CR>',
	}

}

applyBindings(terminalKeybindings)
