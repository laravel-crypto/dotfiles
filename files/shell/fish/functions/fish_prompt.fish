function fish_prompt --description 'Write out the prompt'
    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l magenta (set_color magenta)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l normal (set_color normal)

    # set -g __fish_git_prompt_show_informative_status "yes"
    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_showdirtystate "yes"
    set -g __fish_git_prompt_showstashstate "yes"
    set -g __fish_git_prompt_showuntrackedfiles "yes"
    set -g __fish_git_prompt_char_upstream_ahead "↑·"
    set -g __fish_git_prompt_char_upstream_behind "↓·"
    set -g __fish_git_prompt_char_upstream_prefix " "
    set -g __fish_git_prompt_char_stagedstate "●"
    set -g __fish_git_prompt_char_dirtystate "✚ "
    set -g __fish_git_prompt_char_stateseparator " "
    set -g __fish_git_prompt_char_untrackedfiles "…"
    set -g __fish_git_prompt_char_stashstate "⚑ "
    set -g __fish_git_prompt_char_invalidstate "✖ "
    set -g __fish_git_prompt_char_cleanstate "✔"
    set -g __fish_git_prompt_color_branch blue
    set -g __fish_git_prompt_color_cleanstate green
    set -g __fish_git_prompt_color_dirtystate blue
    set -g __fish_git_prompt_color_stagedstate yellow
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_branch_detached red
    set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    set -g __fish_git_prompt_describe_style "describe"
    set -g __fish_git_prompt_showcolorhints "yes"

    set -l last_status $status

    set -g __fish_prompt_normal (set_color normal)

    set -l color_cwd
    set -l suffix

    switch $USER
        case root toor
            set color_cwd $red
            set suffix '#'
        case '*'
            set color_cwd $magenta
            set suffix '$'
    end

    # If connected via SSH should the suffix twice
    if [ "$SSH_TTY" -o "$SSH_CLIENT" ]
        set suffix "$suffix$suffix"
    end

    set -l cwd $color_cwd (pwd | sed "s:^$HOME:~:")

    set -l hostname (hostname | sed "s:.lan::" | sed "s:.local::")

    set -l whowhere $green (whoami) $normal ' at ' $green $hostname $normal ' in '

    # Add a newline before new prompts
    echo -e ''

    # Show username and host
    echo -n -s $whowhere

    # Print path
    echo -n -s $cwd $normal

    # Print VCS status
    echo -n -s (__fish_git_prompt ' on %s')

    echo -e ''
    echo -e -n -s $normal "$suffix " $normal
end
