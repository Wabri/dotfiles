return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function ()
      -- [[ NeoTree ]]
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        sort_case_insensitive = false,
        sort_function = nil,
        commands = {},
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = false,
            hide_by_pattern = {
              "*.vagrant",
              "*.git",
            },
            always_show = {
              ".gitignore",
            },
          },
        },
        buffers = {
          follow_current_file = true, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
        },
      })

      vim.keymap.set("n", "<leader>e", ":NeoTreeFloat<cr>", { desc = 'Open the floating [E]xplorer'})
    end
  }
}
