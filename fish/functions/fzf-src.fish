function fzf-src -d "fzf + ghq: cd to selected repository"
    set -l selected_dir (ghq list -p | fzf --query (commandline -b))
    if test -n "$selected_dir"
        cd $selected_dir
        commandline -f repaint
    end
end
