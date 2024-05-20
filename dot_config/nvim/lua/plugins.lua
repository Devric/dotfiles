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
	use { 
		'mbbill/undotree' ,
		config = function()
		end
	}
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
		requires = {'nvim-tree/nvim-web-devicons'},
		config = function() require 'barbar'.setup {
			animation = true,
			auto_hide = true,
			tabpages = true,
			icons = {
				preset = 'slanted'
			},
			minimum_padding = 2,
		} end
	}

	use {
		'nvim-tree/nvim-tree.lua',
		requires = 'nvim-tree/nvim-web-devicons',
		config = function() require'nvim-tree'.setup {} end
	}

	use {
		"lukas-reineke/indent-blankline.nvim",
		config = function() require'ibl'.setup {} end
	}

	-- Replacing nvim-tree
	use({
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	})

	use {
		'norcalli/nvim-colorizer.lua',
		config = function()
			require'colorizer'.setup()
		end
	}



	use{
		"epwalsh/obsidian.nvim",
		tag = "*",  -- recommended, use latest release instead of latest commit
		requires = {
			-- Required.
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
			"hrsh7th/nvim-cmp",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- Using both Logseq + Obsidiant(Logseq/journals folder)
			require("obsidian").setup({
				workspaces = {
					{
						name = "logseq",
						path = "~/odrive/Dropbox/Apps/logseq",
					},
				},

				notes_subdir = "pages",

				picker = {
					name = "fzf-lua",
					mappings = {
						-- Create a new note from your query.
						new = "<C-x>",
						-- Insert a link to the selected note.
						insert_link = "<C-l>",
					},
				},
				completion = {
					-- Set to false to disable completion.
					nvim_cmp = true,
					-- Trigger completion at 2 chars.
					min_chars = 2,
  				},

				daily_notes = {
					folder = "journals",
					-- Optional, if you want to change the date format for the ID of daily notes.
					date_format = "%Y_%m_%d",
				},

				note_id_func = function(title)
					-- Create note IDs with a timestamp and a suffix in the format {YYYY_MM_DD}-scrap-{title}.
					local suffix = ""
					local currentDate = os.date("%Y_%m_%d")

					if title ~= nil then
						-- If title is given, transform it into a valid file name.
						suffix = title:gsub("[ %-]", "_"):gsub("[^A-Za-z0-9_]", ""):lower()
					else
						-- If title is nil, just add 4 random uppercase letters to the suffix.
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return currentDate .. "-scrap-" .. suffix
				end,

				mappings = {
					-- Defaults
					-- ["gf"] = { }, Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
					-- ["<leader>ch"] = { }, -- Toggle check-boxes. :ObsidianToggleCheckbox to cycle through checkbox options.
					-- ["<cr>"] = { } -- Smart action depending on context, either follow link or toggle checkbox. :ObsidianFollowLink [vsplit|hsplit] to follow a note reference under the cursor, optionally opening it in a vertical or horizontal split.
				},
			})
		end,
	}

	-- use 'tomlion/vim-solidity'
	use 'mattn/emmet-vim'

	-- UTILITY
	use 'AndrewRadev/splitjoin.vim'
	use 'editorconfig/editorconfig-vim'

	
	-- auto close delimiters
	use {
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup {}
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
		},
		config = function()
			require"fzf-lua".setup({
				-- "fzf-vim",
				"fzf-native",
				winopts={preview={default="bat"}},
				files = {
					fd_opts = "--color=never --type f --hidden --follow --exclude .svn --exclude .git --exclude .obsidian --exclude .DS_Store --exclude logseq/bak --exclude logseq/.recycle --exclude *.edn --exclude logseq/custom.css"
				},
			})
		end
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

	use "sindrets/diffview.nvim"


	use {
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require "harpoon"

			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
			vim.keymap.set("n", "<C-m>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<S-Left>", function() harpoon:list():prev() end)
			vim.keymap.set("n", "<S-Right>", function() harpoon:list():next() end)
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
					"vue",
					"markdown",
					"markdown_inline",
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


	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			{'neovim/nvim-lspconfig'},

			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-cmdline'},
			{'L3MON4D3/LuaSnip'},
			{"kawre/neotab.nvim"},
		}
	}

	use {
		"hedyhli/outline.nvim",
		config = function()
			-- -- Example mapping to toggle outline
			-- vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
			-- 	{ desc = "Toggle Outline" })

			require("outline").setup {
				-- Your setup opts here (leave empty to use defaults)
			}
		end
	}

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
	-- https://github.com/alexghergh/nvim-tmux-navigation
	-- https://github.com/tpope/vim-dadbod
	-- https://github.com/tpope/vim-distant
	-- https://github.com/brooth/far.vim



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

	-- AI suggestion
	use {
		"Exafunction/codeium.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({ 
				enable_chat = true,
			})
		end
	}


	-- =======================
	-- End edit Plugin> run PackerSync after adding plugin
	-- =======================

	if packer_bootstrap then
		require('packer').sync()
	end
end)

