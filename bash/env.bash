## Exports

# Add ~/bin/, ~/.secret/bin/, and ~/bin/*/ to PATH
PATH+=":~/bin:~/.secret/bin"
for d in ~/bin/*/; do
    PATH+=":$d"
done

export EDITOR='emacsclient -nw'
export CDPATH=CDPATH:~/.cd_aliases/
