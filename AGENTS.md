# AGENTS.md

## Project overview

This repository manages personal dotfiles for reproducing the user's macOS development environment and Windows gaming desktop setup with consistent bootstrap scripts.

## Architecture decisions

- `codex/config.toml` is copied, not linked, because codex rewrites it at runtime. The repo is the source of truth: edit it here and re-run bootstrap. Changes made directly to `~/.codex/config.toml` will be overwritten.
