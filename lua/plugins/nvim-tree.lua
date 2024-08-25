return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>e", ":NvimTreeFocus<CR>",  desc = "Nvim Tree Focus" },
      { "<leader>x", ":NvimTreeToggle<CR>", desc = "Nvim Tree Toggle" },
    },
    config = function()
      require("nvim-tree").setup({

        renderer = {
          icons = {
            glyphs = {
              git = {
                unstaged = "",
                staged = "S",
                renamed = "",
                untracked = "U",
                deleted = "",
                ignored = "◌"
              }
            }
          }
        },
        view = {
          adaptive_size = true,
          side = "right",
          centralize_selection = true,
        },
        hijack_directories = {
          enable = false,
          auto_open = true,
        },
        update_focused_file = {
          enable = true,
          debounce_delay = 15,
          update_root = false,
          ignore_list = {},
        },
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          show_on_open_dirs = true,
          debounce_delay = 50,
          severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
          },
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        filters = {
          dotfiles = false,
          git_clean = false,
          no_buffer = false,
          custom = { "node_modules", "\\.cache" },
          exclude = {},
        },
        filesystem_watchers = {
          enable = true,
          debounce_delay = 50,
          ignore_dirs = {},
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
          timeout = 200,
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          expand_all = {
            max_folder_discovery = 300,
            exclude = {},
          },
          file_popup = {
            open_win_config = {
              col = 1,
              row = 1,
              relative = "cursor",
              border = "shadow",
              style = "minimal",
            },
          },
          open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
              enable = true,
              picker = "default",
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
          remove_file = {
            close_window = true,
          },
        },
        trash = {
          cmd = "trash",
          require_confirm = true,
        },
        live_filter = {
          prefix = "[FILTER]: ",
          always_show_folders = true,
        },
        tab = {
          sync = {
            open = false,
            close = false,
            ignore = {},
          },
        },
      })
    end,
  }
}
