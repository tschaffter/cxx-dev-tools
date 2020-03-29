# Developing with Git

## Git hooks

- .githooks/pre-commit - Validates `.circleci/config.yml` before acceptiing a
commit.

```
git config core.hooksPath .githooks
```