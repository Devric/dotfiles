-- LSR
local nvim_lsp = require('lspconfig')
-- local lsp_installer = require("nvim-lsp-installer")
local coq = require("coq")


-- lsp_installer.settings {
--     ui = {
--         icons = {
--             server_installed = "✓",
--             server_pending = "➜",
--             server_uninstalled = "✗"
--         }
--     }
-- }

-- lsp_installer.on_server_ready(function (server) server:setup {} end)

-- servers

-- local lsp_installer_servers = require'nvim-lsp-installer.servers'

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
	}
}

require("mason-lspconfig").setup_handlers({
	function (server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup(require('coq').lsp_ensure_capabilities({
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 150,
			}
		}))
	end
})


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

  -- LSP saga
  buf_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
  buf_set_keymap('n', 'gh', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts) -- lsp provider to find the cursor word definition and reference
  buf_set_keymap('n', 'ga', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts) -- lsp provider to find the cursor word definition and reference
  buf_set_keymap('n', 'gs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts) -- lsp provider to find the cursor word definition and reference
  buf_set_keymap('n', 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts) -- lsp provider to find the cursor word definition and reference
  buf_set_keymap('n', 'gd', "<cmd>lua require('lspsaga.provider').preview_definition()<CR>", opts)

  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- for key, value in ipairs(servers) do
-- 	local ok, server = lsp_installer_servers.get_server(value)
-- 	if not server:is_installed() then
-- 		server:install()
-- 	else
-- 		nvim_lsp[value].setup(
-- 			coq.lsp_ensure_capabilities {
-- 				-- Use a loop to conveniently call 'setup' on multiple servers and
-- 				-- map buffer local keybindings when the language server attaches
-- 				on_attach = on_attach,
-- 				flags = {
-- 					debounce_text_changes = 150,
-- 				}
-- 			}
-- 		)
-- 	end
-- end


-- LSP SAGA
-- ===================================================
local saga = require 'lspsaga'

-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview

saga.init_lsp_saga {
	finder_action_keys = {
		open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
	}
}

