# Nushell Config
let-env config = {
    show_banner: false
    edit_mode: vi
    footer_mode: always
    shell_integration: true
    table: {
        mode: rounded
        index_mode: always
    }
    completions: {
        algorithm: prefix # fuzzy, prefix
        quick: true
        case_sensitive: false
    }
    history: {
        max_size: 10000
        file_format: sqlite
    }
    filesize: {
        metric: true
    }
}

# Alias
alias ll = ls
alias lt = lsd --tree
alias cat = bat
alias tree = broot
alias startx-dwm = startx ~/.xinitrc dwm
alias startx-kde = startx ~/.xinitrc kde
alias start-hyprland = ~/.local/bin/start-hyprland
