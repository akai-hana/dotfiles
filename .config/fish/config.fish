if status is-interactive
    #wal -Rqnte &
    fish -c 'starship init fish | source' &

    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
