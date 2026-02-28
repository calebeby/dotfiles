function s
  cd ~/Documents/Student\ Work
  nvim +"lua vim.schedule(function ()
    local started = false
    require('snacks').terminal.open(null, {
      win = {
        on_buf = function(buf)
            if started then return end
            vim.defer_fn(function ()
              started = true
              vim.api.nvim_feedkeys('rubrix\n', 'n', false)
            end, 200)
        end
      }
    })
  end)"
end
