# --cmd cd hace que zoxide reemplace cd usando builtin cd internamente (sin recursión)
zoxide init fish --cmd cd 2>/dev/null | source
