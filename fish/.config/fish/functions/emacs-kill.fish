function emacs-kill --description "Kill Emacs daemon"
    emacsclient -e '(kill-emacs)' 2>/dev/null
    or true
end
