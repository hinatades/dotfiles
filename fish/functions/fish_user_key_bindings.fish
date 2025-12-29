function fish_user_key_bindings
    # fzf-src: Ctrl+[ (Escape)
    bind \e\[ fzf-src

    # fzf-src-hub: Ctrl+]
    bind \e\] fzf-src-hub

    # fzf_key_bindings (fzf.fishプラグインがインストールされている場合)
    if functions -q fzf_key_bindings
        fzf_key_bindings
    end
end
