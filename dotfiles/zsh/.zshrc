# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins (default fallback)
plugins=(git)

# Load local overrides
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Prompt config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Aliases
[[ -f ~/.aliases.zsh ]] && source ~/.aliases.zsh

# Zoxide
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# Conda
conda() {
  unset -f conda
  if [[ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]]; then
    source "$HOME/miniconda3/etc/profile.d/conda.sh"
    conda "$@"
  else
    echo "conda is not installed at $HOME/miniconda3" >&2
    return 127
  fi
}

# Better shell behavior
setopt autocd
setopt interactivecomments
setopt histignorealldups
export PATH="$HOME/.local/bin:$PATH"
