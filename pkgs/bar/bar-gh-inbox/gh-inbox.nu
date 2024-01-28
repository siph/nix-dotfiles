#!/usr/bin/env nu

# Use the `github-cli` to display notification count
def main [min_messages: number = 10] {
    let count = (gh api notifications -q '. | length') | into int
    if $count >= $min_messages {
        print $" : ($count)"
    } else {
        print " "
    }
}
