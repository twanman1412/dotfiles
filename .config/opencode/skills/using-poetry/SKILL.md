---
name: using-poetry
description: Use when working in Python projects, installing Python dependencies, running Python scripts, or managing virtual environments.
---

# Using Poetry

## Overview
This project strictly uses `poetry` for all Python dependency management and execution. You must use poetry instead of raw pip, venv, or python commands.

## When to Use
- You need to install a Python package
- You need to run a Python script
- You need to run a Python tool (pytest, black, ruff)
- You need to create or manage a virtual environment

## Core Rules

**NEVER use these commands:**
- `pip install <package>`
- `python -m venv <dir>`
- `python <script.py>`
- `source .venv/bin/activate`
- `poetry shell` (Interactive shells hang agents)

**ALWAYS use these instead:**
- `poetry add <package>` (or `poetry install` for existing projects)
- `poetry run python <script.py>`
- `poetry run <tool>`

## Common Situations

### Existing requirements.txt
If you see a `requirements.txt` but no `pyproject.toml`, do NOT fall back to pip.
Instead, initialize poetry:
```bash
poetry init -n
cat requirements.txt | xargs poetry add
```

### Running Tests or Tools
```bash
# ❌ BAD
pytest tests/
python -m pytest tests/

# ✅ GOOD
poetry run pytest tests/
```

## Rationalization Table

Agents under pressure often find excuses to bypass poetry. Recognize and reject these rationalizations:

| Excuse | Reality |
|--------|---------|
| "I saw a `requirements.txt` so I used `pip install -r`." | Requirements.txt must be migrated to Poetry. Initialize poetry and add them. |
| "The project has no `pyproject.toml`." | Then run `poetry init -n` to create one. Poetry is mandatory. |
| "I'll use `poetry shell` to run things normally." | `poetry shell` launches an interactive shell that hangs agents. ALWAYS use `poetry run`. |
| "I just need to run one quick script." | Consistency matters. Use `poetry run python script.py`. |

## Red Flags - STOP and Start Over

- "I saw a `requirements.txt` so I used `pip install -r`."
- "I'll just use `python script.py` since the environment is already activated."
- "I'll create a quick `.venv` to run this one script."
- "I'm running `poetry shell` to make subsequent commands easier."

**All of these mean: Stop. Delete the virtual environment if you created one manually. Kill the interactive shell if you launched one. Use `poetry run` instead.**
