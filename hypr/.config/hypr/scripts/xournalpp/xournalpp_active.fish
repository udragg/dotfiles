#!/usr/bin/fish
test $(hyprctl -j activewindow | jq ".class") = '"com.github.xournalpp.xournalpp"'
