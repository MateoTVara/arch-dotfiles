return {
{
  "mason-org/mason.nvim",
  opts = {},
},

{
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "pyright",
      "ts_ls",
      "tailwindcss",
      "rust_analyzer",
      "lua_ls",
      "intelephense",
      "html",
      "cssls",
      "qmlls",
      "clangd",
    },
  },
},

{
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  config = function()
    -- enable servers
    vim.lsp.enable("pyright")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("rust_analyzer")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("intelephense")
    vim.lsp.enable("html")
    vim.lsp.enable("cssls")
    vim.lsp.enable("qmlls")
    vim.lsp.enable("clangd")
    vim.lsp.enable("nixd")

    -- keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            -- Diagnostic navigation
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
      end,
    })
  end,
},
}
