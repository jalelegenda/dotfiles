alias n="nnn -P p"
alias k="kubectl"
alias v="nvim"
alias brc=". ~/.bashrc"
alias eg="env | grep -i"
alias vg="nvim --listen /tmp/godot.pipe"
alias se="sudoedit"
alias vc="nvim -c 'cd ~/.config/nvim' ~/.config/nvim/init.lua"

alias televend="PYTHONUNBUFFERED=1;DJANGO_SETTINGS_MODULE=televend3.settings.local;PYDEVD_USE_CYTHON=NO;CONF=dev python -m debugpy --listen 5678 --configure-subProcess False manage.py runserver --noreload"

function dirname()
{
    dirname="$PWD"
    result="${dirname%"${dirname##*[!/]}"}"
    result="${result##*/}"
    echo ${result:-/}
}

function dockerstop()
{
    docker stop $(docker ps -q)
}

function venv()
{
    . ../venv/$(dirname)/bin/activate
}

function fixbt()
{
    rsv stop bluetoothd
    mods=("btusb" "btrtl" "btmtk" "btintel" "btbcm" "bnep" "hci_vhci" "rfcomm" "bluetooth")
    len=${#mods[@]}
    for mod in ${mods[@]}
    do
        sudo modprobe -r $mod
    done

    for ((i=len-1; i>=0; i--))
    do
	sudo modprobe ${mods[i]}
    done
    rsv start bluetoothd
    echo "Bluetooth mods reloaded, bluetoothd service restarted."
}
