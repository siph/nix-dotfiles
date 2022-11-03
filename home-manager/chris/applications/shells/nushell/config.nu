# Nushell Config
let-env config = {
    filesize_metric: true
    table_mode: rounded
    show_banner: false
    edit_mode: vi
    footer_mode: always
    quick_completions: false
    completion_algorithm: fuzzy # fuzzy, prefix
    max_history_size: 10000
    shell_integration: true
    table_index_mode: always
    case_sensitive_completions: false

}

# Alias
alias ll = ls
alias cat = bat
