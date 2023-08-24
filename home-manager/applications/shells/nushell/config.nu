let carapace_completer = {|spans|
    carapace $spans.0 nushell $spans | from json
}

# Nushell Config
$env.config = {
    show_banner: false
    edit_mode: vi
    footer_mode: always
    shell_integration: true
    table: {
        mode: rounded
        index_mode: always
        header_on_separator: true
        padding: { left: 2, right: 1}
    }
    completions: {
        algorithm: prefix # fuzzy, prefix
        quick: true
        case_sensitive: false
        external: {
         enable: true
         max_results: 50
         completer: $carapace_completer
        }
    }
    history: {
        max_size: 10000
        file_format: sqlite
    }
    filesize: {
        metric: true
    }
}

# Helper functions

# Filter directory by file name.
def lls [
    term: string # Search target.
] {
    ls | string-search $term name
}

# Filter directory by file name.
def llm [] {
    ls | sort-by modified
}

# Filter process list by process name.
def pss [
    term: string # Search target.
] {
    ps | string-search $term name
}

# Helper function for filtering data by string. Records are transposed into tables with "key" and "value" columns.
# > $env | string-search config key
def string-search [
    term: string # Search target.
    column?: string # column name. Leave blank if list.
] {
    let dayduh = $in
    if ($column == null) {
        $dayduh | where ($it| str contains $term)
    } else if ($dayduh | get-type | str contains record) {
        $dayduh | transpose key value | string-search $term $column
    } else {
        $dayduh | where ($it| get $column | str contains $term)
    }
}

# Get object type without it's contained data information.
def get-type [] {
    describe | split row '<' | get 0
}

