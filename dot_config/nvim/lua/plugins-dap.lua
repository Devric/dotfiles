local use = require('packer').use

use {
	"rcarriga/nvim-dap-ui",
	requires = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"mxsdev/nvim-dap-vscode-js",
		{
			"microsoft/vscode-js-debug",
			run = "node install && node run compile",
		},
	},
	config = function()

		require("dap-vscode-js").setup({
			-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
			debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
			-- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
			adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
			-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
			-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
			-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
		})


		local dap, dapui = require("dap"), require("dapui")

		-- Setup Dapui
		dapui.setup()

		-- Configure debuger
		--    dap.adapters['pwa-node'] = {
		--    	type = "server",
		--    	host = "::1", -- 127.0.0.1
		--    	port = '${port}',
		--    	executable = {
		--    		--command = "js-debug-adapter",
		--    		command = "bun",
		--    		args = {
		--    			'${port}',
		--    		},
		--    	}
		--    }

		--    for _, language in pairs({ "typescript", "javascript" }) do
		--    	dap.configurations[language] = {
		--    		{
		--    			type = 'pwa-node',
		--    			request = 'launch',
		--    			name = 'Launch file',
		--    			program = '${file}',
		--    			cwd = '${workspaceFolder}',
		--    			runtimeExecutable = "bun",
		--    		},
		--    	}
		--    end
		local js_based_languages = { "typescript", "javascript", "typescriptreact" }

		for _, language in ipairs(js_based_languages) do
			require("dap").configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require 'dap.utils'.pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Start Chrome with \"localhost\"",
					url = "http://localhost:3000",
					webRoot = "${workspaceFolder}",
					userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
				}
			}
		end

		-- DAP-UI attachers
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end


		-- DAP KeyMaps
		vim.keymap.set('n', '<F5>', require 'dap'.continue)
		vim.keymap.set('n', '<F10>', require 'dap'.step_over)
		vim.keymap.set('n', '<F11>', require 'dap'.step_into)
		vim.keymap.set('n', '<F12>', require 'dap'.step_out)
		vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
		vim.keymap.set('n', '<leader>B', function()
			require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
		end)
		vim.keymap.set('n', '<leader>ui', function() dapui.toggle() end)
	end
}
