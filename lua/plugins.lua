return {
	-- Colorscheme
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("nord")
		end,
	},

    -- Utilities
    { "junegunn/vim-easy-align" },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()

            local set = vim.keymap.set

            -- Add or skip cursor above/below the main cursor.
            set({"n", "x"}, "<M-k>", function() mc.lineAddCursor(-1) end)
            set({"n", "x"}, "<M-j>", function() mc.lineAddCursor(1) end)
            set({"n", "x"}, "<leader><M-k>", function() mc.lineSkipCursor(-1) end)
            set({"n", "x"}, "<leader><M-j>", function() mc.lineSkipCursor(1) end)

            -- Add or skip adding a new cursor by matching word/selection
            set({"n", "x"}, "gl", function() mc.matchAddCursor(1) end)
            set({"n", "x"}, "g>", function() mc.matchSkipCursor(1) end)
            set({"n", "x"}, "gL", function() mc.matchAddCursor(-1) end)
            set({"n", "x"}, "g<", function() mc.matchSkipCursor(-1) end)

            -- Add and remove cursors with control + left click.
            set("n", "<c-leftmouse>", mc.handleMouse)
            set("n", "<c-leftdrag>", mc.handleMouseDrag)
            set("n", "<c-leftrelease>", mc.handleMouseRelease)

            -- Disable and enable cursors.
            set({"n", "x"}, "<c-q>", mc.toggleCursor)

            -- Mappings defined in a keymap layer only apply when there are
            -- multiple cursors. This lets you have overlapping mappings.
            mc.addKeymapLayer(function(layerSet)

                -- Select a different cursor as the main one.
                layerSet({"n", "x"}, "<left>", mc.prevCursor)
                layerSet({"n", "x"}, "<right>", mc.nextCursor)

                -- Delete the main cursor.
                layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

                -- Enable and clear cursors using escape.
                layerSet("n", "<esc>", function()
                    if not mc.cursorsEnabled() then
                        mc.enableCursors()
                    else
                        mc.clearCursors()
                    end
                end)
            end)

            -- Customize how cursors look.
            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", { reverse = true })
            hl(0, "MultiCursorVisual", { link = "Visual" })
            hl(0, "MultiCursorSign", { link = "SignColumn"})
            hl(0, "MultiCursorMatchPreview", { link = "Search" })
            hl(0, "MultiCursorDisabledCursor", { reverse = true })
            hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
            hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
        end,
    },

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Transparent background
	{
		"xiyaowong/transparent.nvim",
		opts = {},
	},

	-- Git
	{ "tpope/vim-fugitive" },
    { "lewis6991/gitsigns.nvim" },

	-- Icons
	{ "nvim-tree/nvim-web-devicons" },

	-- File explorer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			view_options = {
				show_hidden = true,
			},
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "go", "rust" },
			auto_install = true,
			highlight = { enable = true },
		},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()

			local lspconfig = require("lspconfig")
			local on_attach = function(_, bufnr)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				map("<leader>jd", vim.lsp.buf.definition, "Go to definition")
				map("<leader>sd", vim.lsp.buf.hover, "Hover documentation")
				map("<leader>rf", vim.lsp.buf.references, "References")
				map("<leader>fc", vim.lsp.buf.code_action, "Code actions")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>se", vim.diagnostic.open_float, "Diagnostic float")
				map("<leader>ds", vim.diagnostic.setloclist, "Diagnostic list")
			end

			require("mason-lspconfig").setup({
				automatic_installation = true,
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							on_attach = on_attach,
						})
					end,
				},
			})
		end,
	},
}
