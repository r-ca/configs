#!/bin/zsh

# 移動元ディレクトリを記録する環境変数名

# uncd_dirsの初期化
unchd_dirs=()

# push
function uncd_push() {
    # 配列の要素数が10を超えていたら、最初の要素を削除
    if [ ${#unchd_dirs[@]} -gt 30 ]; then
        unchd_dirs=(${unchd_dirs[@]:1})
    fi

    # 前回のディレクトリと同じ場合、追加しない(cdに失敗した場合とかにあり得る)
    if [ ${#unchd_dirs[@]} -gt 0 ]; then
        if [ ${unchd_dirs[-1]} = $1 ]; then
            return
        fi
    fi

    # 引数のディレクトリを配列に追加
    unchd_dirs+=($1)
}

# pop
function uncd_pop() {
    # 配列の最後の要素を取得して削除
    # 取得した要素を出力
    local dir=${unchd_dirs[-1]}
    echo $dir
}

function uncd_do() {
    # 引数がない場合、配列の最後の要素を取得
    if [ $# -eq 0 ]; then
        local dir=$(uncd_pop)
    else
        local dir=$1
    fi
    # ディレクトリが存在しない場合、エラーを出力
    if [ ! -d $dir ]; then
        echo "No such directory: $dir" 1>&2
        return 1
    fi
    # ディレクトリに移動
    \cd $dir # uncd時にディレクトリを記録して欲しくないため
}

function uncd_ls() {
    # 配列の要素数が0の場合、エラーを出力
    if [ ${#unchd_dirs[@]} -eq 0 ]; then
        echo "unchd: directory stack empty" 1>&2
        return 1
    fi
    # 配列の要素のから選択肢を表示
    select dir in ${unchd_dirs[@]}; do
        uncd_do $dir
        break
    done
}

# logic

function uncd() {
    # 引数チェック
    if [ $# -eq 0 ]; then
        uncd_do
    elif [ $# -eq 1 ]; then
        case $1 in
            -l)
                uncd_ls
                ;;
            *)
                uncd_do $1
                ;;
        esac
    else
        echo "usage: uncd [-l] [directory]" 1>&2
        return 1
    fi
}

# hook cd command
# cdコマンドをフックして、移動元ディレクトリを記録


alias cd='uncd_push $(pwd); cd'
alias uncd=uncd
