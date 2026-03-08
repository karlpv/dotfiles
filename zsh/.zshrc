# ================================
#  XDG & Core Paths (SET FIRST)
# ================================
export XDG_CONFIG_HOME="$HOME/.config"
export TMUX_CONF="$HOME/.config/tmux/tmux.conf"

# Make sure $PATH is sane early
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export CLASSPATH=".:$HOME/school/SPRING2026/TOL203 - DSA/algs4.jar"
# ================================
#  THEME (macOS) → $THEME
# ================================
# Detect macOS system appearance quickly & reliably
_detect_theme() {
  if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -qi 'Dark'; then
    THEME="dark"
  else
    THEME="light"
  fi
  export THEME
}

# Minimal shell tweaks by theme (improve autosuggest contrast)
_apply_theme_minimal() {
  if [[ "$THEME" == "light" ]]; then
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#8a8f98'
  else
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#5f5f5f'
  fi
}

_apply_prompt_minimal() {
  setopt prompt_subst
  if [[ "$THEME" == "light" ]]; then
    PROMPT='%F{240}%n@%m%f %F{33}%2~%f${vcs_info_msg_0_} %F{34}%#%f '
    RPROMPT='%(?..%F{160}exit:%?%f )%F{243}%*%f'
  else
    PROMPT='%F{#8a8a8a}%n@%m%f %F{#00afff}%2~%f${vcs_info_msg_0_} %F{#00afff}%#%f '
    RPROMPT='%(?..%F{#d70000}exit:%?%f )%F{#8a8a8a}%*%f'
  fi
}

autoload -Uz add-zsh-hook vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' use-prompt-escapes true
zstyle ':vcs_info:git:*' formats ' %F{#ffff00}(%b)%f'
zstyle ':vcs_info:git:*' actionformats ' %F{#ffaf00}(%b|%a)%f'
zstyle ':vcs_info:git:*' check-for-changes false
zstyle ':vcs_info:*' max-exports 2

_prompt_precmd() {
  vcs_info
}
add-zsh-hook precmd _prompt_precmd

# Initialize theme for this shell
_detect_theme
_apply_theme_minimal
_apply_prompt_minimal

# Event-driven refresh (e.g., Raycast runs: pkill -USR1 -x zsh)
TRAPUSR1() { _detect_theme; _apply_theme_minimal; _apply_prompt_minimal; return 0 }

# Manual nudge
alias theme-sync='_detect_theme; _apply_theme_minimal; _apply_prompt_minimal; echo "Theme: $THEME"'

# ================================
#  ZINIT PLUGIN MANAGER
# ================================
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220}…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" \
    && print -P "%F{34}Installation successful.%f%b" || print -P "%F{160} The clone has failed.%f%b"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Annexes (nice QoL)
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

# Core plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# ================================
#  COMPLETION CONFIG
# ================================
# fzf-tab previews (macOS BSD ls uses -G)
zstyle ':fzf-tab:complete:cd:*'           fzf-preview 'ls -G $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*'   fzf-preview 'ls -G $realpath'
zstyle ':fzf-tab:complete:z:*'            fzf-preview 'ls -G $realpath'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

autoload -U compinit && compinit -C

# Keybindings for completion
bindkey '^I' complete-word
bindkey '^[[Z' reverse-menu-complete

# ================================
#  HISTORY
# ================================
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_all_dups hist_save_nodups hist_find_no_dups

# ================================
#  FZF
# ================================
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --ignore-file ~/.fzfignore --exclude node_modules --exclude .git --exclude .cache --exclude .DS_Store'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --ignore-file ~/.fzfignore --exclude node_modules --exclude .git --exclude .cache'
export FZF_DEFAULT_OPTS='--height 30% --layout=reverse --border --info=inline --preview-window=right:60% --preview "bat --style=numbers --color=always --line-range :100 {}"'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :100 {}'"
command -v fzf >/dev/null 2>&1 && eval "$(fzf --zsh)"

# ================================
#  ZOXIDE
# ================================
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# ================================
#  ALIASES
# ================================
alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Launch the macOS app explicitly (don't shadow the CLI `zathura` binary).
zathura_app() { open -a "Zathura" "$@"; }

# algs4 (DSA)
alias jc="javac -cp \"$HOME/school/SPRING2026/TOL203 - DSA/algs4.jar:.\""
alias jr="java -cp \"$HOME/school/SPRING2026/TOL203 - DSA/algs4.jar:.\""

# Files
alias ls='ls -G -a'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# Services & configs
alias zshconfig='nvim ~/.zshrc'
alias ghosttyconfig='nvim ~/.config/ghostty/config'
alias vim='nvim'

# Quick cd helpers
alias school='cd ~/Documents/school'
alias docs='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias desktop='cd ~/Desktop'
alias zi='z -i'
alias zc='z -c'

# ================================
#  FUNCTIONS
# ================================
# Smart directory jump (zoxide + fzf fallback)
zsmart() {
  if [[ $# -eq 0 ]]; then
    z -i
  else
    local dir selected
    dir="$(zoxide query "$@")"
    if [[ -n "$dir" ]]; then
      cd "$dir"
    else
      selected="$(fd --type d --hidden --follow --ignore-file ~/.fzfignore 2>/dev/null | fzf --query "$*" --preview 'ls -G {}')"
      [[ -n "$selected" ]] && cd "$selected"
    fi
  fi
}

# mkdir + cd
mkcd() { mkdir -p "$1" && cd "$1"; }

# Extract archives (simple)
extract() {
  local f="$1"
  [[ -f "$f" ]] || { echo "'$f' is not a valid file"; return 1; }
  case "$f" in
    *.tar.bz2) tar xjf "$f" ;;
    *.tar.gz)  tar xzf "$f" ;;
    *.bz2)     bunzip2 "$f" ;;
    *.rar)     unrar e "$f" ;;
    *.gz)      gunzip "$f" ;;
    *.tar)     tar xf "$f" ;;
    *.tbz2)    tar xjf "$f" ;;
    *.tgz)     tar xzf "$f" ;;
    *.zip)     unzip "$f" ;;
    *.Z)       uncompress "$f" ;;
    *.7z)      7z x "$f" ;;
    *)         echo "'$f' cannot be extracted via extract()"; return 2 ;;
  esac
}



# Yazi: if file chosen -> cd to file dir and open it
#       if quit/cancel   -> cd to last dir you were in
# y() {
#   local tmp_cwd tmp_choice cwd choice
#
#   tmp_cwd="$(mktemp -t yazi-cwd.XXXXXX)"
#   tmp_choice="$(mktemp -t yazi-choice.XXXXXX)"
#
#   yazi --cwd-file="$tmp_cwd" --chooser-file="$tmp_choice" "$@"
#
#   # 1) If a file was chosen, cd to its directory and open it
#   if [[ -s "$tmp_choice" ]]; then
#     choice="$(head -n 1 "$tmp_choice")"
#     if [[ -n "$choice" ]]; then
#       builtin cd -- "${choice:h}"
#       rm -f -- "$tmp_cwd" "$tmp_choice"
#       command nvim -- "$choice"
#       return 0
#     fi
#   fi
#
#   # 2) Otherwise (q/cancel), cd to the last dir Yazi wrote
#   if [[ -s "$tmp_cwd" ]]; then
#     cwd="$(cat "$tmp_cwd")"
#     [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
#   fi
#
#   rm -f -- "$tmp_cwd" "$tmp_choice"
# }
#

y() {
  local tmp_cwd tmp_choice cwd choice

  tmp_cwd="$(mktemp -t yazi-cwd.XXXXXX)"
  tmp_choice="$(mktemp -t yazi-choice.XXXXXX)"

  yazi --cwd-file="$tmp_cwd" --chooser-file="$tmp_choice" "$@"

  # If a file was chosen
  if [[ -s "$tmp_choice" ]]; then
    choice="$(head -n 1 "$tmp_choice")"
    if [[ -n "$choice" ]]; then
      builtin cd -- "${choice:h}"
      rm -f -- "$tmp_cwd" "$tmp_choice"

      case "$choice" in
        *.pdf)
          # macOS: open in Zathura app (GUI, Cmd-Tab friendly)
          open -a "Zathura" -- "$choice"
          ;;
        *.png|*.jpg|*.jpeg|*.gif|*.webp|*.svg|*.mp4|*.mkv|*.mov|*.mp3|*.wav)
          # macOS: use default app
          open -- "$choice"
          ;;
        *)
          # default: open in nvim
          command nvim -- "$choice"
          ;;
      esac

      return 0
    fi
  fi

  # Otherwise (q/cancel), cd to last dir Yazi wrote
  if [[ -s "$tmp_cwd" ]]; then
    cwd="$(cat "$tmp_cwd")"
    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
  fi

  rm -f -- "$tmp_cwd" "$tmp_choice"
}

# --- Fuzzy File Finder Widgets ---
fzf-file-widget() {
  local file
  file="$(fd --type f --hidden --follow --exclude .git --exclude node_modules . \
    | fzf --height 40% --reverse --border --ansi \
           --preview 'bat --style=numbers --color=always --line-range :100 {} 2>/dev/null')" || return
  LBUFFER+="${(q)file}"
  zle reset-prompt
}
zle -N fzf-file-widget
bindkey '^F' fzf-file-widget

fzf-open-widget() {
  local file
  file="$(fd --type f --hidden --follow --exclude .git --exclude node_modules . \
    | fzf --height 40% --reverse --border --ansi \
           --preview 'bat --style=numbers --color=always --line-range :100 {} 2>/dev/null')" || return
  "${EDITOR:-nvim}" "$file"
  zle reset-prompt
}
zle -N fzf-open-widget
bindkey '^O' fzf-open-widget

# ================================
#  External env/hooks
# ================================
# opam (quiet)
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>&1
# Java (for Morpho)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# ================================
#  FINAL: Auto-attach tmux (and pass THEME in)
# ================================
if [[ $- == *i* ]] && command -v tmux >/dev/null 2>&1 && [[ -z "$TMUX" && -z "$NO_TMUX" ]]; then
  # Ensure tmux environment receives THEME so NvChad sees it
  tmux set-environment -g THEME "$THEME" 2>/dev/null
  tmux attach -t main || tmux new -s main
fi



[ -f "/Users/kallip/.ghcup/env" ] && . "/Users/kallip/.ghcup/env" # ghcup-env
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"
