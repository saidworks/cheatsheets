# Description

`uv` is a powerful tool designed to simplify project creation and management. It provides a set of commands to help you handle dependencies, create virtual environments, and clean up caches efficiently.

# Useful Commands

## Upgrade a Dependency in Virtual Environment:
To upgrade a specific dependency within your virtual environment, use the following command:
```bash
uv pip install --upgrade dependency_name
```

## Start a New Virtual Environment:
Creating a new virtual environment is straightforward with `uv`. Simply run:
```bash
uv python -m venv venv_name
```
Replace `venv_name` with your desired name for the virtual environment.

## Clean Cache:
To clean up the cache, you can use the following command:
```bash
uv cache clean
```

# Usage Examples

### Upgrading a Dependency
If you need to upgrade a specific package in your project's virtual environment, simply run:
```bash
uv pip install --upgrade requests
```

### Creating a New Virtual Environment
To set up a new virtual environment for your project, execute:
```bash
uv python -m venv my_project_env
```
This command will create a virtual environment named `my_project_env` in the current directory.

### Cleaning the Cache
Regularly cleaning your cache can help maintain optimal performance. Use this command to clean up:
```bash
uv cache clean
```

By following these commands, you can easily manage your project's dependencies and keep your development environment clean.