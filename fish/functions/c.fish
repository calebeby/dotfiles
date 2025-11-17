function c
  cd ~/Curriculum
  nvim +"lua vim.schedule(function () require('snacks').terminal.open('fish -C \"bilbo serve\"', {win = {position = 'bottom'}}) end)"
end
