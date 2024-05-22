--- ROCKS SETUP

local rocks_config = {
  rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
  luarocks_binary = vim.env.HOME .. "/.local/share/nvim/rocks/bin/luarocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
  vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
  vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
  -- Remove the dylib and dll paths if you do not need macos or windows support
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))

--- MY OWN SETUP

-- Use space as leader
vim.g.mapleader = ' '
vim.cmd('colorscheme tokyonight')
vim.cmd([[
  set relativenumber
  set number

  "window mappings
  noremap <leader>w <c-w>
  noremap <a-h> <c-w>h
  noremap <a-j> <c-w>j
  noremap <a-k> <c-w>k
  noremap <a-l> <c-w>l
  tnoremap <a-h> <c-\><c-n><c-w>h
  tnoremap <a-j> <c-\><c-n><c-w>j
  tnoremap <a-k> <c-\><c-n><c-w>k
  tnoremap <a-l> <c-\><c-n><c-w>l

  " save file
  nmap <silent> <leader>s :w<cr>

  noremap <silent> <leader>kr :source $MYVIMRC<cr>
]])
