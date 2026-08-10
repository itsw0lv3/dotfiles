# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="zhann"
# ZSH_THEME="trapd00r"

plugins=(
	fzf
	git
	history-substring-search
	colored-man-pages
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-z
	emacs
	python
	golang
)

source $ZSH/oh-my-zsh.sh
setopt CORRECT

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias venv="source ./venv/bin/activate"
alias obsidian="nvim ~/Documents/Personal/Notes"

# Path Exports:
export PATH=$HOME/.local/bin:$PATH

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --height=80%"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# tmux autostart
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi


# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/w0lv3/.lmstudio/bin"
# End of LM Studio CLI section

