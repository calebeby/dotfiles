#!/usr/bin/env fish
set caller $argv[1]
set pipe /tmp/fish_prompt_{$caller}

function append --description 'Append text to the end of the prompt.'
	echo -n "$argv" >> $pipe
	kill -WINCH $caller
end

# Append git information:
set branch (git symbolic-ref --short HEAD ^/dev/null)

if test -n "$branch"

  if test (git status --porcelain | wc -c) -ne 0
    set dirty "*"
  end

	# Show the git branch:
	append (printf " %s" \
		(set_color 555555)(echo "$branch$dirty")(set_color normal))


  set pushpull (command git rev-list --left-right --count HEAD...@'{u}')

  set push (echo $pushpull | string split '	' | head -n1)
  set pull (echo $pushpull | string split '	' | tail -n1)

  if begin test $push -gt 0; or test $push -gt 0; end
    append " "(set_color cyan)
    if test $push -gt 0
      append "⇡"
    end
    if test $pull -gt 0
      append "⇣"
    end
    append (set_color normal)
  end
  # (echo $pushpull | tail -n1)
end

# Allow another update script to run:
set -e _fish_prompt_update_{$caller}_running
