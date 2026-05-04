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

