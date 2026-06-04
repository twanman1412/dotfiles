---
name: using-django
description: Use when working with Django projects, modifying database models, applying migrations, squashing migrations, creating superusers, or needing to understand which manage.py commands to run and when to run them.
---

# Using Django

## Overview
Django provides a powerful management script (`manage.py`) to interact with your project. This skill defines **what** Django commands to use and **when** to use them.

**REQUIRED BACKGROUND:** You MUST use this skill in parallel with environmental skills like `using-poetry`. `using-poetry` dictates **how** to execute the command (e.g., `poetry run python manage.py`), while this skill dictates **which** manage script commands to run.

## When to Use

- When adding, modifying, or deleting fields on a Django `models.Model`
- When you need to sync the database schema with your codebase
- When cleaning up a messy migration history
- When generating administrative users
- When interacting with the Django ORM shell
- When you see errors like "no such table" or "column does not exist"

## Quick Reference: Core Commands

| Scenario | Command | What it does |
|---|---|---|
| Changed a model | `makemigrations [app_name]` | Detects model changes and generates a new migration file. **Always run this after editing models.** |
| Need to update DB | `migrate [app_name]` | Applies pending migrations to the database. **Always run this after makemigrations or pulling code.** |
| Check for missing migrations | `makemigrations --check --dry-run` | Fails if changes were made to models but migrations weren't generated. Good for CI/CD or sanity checks. |
| View applied migrations | `showmigrations [app_name]` | Lists all migrations and marks `[X]` next to applied ones. |
| Too many migrations | `squashmigrations <app_name> <migration_name>` | Compresses multiple migrations into a single file to optimize loading. |
| Need a REPL / ORM access | `shell` | Opens the interactive Python shell loaded with Django's environment. |
| Need admin access | `createsuperuser` | Prompts to create a user with full admin privileges. |
| Check for issues | `check` | Inspects the entire Django project for common problems. |

## Core Pattern: The Migration Lifecycle

Whenever you modify a `models.py` file, follow this exact sequence:

1. **Modify the Model:** Edit the Python code.
2. **Generate Migration:** Run `makemigrations` to create the Python instructions for the database.
3. **Review Migration (Optional but recommended):** Inspect the newly created `000X_...py` file to ensure Django understood your intent (especially for field renames, which prompt for confirmation).
4. **Apply Migration:** Run `migrate` to execute the instructions against the database.

## Implementation Examples

*Note: The examples assume a standard environment. If using Poetry, prefix the `python` command according to `using-poetry` (e.g., `poetry run python manage.py ...`).*

**Adding a new field:**
```bash
# 1. You edit blog/models.py to add `published_date`
# 2. Generate the migration specifically for the blog app
python manage.py makemigrations blog

# 3. Apply it to the database
python manage.py migrate blog
```

**Squashing Migrations:**
Use squashing when an app has dozens of migrations that slow down test databases or clutter the repository.
```bash
# Squash migrations from 0001 to 0045 in the users app
python manage.py squashmigrations users 0045

# Process:
# 1. Run the command above.
# 2. Commit both the new squashed file and all old migration files.
# 3. Once deployed to all environments (so the DB knows about the squashed file), delete the old individual migration files and remove the `replaces` attribute from the squashed file.
```

## Common Mistakes

- **Running `migrate` without `makemigrations`:** `migrate` only runs *existing* migration files. It won't detect new model changes automatically.
- **Editing migration files directly to fix DB errors:** Don't manually alter migration files unless you fully understand Django's migration graph. If a migration is wrong, and hasn't been pushed/applied, delete the file and re-run `makemigrations`.
- **Forgetting app labels:** While `makemigrations` without arguments checks all apps, passing the `app_name` (e.g., `makemigrations users`) is safer and isolates changes.

## Red Flags - STOP and Check

- **"I changed the model, but the database doesn't have the column."** -> You forgot to run `makemigrations` and `migrate`.
- **"The migration file has a conflict."** -> You and another developer created a migration at the same time. Run `python manage.py makemigrations --merge` to resolve it.
- **Applying raw SQL instead of migrations:** Always use Django's migration system to modify the database schema so state is tracked.
