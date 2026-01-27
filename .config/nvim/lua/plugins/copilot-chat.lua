return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			model = 'claude-sonnet-4.5',
			temperature = 0.1,
			window = {
				layout = 'vertical',
				width = 0.3,
			},
			auto_insert_mode = true,

			headers = {
				user = '👤 You',
				assistant = '🤖 Copilot',
				tool = '🔧 Tool',
			},

			separator = '━━',
			auto_fold = true, -- Automatically folds non-assistant messages
			prompts = {}
		},
		config = function()
			local copilot_chat = require('CopilotChat')

			vim.api.nvim_create_autocmd('BufEnter', {
				pattern = 'copilot-*',
				callback = function()

					-- Enable markdown syntax highlighting
					vim.cmd('setlocal filetype=markdown')

					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
					vim.opt_local.conceallevel = 0

					vim.keymap.set('n', '<C-l>', '<C-w>l', { buffer = true, desc = 'Move to Right Window' })

					vim.keymap.set('n', 'q', function()
						copilot_chat.stop()
					end, { buffer = true, desc = 'Stop Completion' })

					vim.keymap.set('n', '<leader>q', function()
						copilot_chat.close()
					end, { buffer = true, desc = 'Close Copilot Chat' })

					vim.keymap.set('n', '<leader>r', function()
						copilot_chat.reset()
					end, { buffer = true, desc = 'Restart Copilot Chat' })
				end,
			})

			vim.keymap.set('n', '<C-l>', '<C-w>l', { buffer = true, desc = 'Move to Right Window' })

			vim.keymap.set('n', '<leader>ccc', function()
				copilot_chat.open()
			end, { desc = 'Open Copilot Chat' })

			vim.keymap.set('n', '<leader>cce', function()
				copilot_chat.ask('/COPILOT_EXPLAIN')
			end, { desc = 'Open Copilot Explain' })

			vim.keymap.set('n', '<leader>ccd', function()
				copilot_chat.ask('/COPILOT_DOCS')
			end, { desc = 'Open Copilot Docs' })

			vim.keymap.set('n', '<leader>ccf', function()
				copilot_chat.ask('/COPILOT_FIX')
			end, { desc = 'Open Copilot Fix' })
		end
	},
}

