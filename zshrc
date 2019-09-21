# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/j4im/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnosterof"
autoload -U colors && colors

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#===============================================================
# CUSTUM ZSH STUFF STARTS HERE
#===============================================================
#
# WINDOWS TERMINAL 
#---------------------------------------------------------------
# Directory shortcuts
export documents='/mnt/c/Users/j4im/Documents'
export wallpapers='/mnt/c/Users/j4im/Pictures/wallpapers'
alias bgswap='python ~/bgSwap/run.py'
alias wp='(&>/dev/null bgswap -f -l $wallpapers -t 60 -s &)'
# Automatically start swapping screens
(&>/dev/null bgswap -l $wallpapers/l -t 10 -s &)

# Windows terminal option shortcuts
export term_profile='/mnt/c/Users/j4im/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/profiles.json'
alias setting='vi $term_profile'

# Function to create Windows-friendly path
function FNC_PWDPS()
{
    echo $PWD | sed -e 's@/mnt/c@c:@g' -e 's@/mnt/d@d:@g' -e 's@/mnt/e@e:@g' -e 's@/@\/@g'
}
alias pwdps='echo $(FNC_PWDPS)'
# Custom function to suppress WSL's symbolic link bug
# and hide NTUSER files in windows home
function ls() {
    ls_opts="-h --color=auto"
    if [ $# ]; then
        if [ "$PWD" = "/mnt/c/Users/j4im" ]; then
            ls_opts="$ls_opts --hide='ntuser.*' --hide='NTUSER.*'"
        fi
        eval command ls "$ls_opts" '"$@"' 2>/dev/null
        return 0
    fi
    eval command ls "$ls_opts" '"$@"'
}

#
# LINUX GENERIC 
#---------------------------------------------------------------
# rc file shortcuts
# download my profiles: "git clone https://github.com/roflia/profiles.git"
export profiles=$HOME'/profiles'
if [ "$profiles"  ]; then
    alias bashrc='vi $profiles/bashrc'
    alias zshrc='vi $profiles/zshrc'
    alias vimrc='vi $profiles/vimrc'
    alias zsource='$profiles/install.sh;source ~/.zshrc'
else
    alias bashrc='vi ~/.bashrc'
    alias zshrc= 'vi ~/.zshrc'
    alias vimrc= 'vi ~/.vimrc'
    alias zsource='source ~/.zshrc'
fi
# zsh theme file
alias theme='vi $profiles/agnosterof.zsh-theme'

# python
alias python='python3.7'
alias pip='pip3'

#
# SCHOOL STUFF
#---------------------------------------------------------------
# note: documens='/mnt/c/Users/j4im/Documents'
export phys475=$documents'/PHYS475'
export phys474=$documents'/PHYS474'
export phys434=$documents'/PHYS434'
export phys380=$documents'/PHYS380'
export phys275=$documents'/PHYS275'



