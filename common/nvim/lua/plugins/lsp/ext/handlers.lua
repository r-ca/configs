-- https://github.com/magidc/nvim-config/blob/master/lua/lsp/handlers.lua

local M = {}
local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local signature_cfg = {
    bind = true,   -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default

    floating_window = true,  -- show hint in a floating window, set to false for virtual text only mode
    hint_enable = false,     -- virtual hint enable
    hint_prefix = "🐼 ",   -- Panda for parameter
    hint_scheme = "String",
    use_lspsaga = false,     -- set to true if you want to use lspsaga popup
    hi_parameter = "Search", -- how your parameter will be highlight
    max_height = 12,         -- max height of signature floating_window, if content is more than max_height, you can scroll down
    -- to view the hiding contents
    max_width = 120,         -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
        border = "single",   -- double, single, shadow, none
    },
    -- deprecate !!
    -- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
}


local function set_signature_helper(client, bufnr)
    local shp = client.server_capabilities.signatureHelpProvider
    if shp == true or (type(shp) == "table" and next(shp) ~= nil) then
        require("lsp_signature").on_attach(signature_cfg, bufnr)
    end
end

local function set_hover_border(client)
    local hp = client.server_capabilities.hoverProvider
    if hp == true or (type(hp) == "table" and next(hp) ~= nil) then
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
    end
end

M.on_attach = function(client, bufnr)
    set_signature_helper(client, bufnr)
    set_hover_border(client)

	-- Keybindings
	vim.keymap.set('n', '<Space>', '<cmd>lua vim.lsp.buf.hover()<CR>', { remap = true, buffer = bufnr })
	vim.keymap.set('n', '<S-d>', '<cmd>lua vim.lsp.buf.definition()<CR>', { remap = true, buffer = bufnr })
	vim.keymap.set('n', 'efm', '<cmd>lua vim.lsp.buf.formatting()<CR>', { remap = true, buffer = bufnr })
	vim.keymap.set('n', 'erf', '<cmd>lua vim.lsp.buf.references()<CR>', { remap = true, buffer = bufnr })
	vim.keymap.set('n', 'ern', '<cmd>lua vim.lsp.buf.rename()<CR>', { remap = true, buffer = bufnr })
	-- vim.keymap.set('n', 'efx', '<cmd>lua vim.lsp.buf.code_action()<CR>', { remap = true, buffer = bufnr })

	-- Rewrite LSP saga
	vim.keymap.set('n', 'efx', '<cmd>Lspsaga code_action<CR>', { remap = true, buffer = bufnr })

	-- rewrite
	-- vim.api.nvim_buf_set_keymap('n', '<Space>', [[<cmd>lua vim.lsp.buf.hover()<CR>]], { noremap = false, silent = true, buffer = bufnr })
	-- vim.api.nvim_buf_set_keymap('n', '<S-Space>', [[<cmd>lua vim.lsp.buf.definition()<CR>]], { noremap = false, silent = true, buffer = bufnr })
	-- vim.api.nvim_buf_set_keymap('n', 'fm', [[<cmd>lua vim.lsp.buf.formatting()<CR>]], { noremap = false, silent = true, buffer = bufnr })
	-- vim.api.nvim_buf_set_keymap('n', 'rf', [[<cmd>lua vim.lsp.buf.references()<CR>]], { noremap = false, silent = true, buffer = bufnr })
	-- vim.api.nvim_buf_set_keymap('n', 'rn', [[<cmd>lua vim.lsp.buf.rename()<CR>]], { noremap = false, silent = true, buffer = bufnr })
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- M.capabilities = require('coq').lsp_ensure_capabilities()
return M
