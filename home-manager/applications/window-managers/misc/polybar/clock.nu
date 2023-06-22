#!/usr/bin/env nu

# Get date and time as string with format.
def main [
    --format: string = "%a ● %D ● %r"; # Output string display format. Default: `%a ● %D ● %r`.
] {
    date now | date format $"($format)"
}
