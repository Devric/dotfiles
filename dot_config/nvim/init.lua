-- use ; as a the leader key
vim.g.mapleader = ';'

require('plugins')          -- packer
-- require('plugins-dap')      -- packer - dap
require('plugins-whichkey') -- packer -  which key
require('settings')
require('lsp')
require('mappings')

