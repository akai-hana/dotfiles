#!/bin/dash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file_or_dir>"
    exit 1
fi

SRC="$1"
DOTFILES="$HOME/.dotfiles"
TARGET="$DOTFILES${SRC#/}"

if [ ! -e "$SRC" ]; then
    echo "Error: $SRC does not exist"
    exit 1
fi

is_dir=0
if [ -d "$SRC" ]; then
    is_dir=1
fi

mkdir -p "$(dirname "$TARGET")"

if [ -e "$TARGET" ]; then
    if { [ $is_dir -eq 1 ] && [ ! -d "$TARGET" ]; } || { [ $is_dir -eq 0 ] && [ ! -f "$TARGET" ]; }; then
        echo "Error: Type mismatch between $SRC and $TARGET"
        exit 1
    fi

    if diff -rq "$SRC" "$TARGET" >/dev/null 2>&1; then
        echo "Contents of $SRC and $TARGET are identical."
        echo "Proceed to delete original and symlink? (y/n)"
        read ans
        case "$ans" in
            [yY]) ;;
            *) exit 0 ;;
        esac
        doas rm -rf "$SRC"
        doas ln -s "$TARGET" "$SRC"
    else
        echo "Differences between $SRC and $TARGET:"
        diff -r "$SRC" "$TARGET"
        if [ $is_dir -eq 1 ]; then
            echo "Merge (m), replace (r), or cancel (c)?"
            read ans
            case "$ans" in
                [mM])
                    doas rsync -a "$SRC/" "$TARGET/"
                    doas rm -rf "$SRC"
                    ;;
                [rR])
                    rm -rf "$TARGET"
                    doas mv "$SRC" "$TARGET"
                    ;;
                *) exit 0 ;;
            esac
        else
            echo "Replace $TARGET with $SRC? (y/n)"
            read ans
            case "$ans" in
                [yY])
                    doas mv "$SRC" "$TARGET"
                    ;;
                *) exit 0 ;;
            esac
        fi
        doas ln -s "$TARGET" "$SRC"
    fi
else
    doas mv "$SRC" "$TARGET"
    doas ln -s "$TARGET" "$SRC"
fi
