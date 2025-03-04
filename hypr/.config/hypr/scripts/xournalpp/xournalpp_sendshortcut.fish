#!/usr/bin/fish
if ~/.config/hypr/scripts/xournalpp/xournalpp_active.fish
    hyprctl dispatch sendshortcut "$argv"
else
    ~/.config/hypr/scripts/xournalpp/xournalpp_deactivate.fish
end
