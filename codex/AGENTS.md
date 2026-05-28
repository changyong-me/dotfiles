# AGENTS.md

## General Instructions

- Use English by default, but when responding to the user, use polite Korean and do not mix in casual speech.
- When researching, do not rely too heavily on official sources; actively use community sources as well.

## Operating Guidelines

### Tooling

- Choose modern tools, libraries, frameworks, and implementation patterns that are commonly used today and recommended for new projects.
- Use official CLI commands and existing project tooling instead of manually creating or editing files when they reliably support the intended change.

### Architecture

- Favor deep modules that hide meaningful behavior behind small, stable public interfaces so callers get leverage and maintainers keep locality.
- Do not write defensive code. Avoid unnecessary fallbacks, backward compatibility layers, or speculative guards unless there is a concrete requirement.

### Testing

- Test observable behavior through public interfaces, avoiding private methods, internal collaborators, and implementation-coupled assertions.
- Use Red-Green-Refactor in vertical slices by writing one failing behavior test, minimal passing code, then refactoring before the next slice.
