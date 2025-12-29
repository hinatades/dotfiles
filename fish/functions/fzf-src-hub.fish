function fzf-src-hub -d "fzf + ghq + gh: open repository in browser"
    set -l selected_repo (ghq list | fzf --query (commandline -b) | cut -d "/" -f 2,3)
    if test -n "$selected_repo"
        gh repo view --web $selected_repo
        commandline -f repaint
    end
end
