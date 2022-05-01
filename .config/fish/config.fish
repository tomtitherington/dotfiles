set fish_greeting "Howdy."

set -gx TERM xterm-256color
set -gx PATH $PATH $HOME/.pub-cache/bin

set -g theme_color_scheme gruvbox
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

set -gx EDITOR nvim
set -gx DJANGO_DEVELOPMENT true

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

if status is-interactive
    # Commands to run in interactive sessions can go here
    if type -q exa
  	alias ll "exa -l -g --icons"
	alias lla "ll -a"
	alias lt "exa --tree --long --icons"
    end
end
