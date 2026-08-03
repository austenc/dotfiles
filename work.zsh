# Helpers for starting Cursor agents from the command line.

function work() {
    local agent_path
    local issue_number
    local issue_key

    agent_path="$(command -v agent 2>/dev/null)"

    if [[ -z "$agent_path" ]]; then
        print -u2 "work: Cursor Agent CLI ('agent') is not installed or is not in PATH."
        print -u2 "Install it with: curl https://cursor.com/install -fsS | bash"
        return 127
    fi

    print "Cursor Agent CLI found: $agent_path"

    if (( $# != 1 )); then
        print -u2 "Usage: work <issue>"
        print -u2 "Example: work 1234"
        return 64
    fi

    if [[ "$1" == <-> ]]; then
        issue_number="$1"
    elif [[ "${1:u}" == TMU-<-> ]]; then
        issue_number="${1#*-}"
    else
        print -u2 "work: invalid issue '$1'; expected 1234, TMU-1234, or tmu-1234."
        return 64
    fi

    issue_key="TMU-$issue_number"
    print "Issue: $issue_key"
}
