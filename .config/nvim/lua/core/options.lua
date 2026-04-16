local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, "p")
end

-- Prevent LSP from overwriting treesitter color settings
vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.editorconfig = true
vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.nvim_tree_disable_netrw = 0 -- 1 by default, disables netrw
vim.g.nvim_tree_hijack_netrw = 1 -- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)

vim.opt.undodir = undodir
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.breakindent = true -- Enable break indent
vim.opt.conceallevel = 2
vim.opt.concealcursor = ""
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Faster completion
vim.opt.timeoutlen = 400 -- Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)
vim.opt.ttimeoutlen = 50 -- key code timeout
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.cursorline = false -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.termguicolors = true -- Set termguicolors to enable highlight groups (default: false)
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.autochdir = false -- do not autochange directories
vim.opt.hidden = true -- allow hidden buffers
vim.opt.shortmess:append("c") -- Don't give |ins-completion-menu| messages (default: does not include 'c')
vim.opt.iskeyword:append("-") -- Hyphenated words recognized by searches (default: does not include '-')
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')
vim.opt.incsearch = true -- Incremental search
vim.opt.cmdheight = 0 -- Set cmd height
vim.opt.encoding = "utf-8" -- set encoding
vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right
vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.o.whichwrap = "bs<>[]hl" -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
vim.o.wrap = false -- Display lines as one long line (default: true)
vim.o.linebreak = false -- Companion to wrap, don't split words (default: false)
vim.o.expandtab = true -- Convert tabs to spaces (default: false)
vim.o.swapfile = false -- Creates a swapfile (default: true)
vim.o.smartindent = true -- Make indenting smarter again (default: false)
vim.o.pumheight = 10 -- Pop up menu height (default: 0)
vim.o.conceallevel = 0 -- So that `` is visible in markdown files (default: 1)
vim.o.confirm = true -- Raise dialog if you try to close unsaved buffer
vim.o.fileencoding = "utf-8" -- The encoding written to a file (default: 'utf-8')
vim.o.cmdheight = 1 -- More space in the Neovim command line for displaying messages (default: 1)
vim.o.breakindent = true -- Enable break indent (default: false)
vim.o.backup = false -- Creates a backup file (default: false)
vim.o.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited (default: true)
vim.o.undofile = true -- Save undo history (default: false)
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience (default: 'menu,preview')
vim.o.backspace = "indent,eol,start" -- Allow backspace on (default: 'indent,eol,start')
vim.o.winborder = "single"

vim.wo.signcolumn = "yes" -- Keep signcolumn on by default (default: 'auto')

vim.cmd("syntax on") -- Disable Vim syntax highlight so missing Treesitter parser is visible

vim.schedule(function() -- Sync clipboard between OS and Neovim.
	vim.opt.clipboard = "unnamedplus"
end)

vim.diagnostic.config({
	float = {
		source = "if_many",
		border = "rounded",
	},
	jump = {
		on_jump = { float = true },
	},
	severity_sort = true, -- show most severe error first
	update_in_insert = false, -- don't update while typing
})
