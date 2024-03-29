#!/usr/bin/zsh

: ${DOCS_FILE_PATH:?"Error: DOCS_FILE_PATH must be set"}
: ${EDITOR:=nano}

alias less='less \
    --tilde \
    --use-color \
    --mouse \
    --incsearch \
    --quiet \
    --quit-on-intr \
    --status-column \
    --ignore-case'

# Number all lines (including empty ones)
alias nl='nl -ba'

# Open docs file in editor
if [ "$1" = -e ] || [ "$1" = --edit ]; then
    $EDITOR $DOCS_FILE_PATH
    exit $?
fi

# Set source to be searched
# The only requirement is that the command outputs to stdout
case $1 in
    -b | --bash) # Bash man page
        alias src_cmd="man bash"
        shift
        ;;
    -t | --tmux) # Tmux man page
        alias src_cmd="man tmux"
        shift
        ;;
    *) # Personal documentation file
        alias src_cmd="cat ${DOCS_FILE_PATH}"
        ;;
esac

# Check for fzf
if command -v fzf; then
    # If present, use it to search in documentation
    alias fzf='fzf \
        --with-nth 2.. \
        --layout reverse-list'

    if [ $1 ]; then
        # Let the user search, and get the line number
        # Starting with the given argument as a search, automatically select
        # option if there is only 1 option left, and automatically exit if
        # there are no options
        num=$(
            query=$@;
            src_cmd | nl | fzf -1 -q "$query" | awk '{ print $1 }'
        )

        if [ $num ]; then
            # If the search succeeded, go to line
            src_cmd | less +$num
        else
            # If the search failed, open normally
            src_cmd | less
        fi
    else
        # Let the user search, and get the line number
        num=$(src_cmd | nl | fzf | awk '{ print $1 }')

        if [ $num ]; then
            # If the search succeeded, go to line
            src_cmd | less +$num
        else
            # If the search failed, open normally
            src_cmd | less
        fi
    fi

    exit $?
fi

# If fzf is not present, open the docs file in less
if [ $1 ]; then
    # If there is an argument, search for it
    src_cmd | less "+/$@"
else
    # If not, open normally
    src_cmd | less
fi

exit $?
