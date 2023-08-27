#!/usr/bin/env nu

# Get date and time as string with format.
def main [
    --format: string = "%a ● %D ● %r"; # Output string display format. Default: `%a ● %D ● %r`.
] {
    date now
    | format date $"($format)"
    | str replace ` ● ` ` %{F#712222}●%{F-} `
    | str replace ` ● ` ` %{F#2e9afe}●%{F-} `
}
