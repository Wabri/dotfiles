require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup {
    ensure_installed = {
        "gopls",
        "solargraph",
        "bashls",
        "terraformls"
    },
}

-- Mapping
require("which-key").register({
    p = {
        name = "Packer",
        m = { "Mason" },
    },
}, { prefix = "<leader>" })
vim.keymap.set("n", "<leader>pm", vim.cmd.Mason)
--
