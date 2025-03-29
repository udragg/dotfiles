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

# XDG base directories
export XDG_DATA_HOME="$HOME/.local/share/"
export XDG_CACHE_HOME="$HOME/.cache/"
export XDG_CONFIG_HOME="$HOME/.config/"

# uv: supress harklink warning
export UV_LINK_MODE=copy

# inits
zoxide init fish | source
cod init $fish_pid fish | source
starship init fish | source
enable_transience

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

function pyvenv
    if test "$argv[1]" = ""
	set venv_name ".venv"
    else
	set venv_name "$argv[1]"
    end
    if test "$VIRTUAL_ENV" = "" # no virtualenv active
	if test -d "$venv_name"
	    source "$venv_name/bin/activate.fish"
	    echo "Activated virtual environment at $venv_name"
	else
	    echo "Could not find $venv_name"
	end
    else
	deactivate
	echo "Deactivated virtual environment"
    end
end
alias venv "pyvenv"

# prevent bad linebreaks with nvim as manpager
function man
    COLUMNS=(math $COLUMNS -3) command man $argv
end

fzf --fish | source
