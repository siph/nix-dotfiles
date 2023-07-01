#!/usr/bin/env nu

# Query `wttr.in` for weather report with location and format.
def main [
    --location: string, # Can be city name or ICAO code.
    --format: string = "%c%t ● %h ● %w ● %m"; # Optional output string display format. Default: `%c%t ● %h ● %w ● %m`.
] {
    http get $"https://wttr.in/($location)?format=($format)"
}