local use = require('packer').use

use {
	"rcarriga/nvim-dap-ui",
	requires = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"mxsdev/nvim-dap-vscode-js",
		{
			"microsoft/vscode-js-debug",
			run = "bun install --legacy-peer-deps && bun run compile",
		},
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		-- Setup Dapui
		dapui.setup()

		-- Configure debuger
		dap.adapters['pwa-node'] = {
			type = "server",
			host = "::1", -- 127.0.0.1
			port = '${port}',
			executable = {
				--command = "js-debug-adapter",
				args = {
					'${port}',
				},
			}
		}

		for _, language in pairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					type = 'pwa-node',
					request = 'launch',
					name = 'Launch file',
					program = '${file}',
					cwd = '${workspaceFolder}',
					runtimeExecutable = "bun",
				},
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
