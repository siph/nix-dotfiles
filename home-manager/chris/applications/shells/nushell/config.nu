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
        {
            name: history_completion_vi_normal
            modifier: none
            keycode: char_l
            mode: vi_normal
            event: {
                until: [
                    { send: historyhintcomplete }
                    { send: menuright }
                    { send: right }
                ]
            }
        }
    ]
}

# Alias
alias ll = ls
alias cat = bat
alias tree = broot
alias startx-dwm = startx ~/.xinitrc dwm
alias startx-kde = startx ~/.xinitrc kde
