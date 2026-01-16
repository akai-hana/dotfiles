# akai's fish config! :>

fish_vi_key_bindings

set -gx PATH $PATH $HOME/.cargo/bin
set -gx PATH $PATH $HOME/.local/bin

### MY HORRENDOUS LIST OF ABBREVIATIONS ###  

# system

## package management (chimera/alpine)
abbr get   "doas apk add"
abbr seget "doas apk search"
abbr unget "doas apk del"
abbr upd   "doas apk update; doas apk upgrade --prune"

### TODO: make some functions to make them distro-aware and agnostic

## calls
alias sudo    "doas"
abbr reboot   "doas reboot"
abbr poweroff "doas poweroff"
abbr quitw    "doas poweroff"

# file operations

## shortcuts
abbr sx "startx"
abbr d  "cd"
abbr q  "exit"
abbr ff "fastfetch"
abbr us "setxkbmap -layout us -option caps:swapescape -option altwin:swap_lalt_lwin"
abbr es "setxkbmap -layout es -option caps:swapescape -option altwin:swap_lalt_lwin"

## overrides
abbr mkdir "mkdir -p"
abbr mv    "doas mv"
abbr cp    "doas cp -r"
abbr rm    "doas rm"
abbr rmr   "doas rm -r"
abbr ln    "doas ln -s"
abbr make  "doas make"
abbr bmake "doas bmake"
abbr gmake "doas gmake"
abbr grep  "grep -i"
abbr btop  "btop --force-utf"

## utilities
abbr own       "doas chown -R $USER:$USER"
abbr suckstall "doas bmake clean install" # sorry but i love the name

### TO-DO: make "bak" abbr that takes a file as an argument and moves it to itself + .bak on its name, and if it already has a ".bak", it "unbaks" it; dont do it as a script, write it out as a function in here, i think it'll be better that way

## ls/eza
set -g EZA_FULL   "eza --color=always --icons=always --classify=always"
set -g EZA_SIMPLE "$EZA_FULL --no-permissions --no-user --no-time --no-filesize"

alias e  "$EZA_SIMPLE"
alias fe "$EZA_FULL"

alias ls  "$EZA_SIMPLE"
alias fls "$EZA_FULL"

alias l   "$EZA_SIMPLE -l"
alias fl  "$EZA_FULL -l"
alias a   "$EZA_SIMPLE -a"
alias fa  "$EZA_FULL -a"
alias la  "$EZA_SIMPLE -la"
alias fla "$EZA_FULL -la"

abbr symlinks "grep -i '\->'" # little hack: pipe eza into this to filter by symlinks
                              # (theres probably a better way to do this but whatever)

# git
abbr ga   "git add"
abbr ga.  "git add ."
abbr gc   "git commit"
abbr gcm  "git commit -m"
abbr gcam "git commit --amend -m"
abbr gp   "git push"
abbr gl   "git pull"

# Zig
abbr zb  "zig build"
abbr zbd "zig build -Doptimize=Debug"
abbr zbr "zig build run"

# Vim
abbr v "vim"

# config shortcuts
## x11
abbr xinitrc    "vim ~/.xinitrc"
abbr xprofile   "vim ~/.xprofile"
abbr xresources "vim ~/.xresources"

## tools
abbr vimrc      "vim ~/.vimrc"
abbr fishconf   "vim ~/.config/fish/config.fish"
abbr dwmconf    "vim ~/eudaimonia/suckless/dwm-6.4/config.h"
abbr ghosconf   "vim ~/.config/ghostty/config"

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"

# opencode
fish_add_path /home/akai/.opencode/bin
