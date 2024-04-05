-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
	use {'wbthomason/packer.nvim', opt = true}

	-- =======================
	-- Start edit Plugin
	-- =======================
	
	-- Theme
	use 'morhetz/gruvbox'
	use 'olimorris/onedarkpro.nvim'
	
	-- UI
	use 'mbbill/undotree'
	use 'yamatsum/nvim-cursorline'
	use {
		'nvim-lualine/lualine.nvim',
		wants = {'nvim-tree/nvim-web-devicons', opt = true},
		config = function() require'lualine'.setup {
			theme = 'gruvbox'
		} end
	}
	use {
		'romgrk/barbar.nvim',
		requires = {'nvim-tree/nvim-web-devicons'}
	}
	use {
		'nvim-tree/nvim-tree.lua',
		requires = 'nvim-tree/nvim-web-devicons',
		config = function() require'nvim-tree'.setup {} end
	}
	use {
		'norcalli/nvim-colorizer.lua',
		config = function()
			require'colorizer'.setup()
		end
	}

	use 'tomlion/vim-solidity'
	use 'mattn/emmet-vim'


	use {
		"luukvbaal/stabilize.nvim",
		config = function() require("stabilize").setup() end
	}

	-- UTILITY
	use 'AndrewRadev/splitjoin.vim'
	use 'editorconfig/editorconfig-vim'

	--use {
	--	"folke/which-key.nvim",
	--	config = function() require("which-key").setup {
	--		-- your configuration comes here
	--		-- or leave it empty to use the default settings
	--		-- refer to the configuration section below
	--	} end
	--}
	
	-- auto close delimiters
	use {
		'steelsojka/pears.nvim', 
		config = function()
			require "pears".setup(function(conf)
				conf.pair = {include = {"<", "<!--"}}
				-- conf.preset "tag_matching"
				-- with completion integration
				conf.on_enter(function(pears_handle)
					if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
						vim.cmd[[:startinsert | call feedkeys("\<c-y>")]]
					else
						pears_handle()
					end
				end)
			end)
		end
	}
	use 'tpope/vim-commentary'
	use {'kkoomen/vim-doge', run = ":call doge#install()"}
	use {
		'phaazon/hop.nvim',
		as = 'hop',
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	}
	use {
		'karb94/neoscroll.nvim',
		config = function() require'neoscroll'.setup {} end
	}
	use "godlygeek/tabular"
	use { 'junegunn/fzf', run = './install --bin' }
	use {
		'ibhagwan/fzf-lua',
		requires = {
			'vijaymarupudi/nvim-fzf',
			'nvim-tree/nvim-web-devicons'
		}
	}
	use {
		"https://github.com/ur4ltz/surround.nvim",
		config = function()
			require"surround".setup {mappings_style = "sandwich"}
		end
	}
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			require('gitsigns').setup()
		end
	}
	
	-- allows quickly select window
	use 'https://gitlab.com/yorickpeterse/nvim-window.git'

	-- Syntax
	use 'windwp/nvim-ts-autotag' -- use with treesiter autotag enable
	use 'chemzqm/vim-jsx-improve'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup {
				autotag = {
					enable = true
				},
				hightlight = {
					enable = true
				},
				indent = {
					enable = true
				},
				ensure_installed = {
					"jsonc",
					"dockerfile",
					"comment",
					"yaml",
					"toml",
					"lua",
					"graphql",
					"tsx",
					"css",
					"html",
					"svelte",
					"typescript",
					"javascript",
					"vue"
				}
			}

			require "nvim-treesitter.parsers".get_parser_configs().Solidity = {
				install_info = {
					url = "https://github.com/JoranHonig/tree-sitter-solidity",
					files = {"src/parser.c"},
					requires_generate_from_grammar = true,
				},
				filetype = 'solidity'
			}
		end
	}

	-- LSP
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		'neovim/nvim-lspconfig'
	}
	use 'simrat39/symbols-outline.nvim'
	use { 'tami5/lspsaga.nvim' } -- tami5 fix the issue of codeaction popup when theres no action, 'glepnir/lspsaga.nvim' not maintaned
	use {"ms-jpq/coq_nvim", branch = "coq"}
     	use {"ms-jpq/coq.artifacts", branch = 'artifacts'}
	use {
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}
	
	-- consider
	-- https://github.com/fedepujol/move.nvim
	-- https://github.com/alexghergh/nvim-tmux-navigation
	-- https://github.com/tpope/vim-dadbod
	-- https://github.com/tpope/vim-distant
	-- https://github.com/brooth/far.vim

	use {
		'abecodes/tabout.nvim',
		config = function()
			require('tabout').setup {
				tabkey = "",
				backward_tabkey = "",
				tabouts = {
					{open = "'", close = "'"},
					{open = '"', close = '"'},
					{open = '`', close = '`'},
					{open = '(', close = ')'},
					{open = '[', close = ']'},
					{open = '{', close = '}'},
					{open = '<', close = '>'}
				},
			}
			-- Plugin: tabout with auto completetion
			-- ====================================
			local function replace_keycodes(str)
				return vim.api.nvim_replace_termcodes(str, true, true, true)
			end

			function _G.tab_binding()
				if vim.fn.pumvisible() ~= 0 then
					return replace_keycodes("<C-n>")
				else
					return replace_keycodes("<Plug>(Tabout)")
				end
			end

			function _G.s_tab_binding()
				if vim.fn.pumvisible() ~= 0 then
					return replace_keycodes("<C-p>")
				else
					return replace_keycodes("<Plug>(TaboutBack)")
				end
			end

			vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_binding()", {expr = true})
			vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_binding()", {expr = true})
		end,
		wants = {'nvim-treesitter'} -- or require if not used so far
		-- after = {'coq'} -- if a completion plugin is using tabs load it before
	}


	-- ollama
	use {
		"David-Kunz/gen.nvim",
		config = function() require'gen'.setup {
			--model = "llama2", -- The default model to use.
			model = "deepseek-coder:33b-instruct-q4_K_M", -- The default model to use.
			display_mode = "float", -- The display mode. Can be "float" or "split".
			show_prompt = false, -- Shows the Prompt submitted to Ollama.
			show_model = false, -- Displays which model you are using at the beginning of your chat session.
			no_auto_close = false, -- Never closes the window automatically.
			init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
			-- Function to initialize Ollama
			command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
			-- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
			-- This can also be a lua function returning a command string, with options as the input parameter.
			-- The executed command must return a JSON object with { response, context }
			-- (context property is optional).
			list_models = '<omitted lua function>', -- Retrieves a list of model names
			debug = false -- Prints errors and the command which is run.
		} end
	}


	-- =======================
	-- End edit Plugin> run PackerSync after adding plugin
	-- =======================

	if packer_bootstrap then
		require('packer').sync()
	end
end)

--vim.o.background = "dark"
--require 'onedarkpro' .load()
