# Created by newuser for 5.9
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})窶ｦ%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

### rca
## alias ===================================================
# アーキテクチャ切り替え
alias arm="exec arch -arch arm64e /bin/zsh --login"
alias x64="exec arch -arch x86_64 /bin/zsh --login"

# lsをGNU版に置き換える
#alias ls="gls --color=auto"

# プロンプトのモード切り替える奴
alias sonanoka="export rca_shell_prompt_mode=normal && source ~/.zshrc"
alias nanoka="export rca_shell_prompt_mode=presentation && source ~/.zshrc"
alias nyashi="export rca_shell_prompt_mode=nyashi && source ~/.zshrc"

# ショートカット系
alias cl="clear"
alias lsa="ls -a"
alias lls="ls -l"
alias llsa="ls -la"

# 再ログイン
alias relogin="/bin/zsh --login"

## History =================================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

## Plugin ==================================================
# 補完
autoload -Uz compinit && compinit
# 履歴補完
zinit light zsh-users/zsh-autosuggestions

## シンタックスハイライト
zinit light zsh-users/zsh-syntax-highlighting

## Prompt ==================================================
if [ -z "$rca_shell_prompt_mode" ]; then
  export rca_shell_prompt_mode=normal # 規定値
fi

# left-prompt系 ---------------------------------------------
if [ "$rca_shell_prompt_mode" = "normal" ]; then
  function left-prompt { # normal(普通のやつ)
    # 文字色
    local name_t='254m%}'
    local arch_t='250m%}'
    local name_b='176m%}'
    local path_t='252m%}'
    local path_b='140m%}'
    local arrow='097m%}'
    local text_color='%{\e[38;5;'
    local back_color='%{\e[30;48;5;'
    # リセット
    local reset='%{\e[0m%}'
    # 図形(区切り)
    local sharp='\uE0B0'
    # アーキテクチャ
    local arch=`uname -m`

    user="${back_color}${name_b}${text_color}${name_t}"
    dir="${back_color}${path_b}${text_color}${path_t}"

    echo -e "${user}%n@%m ${text_color}${arch_t}(${arch})${back_color}${path_b}${text_color}${name_b}${sharp} ${dir}%~${reset}${text_color}${path_b}${sharp}${reset}\n${text_color}${arrow}⊂(ﾟヮﾟ)⊃♪ > ${reset}"
  }
elif [ "$rca_shell_prompt_mode" = "presentation" ]; then
  function left-prompt { # presentation(画面共有とか)
    # 文字色
    local name_t='254m%}'
    local arch_t='250m%}'
    local name_b='234m%}'
    local path_t='255m%}'
    local path_b='243m%}'
    local arrow='097m%}'
    local text_color='%{\e[38;5;'
    local back_color='%{\e[30;48;5;'
    # リセット
    local reset='%{\e[0m%}'
    # 図形(区切り)
    local sharp='\uE0B0'
    # アーキテクチャ
    local arch=`uname -m`

    user="${back_color}${name_b}${text_color}${name_t}"
    dir="${back_color}${path_b}${text_color}${path_t}"

    echo -e "${user}%n@%m ${text_color}${arch_t}(${arch})${back_color}${path_b}${text_color}${name_b}${sharp} ${dir}%~${reset}${text_color}${path_b}${sharp}${reset}\n${text_color}${arrow}-> ${reset}"
  }
elif [ "$rca_shell_prompt_mode" = "nyashi" ]; then
  function left-prompt { #nyashi(SSHセッションとかで使うやつ)
    local arch=`uname -m`
    echo -e "%n@%m(${arch}) %~\n-> "
  }
fi

PROMPT=`left-prompt`

## Options ==================================================
# 環境変数の補完
setopt AUTO_PARAM_KEYS

export PATH="${PATH}:/home/rca/proj/miniique-devs"
## Other ====================================================
# 入力した文字から始まるコマンドを履歴から検索し、上下矢印で補完
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

## functions ================================================
## 色を一覧で表示する関数
## https://original-game.com/mini_howto/how-to-display-a-list-of-colors-with-zsh/
colorlist() {
  for color in {000..015}; do
    print -nP "%F{$color}$color %f"
  done
  printf "\n"
  for color in {016..255}; do
    print -nP "%F{$color}$color %f"
    if [ $(($((color-16))%6)) -eq 5 ]; then
      printf "\n"
    fi
  done
}
export GPG_TTY=$(tty)
