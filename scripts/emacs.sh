#!/bin/sh

awesome-client 'client.focus.minimized = true' &

emacs "$@"

awesome-client 'for _, c in ipairs(client.get()) do if c.minimized then c.minimized = false; client.focus = c; break end end'
