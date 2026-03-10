# fnm configuration for fish
if test -d $HOME/.local/share/fnm
    set -gx PATH $HOME/.local/share/fnm $PATH
end

if command -v fnm >/dev/null
    fnm env --use-on-cd | source
end
