# Helpers for starting Cursor agents from the command line.

function work() {
    local agent_path

    agent_path="$(command -v agent 2>/dev/null)"

    if [[ -z "$agent_path" ]]; then
        print -u2 "work: Cursor Agent CLI ('agent') is not installed or is not in PATH."
        print -u2 "Install it with: curl https://cursor.com/install -fsS | bash"
        return 127
    fi

    print "Cursor Agent CLI found: $agent_path"
}
