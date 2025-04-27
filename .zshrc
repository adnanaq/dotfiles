start_time=$(date +%s%3N)

# 1. Environment variables and paths — keep these at the top (fast, no evals)
export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:/usr/local/go/bin" # Go path for global access
export PATH="$PATH:$HOME/go/bin" # Go package documentation
export CGO_ENABLED=1 # Enable cgo to allow Go's race detector to function properly
export PATH="$PATH:$HOME/.local/bin" # Protocol Buffer Compiler
export PATH="$PATH:/opt/nvim-linux-x86_64/bin" # Neovim path for global access

# 2. Fast-loading utility functions or static sources
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Conda early because it's heavy and PATH-dependent
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dani/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dani/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dani/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dani/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# 3. Plugin manager (Zinit) — load before plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git" # Set the directory we want to store zinit and plugins
if [ ! -d "$ZINIT_HOME" ]; then # Download and Set Zinit for zsh plugins
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh" # Load Zinit

# 4. Plugin and Snippets load (defer slow ones)
# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# Snippets
zinit snippet OMZP::git

# 5. Prompt (Starship) — early so prompt is styled as shell starts
eval "$(starship init zsh)"

# 6. Completion setup — must follow plugin loading
autoload -U compinit && compinit
zinit cdreplay -q

# 7. History behavior
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt  appendhistory sharehistory hist_ignore_space \
        hist_save_no_dups hist_ignore_dups hist_ignore_all_dups hist_find_no_dups

# 8. History key bindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# 9. fzf and zoxide integrations (load near end — slower)
# Load Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Shell Integration
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# 10. Completion styles
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# 11. Aliases
alias ls='ls --color'

end_time=$(date +%s%3N)
elapsed_time=$((end_time - start_time))
echo "Zsh startup time: ${elapsed_time}ms"