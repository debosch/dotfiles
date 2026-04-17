return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "echasnovski/mini.icons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")
		local startup_cwd = vim.g.startup_cwd or vim.fn.getcwd()
		local startup_search_dirs = { startup_cwd }

		local function new_find_files_command()
			return {
				"rg",
				"-uu",
				"--files",
				"--smart-case",
				"--hidden",
				"--glob",
				"!**/.tmp/*",
				"--glob",
				"!**/{node_modules,.next,.git,dist,vendor}/*",
			}
		end

		local filename_first_entry_index = {
			ordinal = function(t)
				local path = rawget(t, 1)
				local filename = vim.fs.basename(path)
				local stem = vim.fn.fnamemodify(filename, ":r")
				return string.format("%s %s", stem, filename), true
			end,
		}

		local buffer_entry_index = {
			ordinal = function(t)
				local path = t.filename or t.value or ""
				local filename = vim.fs.basename(path)
				local stem = vim.fn.fnamemodify(filename, ":r")
				return string.format("%s %s", stem, filename), true
			end,
		}

		local path_entry_index = {
			ordinal = function(t)
				local path = rawget(t, 1) or ""
				return path, true
			end,
		}

		local dropdown_theme = themes.get_dropdown({
			winblend = 10,
			previewer = false,
		})

		telescope.setup({
			defaults = {
				path_display = {
					filename_first = {
						reverse_directories = true,
					},
				},
				layout_config = {},
				mappings = {
					i = {
						["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
						["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
						["<C-l>"] = require("telescope.actions").select_default, -- open file
						["<C-y>"] = require("telescope.actions").select_default, -- open file
						["<C-u>"] = false,
						["<esc>"] = actions.close,
					},
				},
			},
			pickers = {
				buffers = {
					previewer = false,
					entry_index = buffer_entry_index,
				},
				find_files = {
					theme = "dropdown",
					entry_index = filename_first_entry_index,
					find_command = new_find_files_command(),
				},
				lsp_references = {
					fname_width = 100,
					trim_text = true,
				},
			},
			live_grep = {
				glob_pattern = "!**/{node_modules,.next,.git,package-lock.json}/*",
				file_ignore_patterns = { "node_modules/", ".git/" },
				additional_args = function(_)
					return { "--hidden" }
				end,
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")

		local function find_files_by_name()
			builtin.find_files({
				theme = "dropdown",
				cwd = startup_cwd,
				search_dirs = startup_search_dirs,
				entry_index = filename_first_entry_index,
				find_command = new_find_files_command(),
			})
		end

		local function find_files_by_path()
			builtin.find_files({
				theme = "dropdown",
				cwd = startup_cwd,
				search_dirs = startup_search_dirs,
				entry_index = path_entry_index,
				path_display = { "smart" },
				find_command = new_find_files_command(),
			})
		end

		local function find_buffers_by_name()
			builtin.buffers({
				theme = "dropdown",
				sort_mru = true,
				sort_lastused = true,
				ignore_current_buffer = true,
				entry_index = buffer_entry_index,
			})
		end

		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>ff", find_files_by_name, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>fp", find_files_by_path, { desc = "[F]ind by [P]ath" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", find_buffers_by_name, { desc = "[ ] Find existing buffers" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(dropdown_theme)
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
				entry_index = filename_first_entry_index,
				find_command = new_find_files_command(),
			})
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
