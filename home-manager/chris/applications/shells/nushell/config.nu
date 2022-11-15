# Nushell Config
let-env config = {
    filesize_metric: true
    table_mode: rounded
    show_banner: false
    edit_mode: vi
    footer_mode: always
    quick_completions: true
    completion_algorithm: prefix # fuzzy, prefix
    max_history_size: 10000
    shell_integration: true
    table_index_mode: always
    case_sensitive_completions: false
    keybindings: [
    ]
}

# Alias
alias ll = ls
alias cat = bat
alias tree = broot
alias startx-dwm = startx ~/.xinitrc dwm
alias startx-kde = startx ~/.xinitrc kde
