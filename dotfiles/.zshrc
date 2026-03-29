# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Completion configuration
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Options
setopt COMPLETE_IN_WORD  # allow tab completion in the middle of a word
setopt autocd            # type directory name to cd into it

# Initialize completion system
autoload -Uz compinit
compinit

# Key bindings — emacs mode with alt-arrow word navigation
bindkey -e
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# Prompt
PROMPT='%F{172}%~ %%%f '

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Antigravity (only if installed)
if [[ -d "$HOME/.antigravity/antigravity/bin" ]]; then
  export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
fi

# Java (Homebrew OpenJDK — Apple Silicon)
if [[ -d "/opt/homebrew/opt/openjdk/bin" ]]; then
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
  export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
fi
