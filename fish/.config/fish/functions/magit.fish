function magit --description "Open Magit in terminal Emacs"
    set -l dir (pwd)
    if test (count $argv) -gt 0
        set dir $argv[1]
    end
    # Start daemon if not running, then connect
    emacsclient -t -a "" -e "(magit-status \"$dir\")"
end
