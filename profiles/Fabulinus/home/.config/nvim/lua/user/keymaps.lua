-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- NO FUN
vim.keymap.set("n", "Q", "<nop>", { expr = true, silent = true })

-- Move from open windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Save & Exit
vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = '[W]rite' })
vim.keymap.set("n", "<leader>q", vim.cmd.q, { desc = '[Q]uit' })

-- Undo in the right way
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")

-- Dont loose focus 
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- [[ Source ]]
vim.keymap.set("n", "<leader>st", vim.cmd.so, { desc = '[S]ource [T]his file'})
vim.keymap.set("n", "<leader>ss", ":source $MYVIMRC<CR>", { desc = '[S]ource all configuration'})

-- [[ File ]]
vim.keymap.set("n", "<leader>r", ":e!<CR>", { desc = '[R]eload this file' })
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = 'Open the [E]xplorer' })

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<c-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<c-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==", { desc = 'Move up the line' })
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==", { desc = 'Move down the line' })

-- [[ Buffers ]]
vim.keymap.set("n", "<leader>bn", vim.cmd.bn, { desc = '[B]uffer [N]ext' })
vim.keymap.set("n", "<leader>bp", vim.cmd.bp, { desc = '[B]uffer [P]revious' })
vim.keymap.set("n", "<leader>bb", ":b#<CR>", { desc = '[B]uffer [B]ack-and-forth' })
vim.keymap.set("n", "<leader>bd", ":bd %<CR>", { desc = '[B]uffer [D]elete open' })

-- [[ Yank ]]
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- Yanking and Pasting to clipboard
vim.keymap.set("n", "<leader>p", "\"+p", { desc = '[P]aste from clipboard' })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = '[Y]ank all selected' })
vim.keymap.set("n", "<leader>yy", "\"+Y", { desc = '[Y]ank all the line' })
vim.keymap.set("n", "<leader>ys", "\"+y", { desc = '[Y]ank and [S]elect' })
vim.keymap.set("n", "<leader>yA", "ggVG\"+Y<C-o>", { desc = '[Y]ank [A]ll the file' })

-- [[ Fugitive ]]
vim.keymap.set("n", "<leader>gg", ":Git<CR>:only<CR>", { desc = '[G]it dashboard'})
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = '[G]it [C]ommit'})
vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = '[G]it [L]og'})
vim.keymap.set("n", "<leader>gd", ":Git diff<CR>", { desc = '[G]it [D]iff'})

-- [[ Harpoon ]]
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = '[H]arpoon [A]dd'})
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu, { desc = '[H]arpoon list'})
vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end, { desc = '[H]arpooned file [1]'})
vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end, { desc = '[H]arpooned file [2]'})
vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end, { desc = '[H]arpooned file [3]'})
vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end, { desc = '[H]arpooned file [4]'})

-- [[ Mason ]]
vim.keymap.set("n", "<leader>pm", vim.cmd.Mason, { desc = '[P]ackage manager lsp with [M]ason'})

-- [[ Lazy ]]
vim.keymap.set("n", "<leader>pl", vim.cmd.Lazy, { desc = '[P]ackage manager [L]azy'})

-- [ Undotree ]]
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = '[U]ndotree'})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'go', 'lua', 'help', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = {} },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = "Open floating [D]iagnostic [M]essage" })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Open [D]iagnostics [L]ist" })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
-- local on_attach = function(_, bufnr)
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
-- 
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
-- 
--   nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--   nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
-- 
--   nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--   nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--   nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--   nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--   nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--   nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
-- 
--   -- See `:help K` for why this keymap
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
-- 
--   -- Lesser used LSP functionality
--   nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--   nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--   nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--   nmap('<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[W]orkspace [L]ist Folders')
-- 
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, { desc = 'Format current buffer with LSP' })
-- end
-- 
