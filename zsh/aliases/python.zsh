# Old pip version
# alias venv='python3 -m venv .venv; source .venv/bin/activate; python3 -m pip install --upgrade pip;'
# alias act='source .venv/bin/activate'
# alias dact='deactivate'
# alias pytest='python3 -m unittest'

# To use these aliases, install uv from https://docs.astral.sh/uv/getting-started/installation/
alias venv='uv venv .venv; source .venv/bin/activate; uv pip install --upgrade pip'
alias act='source .venv/bin/activate'
alias dact='deactivate'
# alias pytest='uv run pytest'
