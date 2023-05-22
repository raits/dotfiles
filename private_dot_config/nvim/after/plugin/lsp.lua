local lsp = require("lsp-zero").preset({})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#configurations
lsp.ensure_installed({
  'tsserver',
  'vuels',
  'jdtls'
})


lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>db", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>ac", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})
