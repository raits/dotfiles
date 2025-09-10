if test -x ~/.cargo/bin/fnm
    ~/.cargo/bin/fnm env --use-on-cd --resolve-engines --shell fish | source
else if command -v fnm >/dev/null 2>&1
    fnm env --use-on-cd --shell fish | source
else
    echo "Warning: fnm is not available on this system" >&2
end
