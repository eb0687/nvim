--             _                 _
--  _ ____   _(_)_ __ ___       | |_ _ __ ___  ___
-- | '_ \ \ / / | '_ ` _ \ _____| __| '__/ _ \/ _ \
-- | | | \ V /| | | | | | |_____| |_| | |  __/  __/
-- |_| |_|\_/ |_|_| |_| |_|      \__|_|  \___|\___|

-- protective call so nothing breaks if nvim-tree is missing
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- setup
nvim_tree.setup({

    disable_netrw = true,
    create_in_closed_folder = true,

    view = {
        adaptive_size = false,
        centralize_selection = true,
        width = 40,
        height = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = true,
        relativenumber = true,
        signcolumn = "yes",
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                none = " ",
            },
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                git = true,
            },
            glyphs = {
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            }
        },
        symlink_destination = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 500,
    },
    filters = {
        dotfiles = true,
    },
    log = {
        enable = true,
        truncate = true,
        types = {
          all = true,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
    },
})
