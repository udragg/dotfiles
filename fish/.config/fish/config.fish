if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting ""
    fastfetch
end

# aliases
set ls_cmd "eza --icons --git --group-directories-first"
alias ls $ls_cmd
alias g "git"
alias o "open"
alias vi "nvim"
alias hx "helix"
alias tmux "tmux -2"
alias lg "lazygit" 
alias l "loginctl lock-session"
alias sctl "systemctl "
alias btctl "bluetoothctl"
alias tree "$ls_cmd --tree --git-ignore"
alias amdgpu_top "amdgpu_top --dark"

# env var
export EDITOR=nvim
export MANPAGER="nvim +Man!"

# inits
zoxide init fish | source
cod init $fish_pid fish | source
starship init fish | source
enable_transience
pyenv init - | source

# ROCm config
export ROCM_PATH="/opt/rocm"
export HSA_OVERRIDE_GFX_VERSION="11.0.0"

function rn
    set tmp $(mktemp -t rn.XXXXXXXX)
    echo $argv > $tmp
    $EDITOR $tmp
    mv $argv $(cat $tmp)
    rm -f -- $tmp
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
	    z -- "$cwd"
    end
    rm -f -- "$tmp"
end

fzf --fish | source
