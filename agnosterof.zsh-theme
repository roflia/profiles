# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segments of the prompt, default order declaration

typeset -aHg AGNOSTER_PROMPT_SEGMENTS=(
    prompt_status
    prompt_context
    prompt_virtualenv
    prompt_dir
    prompt_git
    prompt_end
)

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
    PRIMARY_FG=black
fi

# Characters
SEGMENT_SEPARATOR="\ue0b0"
REVERSE_SEG="\ue0b2"
KET="\ue0b1"
BRA="\ue0b3"

BRANCH="\ue0a0"
DETACHED="\u27a6"
PLUS="\u002b"
CHECK="\u2713"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"
# Emojis
DELTA="∆"
SUN="\U1F31E"
MOON="🌙"
FOLDER="📂"
FIRE="🔥"
H100="💯"
JOY="😂"
ALIEN="👽"
OK="👌"
PLEWDS="💦"

darkgrey="\e[100m"
lightgrey="\e[47m"
lightblue="\e[104m"
# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.


#TODO
prompt_csegment() {
  local bg fg mod 
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $4 ]] && print -n $4
}

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  #prompt_segment black red " $PLUS "
  prompt_sap_e
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    #print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR$KET"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: time 
prompt_context() {
  local user=`whoami`
  local now=$( date +"%T" | cut -c 1-2 )
  if [[ $RETVAL -ne 0 ]]; then
    local emoji=$FIRE 
  else
    if [[ $now -gt 6 && $now -lt 18 ]]; then
      local emoji=$SUN
    else
      local emoji=$MOON
    fi
  fi
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    #nextline example
    #prompt_segment magenta black "$KET $emoji\[%T\] %{%F{black}%}$KET %{%K{black}%}%{%F{magenta}%}$SEGMENT_SEPARATOR\n"
    prompt_segment cyan black "$KET $emoji\[%T\] %{%F{black}%}\u2016 "
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=yellow
      ref="${ref} $DELTA "
    else
      color=white
      ref="${ref} $CHECK "
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRANCH $ref "
    else
      ref="$DETACHED ${ref/.../}"
    fi
    prompt_segment $color $PRIMARY_FG
    print -n " $ref"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment cyan black "%{%F{white}%}$FOLDER%{%F{black}%}%~/ %{%F{black}%}$KET"
}

# Colored segment according to status
prompt_sap() {
  local ref="$vcs_info_msg_0_"
  local mystr=""
  if [[ $RETVAL -ne 0 ]]; then
    prompt_segment red $PRIMARY_FG $mystr 
  elif [[ -n "$ref" ]]; then
    prompt_segment green $PRIMARY_FG $mystr 
  else
    prompt_segment yellow $PRIMARY_FG $mystr 
  fi
}
prompt_sap_e() {
  local ref="$vcs_info_msg_0_"
  local mystr=" "
  if [[ $RETVAL -ne 0 ]]; then
    prompt_segment red $PRIMARY_FG $mystr 
  elif [[ -n "$ref" ]]; then
    prompt_segment green $PRIMARY_FG $mystr
  else
    prompt_segment yellow $PRIMARY_FG $mystr
  fi
}

# Status:
# - was there an error
# - are there background jobs?
prompt_status() {
  prompt_sap
  local symbols
  symbols=()
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    symbols="%{%F{green}%}$CHECK"
  else
    symbols="%{%F{green}%}$PLUS"
  fi
  if [[ $RETVAL -ne 0 ]]; then
    symbols="%{%F{red}%}$CROSS"
  fi
  #[[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$CROSS"
  #[[ $(jobs -l | wc -l) -eq 0 ]] && symbols+="%{%F{cyan}%}$GEAR"

  [[ -n "$symbols" ]] && prompt_segment $PRIMARY_FG default " $symbols "
}

# Display current virtual environment
prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV ]]; then
    color=cyan
    prompt_segment $color $PRIMARY_FG
    print -Pn " $(basename $VIRTUAL_ENV) "
  fi
}

## Main prompt
prompt_agnoster_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  for prompt_segment in "${AGNOSTER_PROMPT_SEGMENTS[@]}"; do
    [[ -n $prompt_segment ]] && $prompt_segment
  done
}

prompt_agnoster_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_agnoster_main) '
}

prompt_agnoster_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_agnoster_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_agnoster_setup "$@"
