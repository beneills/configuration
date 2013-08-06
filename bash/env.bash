## Exports

# Add ~/bin/, ~/.secret/bin/, and ~/bin/*/ to PATH
PATH+=":~/bin:~/.secret/bin"
for d in ~/bin/*/; do
    PATH+=":$d"
done

export MPD_HOST="192.168.1.67"
export EDITOR='emacsclient -nw'
export CDPATH=CDPATH:~/.cd_aliases/
