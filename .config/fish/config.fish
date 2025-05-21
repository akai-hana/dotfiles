if status is-interactive
    wal -Rqnte &
    fish -c 'starship init fish | source' &
end
