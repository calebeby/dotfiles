function c
  cd ~/Curriculum
  nvim +"lua vim.schedule(function ()
    local started = false
    require('snacks').terminal.open(null, {
      win = {
        on_buf = function(buf)
            if started then return end
            started = true
            vim.api.nvim_feedkeys('bilbo serve\n', 'n', false)
        end
      }
    })
  end)"
end
