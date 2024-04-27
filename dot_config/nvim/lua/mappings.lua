-- map helper
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent= true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end



-- Global
-- ====================================

-- Tabs / Buffers
map('', '<leader>tn', '<cmd>tabnew<CR>')  -- new tab
map('', '<leader>q', '<cmd>qa<CR>')  -- new tab
map('', '<leader>bd', '<cmd>bd<CR>')  -- close buffer
map('n', '<right>', ':bn<CR>') -- buffer
map('n', '<left>', ':bp<CR>') -- buffer
map('i', '<s-right>', '<cmd>bn<CR>') -- buffer
map('i', '<s-left>', '<cmd>bp<CR>') -- buffer


-- Normal mode
-- ====================================
map('n', '<Space>', ':') -- space to command mode
map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
map('n', 'S', '<cmd>w<CR>') -- save file

map('n', '<leader>s', ':vsp<CR>')  -- new tab

-- Insert mode
-- ====================================
map('i', 'jk', '<Esc>')     -- jk to escape
map('i', '<C-c>', '<Esc>')  -- control c in insert mode to escape
map('i', '<C-h>', '<C-o>h') 
map('i', '<C-j>', '<C-o>j') 
map('i', '<C-k>', '<C-o>k') 
map('i', '<C-l>', '<C-o>l') 

-- Visual mode
-- ====================================
map('v', '<C-h>', '<ESC>v<<ESC>')
map('v', '<C-l>', '<ESC>v><ESC>')
map('v', '<', '<gv')
map('v', '>', '>gv')

local tree ={}
open = function ()
   require'bufferline.state'.set_offset(31, 'FileTree')
   require'nvim-tree'.find_file(true)
end

close = function ()
   require'bufferline.state'.set_offset(0)
   require'nvim-tree'.close()
end

-- Plugin: Oil
-- ====================================
map('n', '<F1>', ":Oil<CR>")

-- Plugin: symbolsoutline
-- ====================================
map('n', '<F2>', ":Outline<CR>")

-- Plugin: NvimTree
-- ====================================
map('', '<F4>', '<cmd>NvimTreeToggle<CR>')

-- Plugin: hopword (vim motion)
-- ====================================
map('n', '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>")

-- Plugin: whichkey
-- ====================================

-- Plugin: vim commentary
-- ====================================
	-- gcc, gcu, gcap
map('i', '<C-_>', "<cmd>Commentary<CR>")
map('n', '<C-_>', "<cmd>Commentary<CR>")
map('v', '<C-_>', "<cmd>CommentaryLine<CR>")

-- Plugin: tabularize
-- ====================================
map('v', '<Space>', ":Tabularize /")

-- Plugin: fzf, fzflua
-- ====================================
map('n', '<leader>x', "<cmd>lua require('fzf-lua').files()<CR>")
map('n', '<leader>X', ":FzfLua<CR>")
map('n', '<leader>B', "<CMD>FzfLua buffers<CR>")
map('n', '<leader>g', "<cmd>lua require('fzf-lua').live_grep()<CR>")


-- Plugin: LSP, trouble, coq
-- ====================================
-- See `:help vim.lsp.*` for documentation on any of the below functions
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

map('n', 'T', '<cmd>TroubleToggle<CR>', opts)


-- Plugin: nvim-window
-- ====================================
map('n', '<leader><space>', "<cmd>lua require('nvim-window').pick()<CR>", opts)

-- Plugin: undotree
-- ====================================
map('n', '<F3>', "<cmd>UndotreeToggle<CR>", opts)

-- Plugin: splitjoint
-- ====================================
map('n', '<leader>Sj', "<cmd>SplitjoinJoin<CR>", opts)
map('n', '<leader>Ss', "<cmd>SplitjoinSplit<CR>", opts)

