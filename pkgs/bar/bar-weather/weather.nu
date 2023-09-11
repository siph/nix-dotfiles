#!/usr/bin/env nu

# Query `wttr.in` for weather report with location and format.
def main [
    --location: string,  # Can be city name or ICAO code.
    cache?: path,      # Directory for cache(s).
] {

    let cache = (if ($cache == null) {
        $"($env.HOME)/.cache"
    } else { $cache })

    let purple = "#9058c7"
    let green = "#8ec07c"
    let yellow = "#d79921"

    let wttr = ((wt-fetch $location $cache --all) | from json)

    $"($wttr.condition) ($wttr.temp) %{F($purple)}●%{F-} ($wttr.humidity) %{F($green)}●%{F-} ($wttr.wind) %{F($yellow)}●%{F-} ($wttr.moon)"
}
