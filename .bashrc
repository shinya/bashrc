# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


#-----------------------
# functions
#-----------------------
docker-down(){
	docker ps -aq | xargs docker stop | xargs docker rm
}
docker-clear(){
	docker-down
	docker volume rm $(docker volume ls -qf dangling=true)
}

__show_status() {
    local status=$(echo -n ${PIPESTATUS[@]})
    local SETCOLOR_SUCCESS="echo -en \\033[1;32m"
    local SETCOLOR_FAILURE="echo -en \\033[1;31m"
    local SETCOLOR_WARNING="echo -en \\033[1;33m"
    local SETCOLOR_NORMAL="echo -en \\033[0;39m"

    local SETCOLOR s
    for s in ${status}
    do
        if [ ${s} -gt 100 ]; then
            SETCOLOR=${SETCOLOR_FAILURE}
        elif [ ${s} -gt 0 ]; then
            SETCOLOR=${SETCOLOR_WARNING}
        else
            SETCOLOR=${SETCOLOR_SUCCESS}
        fi
    done
    ${SETCOLOR}
    echo -n "(${status// /|})"
    ${SETCOLOR_NORMAL}
}
function share_history {
        history -a
        history -c
        history -r
}
setting_prompt() {
        export PS1="\!:[\[\e[1;36m\]\W\[\e[m\]]$(__show_status)\$ "
        share_history
}

ymd () {
        date "+%Y%m%d %H:%M:%S"
}

#-----------------------
# Prompt Setting
#-----------------------
#PROMPT_COMMAND='__show_status;'${PROMPT_COMMAND//__show_status;/}
PROMPT_COMMAND='setting_prompt;'${PROMPT_COMMAND//setting_prompt;/}

#export PS1="[\u@\h \W]\$ "
export PS1="[\[\e[1;36m\]\w\[\e[m\]](\!)\$ "

shopt -u histappend

#-----------------------
# Other Setting
#-----------------------
# history数50000
HISTSIZE=50000
# history にコマンド実行時刻を記録する
HISTTIMEFORMAT='%Y-%m-%d_%H:%M:%S '

# node設定
source ~/.nvm/nvm.sh

#PATH=$PATH:$HOME/node_modules/.bin
#export PATH

if [ $SHLVL = 1 ]; then
  alias tmux="tmux attach || tmux new-session \; source-file ~/.tmux-session"
fi
