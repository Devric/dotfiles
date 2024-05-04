use = require('packer').use

use {
	"folke/which-key.nvim",
	requires = {
		"epwalsh/obsidian.nvim",
	},
	config = function() 
		local wk = require("which-key")
		local fzf = require('fzf-lua')


		-- Required to init whikey
		wk:setup {}

		-- Bindings
		wk.register(
			{
				[ "<C-Space>" ] = {
					name = "   Secret Menu    ",

					-- Obsidiant
					o = {
						-- :ObsidianYesterday to open/create the daily note for the previous working day.
						-- :ObsidianTomorrow to open/create the daily note for the next working day.
						-- :ObsidianDailies [OFFSET ...] to open a picker list of daily notes. For example, :ObsidianDailies -2 1 to list daily notes from 2 days ago until tomorrow.
						-- :ObsidianTemplate [NAME] to insert a template from the templates folder, selecting from a list using your preferred picker. See "using templates" for more information.
						-- :ObsidianLinkNew [TITLE] to create a new note and link it to an inline visual selection of text. This command has one optional argument: the title of the new note. If not given, the selected text will be used as the title.
						-- :ObsidianWorkspace [NAME] to switch to another workspace.
						-- :ObsidianPasteImg [IMGNAME] to paste an image from the clipboard into the note at the cursor position by saving it to the vault and adding a markdown image link. You can configure the default folder to save images to with the attachments.img_folder option.
						name = "Obsidiant",
						o = {
							function()
								-- vim.api.nvim_command(":ObsidianQuickSwitch")
								fzf.files({
									cwd = "/Users/devric/odrive/Dropbox/Apps/logseq",
									cmd = 'fd --type f  --exclude .svn --exclude .git --exclude .obsidian --exclude .DS_Store --exclude logseq/bak --exclude logseq/.recycle --exclude *.edn --exclude logseq/custom.css --exclude assets'
								})
							end,
							"Open Notes",
						},
						n = { function() vim.api.nvim_command(":ObsidianNew")       end , "New Notes [title]" },
						t = { function() vim.api.nvim_command(":ObsidianTags")      end , "Open Tag [tag]" },
						b = { function() vim.api.nvim_command(":ObsidianBacklinks") end , "List Backlinks" },
						d = { function() vim.api.nvim_command(":ObsidianToday")     end , "Open Today's Note" },
						s = { function() vim.api.nvim_command(":ObsidianSearch")    end , "Search..." },
						r = { function() vim.api.nvim_command(":ObsidianRename")    end , "Rename [New Name]" },
						l = { function() vim.api.nvim_command(":ObsidianLinks")     end , "Open links picker" },
						L = { function() vim.api.nvim_command(":ObsidianLinkNew")   end , "Create new [note] and link to current" },
					},

					-- diffview
					d = {
						name = "DiffView",
						o = { function() vim.api.nvim_command(":DiffviewOpen")        end , "Open" },
						c = { function() vim.api.nvim_command(":DiffviewClose")       end , "Close" },
						t = { function() vim.api.nvim_command(":DiffviewToggle")      end , "Toggle" },
						f = { function() vim.api.nvim_command(":DiffviewFileHistory") end , "File History" },
						h = { function() vim.api.nvim_command(":DiffviewHelp")        end , "Help" },
					},

					-- Packer
					p = {
						name = "Packer",
						s = { function() vim.api.nvim_command(":PackerSync")    end , "Packer Sync" },
						c = { function() vim.api.nvim_command(":PackerCompile") end , "Packer compile" },
						l = { function() vim.api.nvim_command(":PackerClean")   end , "Packer Clean" },
					},

					-- t = {
					-- 	function()
					-- 		print(vim.fn.expand("<cword>"))
					-- 		fzf.files()
					-- 	vim.fn.expand("<cword>")
					-- 	end,
					-- 	"test",
					-- },
				},
			},
			{} -- this is required, can be kept empty for normal mode
		)
		wk.register(
			{
				-- Obsidiant
				o = {
					name = "Obsidiant Visual",
					e = { function() vim.api.nvim_command(":ObsidianExtractNote") end, "Extract visual block to new note" },
					l = { function() vim.api.nvim_command(":ObsidianLink") end, "To link an inline visual selection to a [NOTE]" },
				},
			},
			{
				prefix = "<leader>",
				mode = "v",

			}
		)
	end
}
