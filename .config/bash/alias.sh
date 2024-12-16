alias n="nnn -P p"
alias k="kubectl"
alias v="nvim"
alias brc=". ~/.bashrc"
alias eg="env | grep -i"

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

function justvenv()
{
    . ../venv/$(dirname)/bin/activate
}

function intis()
{
    [ -d ../venv/$(dirname) ] || mkdir -p ../venv/$(dirname) 2>/dev/null
    ~/.pyenv/versions/3.7.17/bin/python -m venv ../venv/$(dirname) 2>/dev/null
    . ../venv/$(dirname)/bin/activate
    ../venv/$(dirname)/bin/pip install pipenv==2021.11.23
}

