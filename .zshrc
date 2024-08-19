# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

#History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Basic auto/tab complete:
zstyle :compinstall filename '/home/falcon/.zshrc'
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	# Include hidden files

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
precmd() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# aliases
alias ll='ls -lA'
alias pac='sudo pacman -S'
alias autoremove='sudo pacman -R $(pacman -Qdtq)'
alias x='startx'
alias btw='neofetch'
alias pacr='sudo pacman -R'
alias ryujinx='/home/helel/scripts/ryujinx/Ryujinx'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias update-all='sudo pacman -Syyu && flatpak update && yay -Syu'
alias lsaudio='pactl list sinks | grep -B 10 -A 2 "State: RUNNING"'
alias ani-cli='/home/falcon/scripts/ani-cli/ani-cli'
alias svpn='sudo openvpn /home/falcon/vpn/singapore-pc.ovpn'
alias ani-cli='/home/falcon/scripts/ani-cli/ani-cli'
alias rpdf='atril'
alias vim='nvim'
alias r='ranger'
alias yuzu='__GL_THREADED_OPTIMIZATIONS=1 /home/helel/scripts/yuzu-ea/yuzu.AppImage'
alias process_videos='/home/helel/scripts/process_videos.sh'
alias rpcs3='/home/helel/scripts/rpcs3/rpcs3.AppImage'
alias py='python'

# PATH variables
export PATH="$PATH:$HOME/.local/bin"

#Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
