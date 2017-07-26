function set_prompt()
{
    RED="\[\033[1;31m\]"
    YELLOW="\[\033[01;33m\]"
    GREEN="\[\033[32;1m\]"
    OFF="\[\033[m\]"

    prompt="[\#]\u@\h:\W"
    branch=$(git branch 2> /dev/null | grep \* | awk '{print $2}')
    untracked="$(git diff --name-only 2> /dev/null)$(git ls-files --others --exclude-standard 2> /dev/null)"
    uncommited=$(git status -s 2> /dev/null)
    if [[ "$untracked" = "" ]];
    then
        if [[ -z $uncommited ]];
        then
            [[ "$branch" = "" ]] || prompt="$prompt (${GREEN}git:$branch${OFF})"
        else
            [[ "$branch" = "" ]] || prompt="$prompt (${YELLOW}git:$branch${OFF})"
        fi
    else
            [[ "$branch" = "" ]] || prompt="$prompt (${RED}git:$branch${OFF})"
    fi
    [[ "$VIRTUAL_ENV" = "" ]] || prompt="($(echo $VIRTUAL_ENV | awk -F '/' '{print $NF}'))$prompt"
    # if you want a something to tell you if you're in a screen session
    #[[ "$STY" = "" ]] || prompt="(screen)$prompt"
    export PS1="$prompt>>> "
}

export PROMPT_COMMAND=set_prompt
