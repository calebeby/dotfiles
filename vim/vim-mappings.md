# Leader Mappings (space)

- <leader>g : git
  - <leader>gs : git status
  - <leader>gp : git push
  - <leader>gP : git push -u origin HEAD
  - <leader>gl : git pull

- <leader>l : sideways right
- <leader>h : sideways left

- <leader>s : save

- <leader>k : editor (like vscode c-k)
  - <leader>kr : reload ~/.vimrc
  - <leader>kt : select theme

- <leader>w : window (all mappings from ctrl-w)
- <leader>q<leader>q : close all windows

- <leader>; : : (command mode, to reduce pinkie shift)

- <leader>o : open (fzf)

- <leader>t : test
  - <leader>tn : Run nearest test
  - <leader>tf : Run current test file
  - <leader>ts : Run current test suite
  - <leader>tl : Run previously-ran tests
  - <leader>tg : Go to previously-ran test file

- <leader><leader> : visual multi prefix

# Non-leader mappings

- ,: easymotion prefix (use motion after it)
- ,, easymotion search for two characters everywhere
- gj : COC next error
- gk : COC prev error
- ) next hunk
- ( prev hunk
- ]v go to next word segment
- [v go to prev word segment
