# fnm configuration for fish
if test -d $HOME/.local/share/fnm
    set -gx PATH $HOME/.local/share/fnm $PATH
end

if command -v fnm >/dev/null
    fnm env --use-on-cd --shell fish 2>/dev/null | source; or true
end
