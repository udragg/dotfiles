set shell := ["fish", "-c"]


stow +dirs:
    for dir in {{dirs}}; stow "$dir" && echo "Stowed $dir"; end


unstow +dirs:
    for dir in {{dirs}}; stow --delete "$dir" && echo "Unstowed $dir"; end


new-config +names:
    for name in {{names}}; mkdir -p ./$name/.config; end


migrate-config +names: (new-config names)
    for name in {{names}}; mv ~/.config/$name ./$name/.config/ && stow $name && echo "Migrated $name" || echo "Failed to migrate $name"; end


list arg="":
    @ls --only-dirs {{arg}}


show arg="":
    @tree -a -L 4 {{arg}}


show-all arg="":
    @tree -a {{arg}}

edit arg:
    @cd {{arg}}/.config/{{arg}} && nvim && cd -
