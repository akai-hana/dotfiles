fastfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

. /home/eudaimon/git/zsh-defer/zsh-defer.plugin.zsh
. /usr/share/zsh/site-functions/async.zsh
. /usr/share/zsh/site-functions/powerlevel10k/powerlevel10k.zsh-theme

. /usr/share/zsh/site-contrib/fast-syntax-highlighting/F-Sy-H.plugin.zsh
. /usr/share/zsh/site-functions/zsh-history-substring-search.zsh
. /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
. /usr/share/zsh/site-contrib/oh-my-zsh/templates/zshrc.zsh-template

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH=/usr/share/zsh/site-contrib/oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# $ZSH/themes/random.zsh-theme &>/dev/null

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
export ZSH_CUSTOM=~/.zsh-custom-plugins

export ZSH=/usr/share/zsh/site-contrib/oh-my-zsh
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-auto-fetch git-extras git-prompt gitfast fancy-ctrl-z zsh-navigation-tools vi-mode kitty)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='emacs'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

HISTFILE=~/.histfile
HISTSIZE=10000000000
SAVEHIST=10000000000
setopt appendhistory

# System & X11 Management
alias stx="DRI_PRIME=1 startx"

# Package Management (Portage)
alias get="doas emerge"
alias unget="doas emerge --unmerge"
alias emerge="doas emerge"

# Repository Management
alias get-sel="doas eselect"
alias get-add="doas eselect repository enable"
alias get-rmv="doas eselect repository disable"
alias get-sync="doas emerge --sync"
alias get-world="doas emerge -uDNq @world"
alias zawarudo="doas emerge --sync && doas emerge -uDNq @world && doas emerge --clean && doas emerge --depclean"

# Kernel Management
alias get-kernel="cd /usr/src/linux && doas make nconfig"
alias get-kernel-list="doas eselect kernel list"
alias get-kernel-set="doas eselect kernel set"

# File & Permission Management
alias chmod="doas chmod"
alias chown="doas chown"
alias mine="doas chown $USER"
alias craft="doas chmod 777"
alias mv="doas mv"
alias ln="doas ln"
alias rm="doas rm -rf"
alias cp="doas cp -r"
alias back=". ~/scripts/back.sh"

# Compilation & System Utilities
alias make="doas make"
alias etcupd="doas etc-update"
alias eselect="doas eselect"
alias esel="doas eselect"
alias eselker="doas eselect kernel"
alias dhcpcd="doas dhcpcd"
alias mount="doas mount"
alias umount="doas umount"

# Configuration Files Editing
alias makeconf="emacs /etc/portage/make.conf"
alias zshrc="emacs ~/.zshrc"
alias rclua="emacs ~/.config/awesome/rc.lua"
alias correct="emacs /usr/share/zsh/site-contrib/oh-my-zsh/lib/correction.zsh"

# Services Management
alias rcser="doas rc-service"
alias rcupd="doas rc-update"

# Custom Scripts
alias edit="~/scripts/emacs.sh"
alias emacs="~/scripts/emacs.sh"
alias zathura="~/scripts/zathura.sh 2>/dev/null"
alias za="~/scripts/zathura.sh 2>/dev/null"

alias pdf="~/scripts/zathura.sh ~/pdfs/"
alias repo-enable="~/scripts/repo-enable.sh"
alias milkfetch="/home/eudaimon/scripts/milkfetch.sh"

# System Info & Miscellaneous
alias fetch="fastfetch"
alias weather="curl wttr.in/Barcelona"
alias brightnessctl="bn"
alias qq="exit"

# Fun & Miscellaneous
alias repo="repository"
alias todo="todo.sh"
alias add="todo.sh add"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="/home/eudaimon/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
unsetopt correctall
