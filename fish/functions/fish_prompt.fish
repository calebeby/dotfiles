set __fish_git_prompt_color 555

set __fish_git_prompt_char_prefix ''

set __fish_git_prompt_char_stateseparator ''

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_untrackedfiles '*'

set __fish_git_prompt_char_upstream_prefix ' '

set __fish_git_prompt_color_upstream cyan
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_char_upstream_equal ''
set __fish_git_prompt_char_upstream_ahead '⇡'
set __fish_git_prompt_char_upstream_behind '⇣'
set __fish_git_prompt_char_upstream_diverged '⇡⇣'

set __fish_git_prompt_char_stagedstate '+'
set __fish_git_prompt_char_stashstate ''

# Don't shorten path
set -x fish_prompt_pwd_dir_length 0

function fish_prompt
  set exitstatus $status

  set -l dir (prompt_pwd)

  if test $exitstatus -eq 0
    set char (set_color magenta)(echo ❯)(set_color normal)
  else
    set char (set_color red)(echo ❯)(set_color normal)
  end

  set -l pwd (set_color blue)(echo $dir)(set_color normal)

  set -l git (__fish_git_prompt "%s")

  echo -e "\n$pwd $git\n$char "
end
