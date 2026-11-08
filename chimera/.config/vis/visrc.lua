require('vis')

vis.events.subscribe(vis.events.INIT, function()
    vis:command('set theme default')   -- uses your 16 terminal colors, like your t_Co=16 setup
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    vis:command('set number')          -- nu
    vis:command('set relativenumber')  -- rnu
    vis:command('set autoindent')      -- ai
    vis:command('set tabwidth 4')      -- vis has no separate shiftwidth
    vis:command('set ignorecase')
end)

-- <Space> prefix for your git-rebase helpers (untested; adjust if keys misbehave)
vis:map(vis.modes.NORMAL, '<Space>h', '^dwipick <Escape>j')
vis:map(vis.modes.NORMAL, '<Space>j', '^dwisquash <Escape>j')
vis:map(vis.modes.NORMAL, '<Space>k', '^dwifixup <Escape>j')
vis:map(vis.modes.NORMAL, '<Space>l', '^dwireword <Escape>j')

require('plugins/vis-commentary')
require('plugins/vis-cursors')
require('plugins/vis-colorizer')
require('plugins/vis-surround')
