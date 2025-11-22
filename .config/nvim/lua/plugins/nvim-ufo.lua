return {
	'kevinhwang91/nvim-ufo',
	dependencies = {
		'kevinhwang91/promise-async',
	},
	config = function()
		-- Enable fold column
		vim.o.foldcolumn = '1'

		-- Set fold level
		local foldlevel = 7
		vim.o.foldlevel = foldlevel
		vim.o.foldlevelstart = foldlevel

		vim.o.foldenable = true

		-- Using ufo provider need remap `zR` and `zM`
		vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
		vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true
		}
		local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
		for _, ls in ipairs(language_servers) do
			require('lspconfig')[ls].setup({
				capabilities = capabilities
				-- you can add other fields for setting up lsp server in this table
			})
		end
		require('ufo').setup()
	end
}

