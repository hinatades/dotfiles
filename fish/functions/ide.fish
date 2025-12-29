function ide -d "tmux: create IDE-like 3-pane layout"
    tmux send-keys -R
    tmux split-window -v -p 15
    tmux select-pane -U
    tmux split-window -h
    tmux select-pane -R
end
