-- LSP Zero bootstrap
-- ==========================
local lsp_zero = require('lsp-zero')

lsp_zero.extend_lspconfig()

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)


-- Mason Auto LSP Download
-- ==========================
require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓"
        }
    }
}

require("mason-lspconfig").setup {
	ensure_installed = {
		"tsserver",
		"tailwindcss",
		"emmet_ls",
		"eslint",
		"bashls",
		"jsonls",
		"svelte",
		-- "solang"
	},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
}


-- Auto complete
-- ==========================
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local luasnip = require('luasnip')
local neotab = require('neotab')

neotab:setup()

cmp.setup({
	-- completion = {
	--   autocomplete = false
	-- },
	sources = {
		{name = 'path'},
		{name = 'nvim_lsp'},
		-- All buffer
		{
			name = 'buffer',
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end
			}
		},
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = false}),
		['<C-y>'] = cmp.mapping.confirm({select = false}),
		['<C-e>'] = cmp.mapping.abort(),
		['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
		['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
		['<C-p>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item({behavior = 'insert'})
			else
				cmp.complete()
			end
		end),
		['<C-n>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item({behavior = 'insert'})
			else
				cmp.complete()
			end
		end),
		['<C-Space>'] = cmp.mapping.complete(),

		["<Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item()
			else
				neotab.tabout()
			end
		end),	
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			else
				-- Trigger <C-d>
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-d>', true, true, true), 'i', true)
			end
		end),	
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})

