return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ pane = 1, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ icon = " ", key = "s", desc = "Restore Session", section = "session", padding = 1 },
				{ section = "startup" },
			},
		},
		explorer = {
			enabled = true,
			replace_netrw = true,
			trash = true,
		},
		indent = { enabled = true },
		input = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				lsp_references = {
					win = {
						preview = {
							wo = {
								wrap = true,
								linebreak = true,
							},
						},
					},
				},
				files = {
					hidden = true,
					ignored = true,
					exclude = {
						"**/.tmp/*",
						"**/{node_modules,.next,.git,dist,vendor}/*",
					},
				},
				explorer = {
					follow_file = true,
					hidden = true,
					ignored = true,
					layout = {
						layout = {
							width = 50,
							min_width = 50,
						},
					},
					exclude = {
						"**/.tmp/*",
						"**/{node_modules,.next,.git,dist,vendor}/*",
					},
				},
			},
		},
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		local ok, rename = pcall(require, "snacks.rename")
		if not ok then
			return
		end

		rename.on_rename_file = function(from, to, on_rename)
			local changes = {
				files = {
					{
						oldUri = vim.uri_from_fname(from),
						newUri = vim.uri_from_fname(to),
					},
				},
			}

			local clients = (vim.lsp.get_clients or vim.lsp.get_active_clients)()
			for _, client in ipairs(clients) do
				if client.supports_method and client:supports_method("workspace/willRenameFiles") then
					local resp = client:request_sync("workspace/willRenameFiles", changes, 1000, 0)
					if resp and resp.result ~= nil then
						vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
					end
				end
			end

			if on_rename then
				on_rename()
			end

			for _, client in ipairs(clients) do
				if client.supports_method and client:supports_method("workspace/didRenameFiles") then
					client:notify("workspace/didRenameFiles", changes)
				end
			end
		end
	end,
	keys = {
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "[S]earch [H]elp",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "[S]earch [K]eymaps",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files({
					cwd = vim.g.startup_cwd or vim.fn.getcwd(),
					dirs = { vim.g.startup_cwd or vim.fn.getcwd() },
				})
			end,
			desc = "[F]ind Files",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.pickers()
			end,
			desc = "[S]earch [S]elect Picker",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			mode = { "n", "x" },
			desc = "[S]earch current [W]ord",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "[S]earch by [G]rep",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[S]earch [D]iagnostics",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.resume()
			end,
			desc = "[S]earch [R]esume",
		},
		{
			"<leader>s.",
			function()
				Snacks.picker.recent()
			end,
			desc = '[S]earch Recent Files ("." for repeat)',
		},
		{
			"<leader><leader>",
			function()
				Snacks.picker.buffers({
					sort_lastused = true,
					current = false,
				})
			end,
			desc = "[ ] Find existing buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.lines()
			end,
			desc = "[/] Fuzzily search in current buffer",
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "[S]earch [/] in Open Files",
		},
		{
			"<leader>sn",
			function()
				Snacks.picker.files({
					cwd = vim.fn.stdpath("config"),
				})
			end,
			desc = "[S]earch [N]eovim files",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
	},
}
