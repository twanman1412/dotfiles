return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set("i", "<C-y>", 'copilot#Accept("<CR>")', {
			expr = true,
			replace_keycodes = false,
		})

		vim.g.copilot_no_tab_map = true

		-- Here we can specify which filetypes Copilot should be enabled for.
		-- Tough it is enabled by default for most filetypes.
		vim.g.copilot_filetypes = {}
	end
}

