local M = {}

-- add extra plugins here
M.plugins = {
  { "tpope/vim-fugitive" },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } }
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  { "xiyaowong/transparent.nvim" },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        virtual_text = {
          enabled = false,
          filetypes = {
            -- odin = false,
            -- c = false,
            -- cpp = false,
            -- go = false,
            -- lua = false,
            ts = true,
            tsx = true,
            cs = true,
          },
          key_bindings = {
            accept = '<F12>',
            next = '<F11>',
            prev = '<F10>'
          }
        },
      })
    end
  },
  {
    'fmbarina/pick-lsp-formatter.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Optional, better picker
    },
    main = 'plf',
    lazy = true,
    opts = {},
  },
  { 'ThePrimeagen/vim-be-good' },
  { 'prettier/vim-prettier' },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      require("AndrrsDap").setup()
      -- local dap = require "dap"
      -- local ui = require "dapui"
      --
      -- dap.adapters.codelldb = {
      --   type = "server",
      --   port = "${port}",
      --   executable = {
      --     command = "codelldb",
      --     args = { "--port", "${port}" },
      --   },
      -- }
      --
      -- dap.configurations.c = {
      --   {
      --     name = "Launch",
      --     type = "codelldb",
      --     request = "launch",
      --     program = function()
      --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
      --     end,
      --     cwd = "${workspaceFolder}",
      --     stopOnEntry = false,
      --   }
      -- }
      --
      -- ui.setup()
      -- dap.listeners.after.event_initialized["dapui_config"] = function()
      --   ui.open()
      -- end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   ui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   ui.close()
      -- end
      --
      -- vim.keymap.set("n", "<leader>bp", dap.toggle_breakpoint)
      -- vim.keymap.set('n', '<leader>rd', dap.continue)
      -- vim.keymap.set('n', '<leader>so', dap.step_over)
      -- vim.keymap.set('n', '<leader>si', dap.step_into)
    end
  },
  {
    'goolord/alpha-nvim',
    config = function ()
      require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  },
  {
    'robitx/gp.nvim',
    config = function()
      local conf = {
        provider = "github_copilot",
        providers = {
            copilot = {
                endpoint = "https://api.githubcopilot.com/chat/completions",
                secret = {
                    "bash",
                    "-c",
                    "cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
                },
            },
        },
        agents = {
          {
            name = 'ChatGPT4o',
            disable = true,
          },
          {
            name = 'ChatGPT4o-mini',
            disable = true,
          }
        }
      }
      require('gp').setup(conf)
    end,
  },
  -- {
  --   'github/copilot.vim'
  -- },
  {
    'editorconfig/editorconfig-vim'
  },
  {
    "sylvanfranklin/omni-preview.nvim",
    dependencies = {
      -- CSV
      { "hat0uma/csvview.nvim", lazy = true },
      -- markdown
      { "toppair/peek.nvim", lazy = true, build = "deno task --quiet build:fast" },
    },
    config = function()
      require("omni-preview").setup({})
      require("csvview").setup({
        view = {
          header_lnum = 0,
          sticky_header = { enabled = true },
          display_mode = "border",
        },
        keymaps = {
          -- Text objects for selecting fields
          textobject_field_inner = { "if", mode = { "o", "x" } },
          textobject_field_outer = { "af", mode = { "o", "x" } },
          -- Excel-like navigation:
          -- Use <Tab> and <S-Tab> to move horizontally between fields.
          -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
          -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
          jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
          jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
          jump_next_row = { "<Enter>", mode = { "n", "v" } },
          jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
      })
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

      vim.keymap.set("n", "<leader>P", ":OmniPreview toggle<CR>", { silent = true })
    end,
  },
  {
    "3rd/image.nvim",
    build = false,
    oopts = {
      processor = "magick_cli",
    }
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
  {
      "waizui/anal.nvim",
  },
  {
      "mikesmithgh/ugbi",
  },
  {
      "jake-stewart/multicursor.nvim",
      branch = "1.0",
      config = function()
          local mc = require("multicursor-nvim")
          mc.setup()

          local set = vim.keymap.set

          -- Add or skip cursor above/below the main cursor.
          set({"n", "x"}, "<up>", function() mc.lineAddCursor(-1) end)
          set({"n", "x"}, "<down>", function() mc.lineAddCursor(1) end)
          set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
          set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)

          -- Add or skip adding a new cursor by matching word/selection
          set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
          set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
          set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
          set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)

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
  { 'tikhomirov/vim-glsl' },
}

-- add extra configuration options here, like extra autocmds etc.
-- feel free to create your own separate files and require them in here
M.configs = function()
  local harpoon = require("harpoon")

  harpoon:setup()

  require("oil").setup({
    columns = { "icon" },
    keymaps = {
      ["<C-h>"] = false,
      ["<M-h>"] = "actions.select_split",
    },
    view_options = {
      show_hidden = true,
    },
  })

  require("buildCommands").setup({
    tableLocation = "/build/.nvimbc"
  })
end

-- add servers to be used for auto formatting here
M.formatting_servers = {
  rust_analyzer = {},
  lua_ls = {},
}

-- add Tree-sitter to auto-install
M.ensure_installed = { "toml" }

-- add any null-ls sources you want here
M.setup_sources = function(b)
  return {
    b.formatting.autopep8,
    b.formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" }
    },
    b.formatting.black.with {
      extra_args = { "--fast" }
    },
    b.formatting.stylua,
  }
end

return M
