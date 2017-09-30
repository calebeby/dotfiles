# https://gist.github.com/psychoticmeow/d5d432aab719cc073ae9
set caller %self
set pipe /tmp/fish_prompt_{$caller}

# Don't shorten path
set -x fish_prompt_pwd_dir_length 0

# Make sure our pipe exists:
if not test -e $pipe
	touch $pipe
	chmod 600 $pipe
end

# Wait for a new fish prompt (but not a refreshed prompt)
function update_fish_prompt --on-event fish_prompt
	if not set -q _fish_prompt_update_{$caller}_running
		set -x _fish_prompt_update_{$caller}_running

		# Clear the previous prompt:
		printf "\n" > $pipe

		# Start the async process:
		~/.config/fish/functions/fish_prompt_async.fish $caller &
	end
end

function fish_prompt
  set exitstatus $status

	set -l dir (prompt_pwd)

	# Make sure we initialise the prompt the first time:
	if not set -q _fish_prompt_update_{$caller}_init
		set -g _fish_prompt_update_{$caller}_init
		update_fish_prompt
	end

	# Get the prompt update:
	if tail -1 $pipe | read -l line
		set update $line
	end

  if test $exitstatus -eq 0
    set char (set_color magenta)(echo ❯)(set_color normal)
  else
    set char (set_color red)(echo ❯)(set_color normal)
  end

	printf "\n%s%s\n$char " \
		(set_color blue)(echo $dir)(set_color normal) \
		(echo $update)
end
