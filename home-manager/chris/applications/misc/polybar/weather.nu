#!/usr/bin/env nu
(http get `https://wttr.in/@city@?format="@format@"`) | str replace -s -a "\"" ""
