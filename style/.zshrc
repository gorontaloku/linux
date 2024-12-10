# If you come from bash you might have to change >
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/loc>

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "ra>
# load a random theme each time Oh My Zsh is load>
# to know which specific one was loaded, run: ech>
# See https://github.com/ohmyzsh/ohmyzsh/wiki/The>
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at>
# Setting this variable when ZSH_THEME=random wil>
# a theme from this variable instead of looking i>
# If set to an empty array, this variable will ha>
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "a>

# Uncomment the following line to use case-sensit>
# CASE_SENSITIVE="true"

#Uncomment the following line to use case-sensit>
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-inse>
# Case-sensitive completion must be off. _ and - >
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change >
# zstyle ':omz:update' mode disabled  # disable a>
# zstyle ':omz:update' mode auto      # update au>
# zstyle ':omz:update' mode reminder  # just remi>

# Uncomment the following line to change how ofte>
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs an>
# DISABLE_MAGIC_FUNCTIONS="true"

#Uncomment the following line to disable colors >
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-se>
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command >
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dot>
# You can also set it to another string to have t>
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting>
# Caution: this setting can cause issues with mul>
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to dis>
# under VCS as dirty. This makes repository statu>
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

#Uncomment the following line if you want to cha>
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime funct>
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder tha>
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plug>
# Example format: plugins=(rails git textmate rub>
# Add wisely, as too many plugins slow down shell>
plugins=(git)

source $ZSH/oh-my-zsh.sh

#User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language envi>
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

#Set personal aliases, overriding those provided>
# plugins, and themes. Aliases can be placed here>
# users are encouraged to define aliases within a>
# the $ZSH_CUSTOM folder, with .zsh extension. Ex>
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="lsd"