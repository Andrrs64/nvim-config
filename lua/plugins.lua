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

            local meta = vim.fn.has("mac") == 1 and "<D-" or "<M-"

            -- Add or skip cursor above/below the main cursor.
            set({"n", "x"}, meta.."k>", function() mc.lineAddCursor(-1) end)
            set({"n", "x"}, meta.."j>", function() mc.lineAddCursor(1) end)
            set({"n", "x"}, "<leader>"..meta.."k>", function() mc.lineSkipCursor(-1) end)
            set({"n", "x"}, "<leader>"..meta.."j>", function() mc.lineSkipCursor(1) end)

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
    {
        'johnfrankmorgan/whitespace.nvim',
        config = function ()
            require('whitespace-nvim').setup({
                -- configuration options and their defaults

                -- `highlight` configures which highlight is used to display
                -- trailing whitespace
                highlight = 'DiffDelete',

                -- `ignored_filetypes` configures which filetypes to ignore when
                -- displaying trailing whitespace
                ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'dashboard' },

                -- `ignore_terminal` configures whether to ignore terminal buffers
                ignore_terminal = true,

                -- `return_cursor` configures if cursor should return to previous
                -- position after trimming whitespace
                return_cursor = true,
            })

            -- remove trailing whitespace with a keybinding
            vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim)
        end
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
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" }}
            }
        }
    },

    -- sessions
    {
        "rmagatti/auto-session",
        lazy = false,
        keys = {
            -- Will use Telescope if installed or a vim.ui.select picker otherwise
            { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
            { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
            { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
        },

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            -- The following are already the default values, no need to provide them if these are already the settings you want.
            session_lens = {
                picker = nil, -- "telescope"|"snacks"|"fzf"|"select"|nil Pickers are detected automatically but you can also manually choose one. Falls back to vim.ui.select
                mappings = {
                    -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
                    delete_session = { "i", "<C-d>" },
                    alternate_session = { "i", "<C-s>" },
                    copy_session = { "i", "<C-y>" },
                },

                picker_opts = {
                -- For Telescope, you can set theme options here, see:
                -- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
                -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/themes.lua
                --
                -- border = true,
                -- layout_config = {
                --   width = 0.8, -- Can set width and height as percent of window
                --   height = 0.5,
                -- },

                -- For Snacks, you can set layout options here, see:
                -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
                --
                -- preset = "dropdown",
                -- preview = false,
                -- layout = {
                --   width = 0.4,
                --   height = 0.4,
                -- },

                -- For Fzf-Lua, picker_opts just turns into winopts, see:
                -- https://github.com/ibhagwan/fzf-lua#customization
                --
                --  height = 0.8,
                --  width = 0.50,
                },

                -- Telescope only: If load_on_setup is false, make sure you use `:AutoSession search` to open the picker as it will initialize everything first
                load_on_setup = true,
                auto_save_enabled = true,
                auto_restore_enabled = true,
                pre_save_cmds = { "wa" },
            },
        },
    },

    -- random
    {
        "gruvw/strudel.nvim",
        build = "npm ci",
        config = function()
            require("strudel").setup()
        end,
    },
}
