function fvim -d "fzf + git: open selected files in vim"
    set -l selected_files (git ls-files | fzf -m --preview 'head -100 {}')
    if test -n "$selected_files"
        vim $selected_files
    end
end
