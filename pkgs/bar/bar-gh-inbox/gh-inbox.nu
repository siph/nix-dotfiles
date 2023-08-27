#!/usr/bin/env nu

# Use the `github-cli` to display notification count
def main [] {
    let count = (gh api notifications -q '. | length') | into int
    if $count > 0 {
        print $" : ($count)"
    } else {
        print " "
    }
}
