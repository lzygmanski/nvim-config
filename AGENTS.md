# Repository Guidelines

## Project Structure & Module Organization
This repository is a personal Neovim configuration written in Lua. `init.lua` is the entry point and wires together core settings and plugin specs. Core editor behavior lives in `lua/core/` (`basic.lua`, `lazy.lua`, `diagnostic.lua`). Plugin configuration is split into focused files under `lua/setup/`, with one module per plugin or feature, for example `lua/setup/telescope.lua` or `lua/setup/nvim-lspconfig.lua`. Dependency versions are pinned in `lazy-lock.json`; update that file whenever plugin versions change.

## Build, Test, and Development Commands
- `nvim` — start Neovim with this config.
- `nvim --headless '+Lazy! sync' +qa` — install or update plugins from `lazy.nvim`.
- `nvim --headless '+checkhealth' +qa` — run Neovim health checks after changing tooling or plugins.
- `stylua init.lua lua` — format Lua sources using the repo style.
- `luacheck init.lua lua` — lint Lua files using `.luacheckrc`.

## Coding Style & Naming Conventions
Use spaces, not tabs, and follow the repo formatter: 2-space indentation, Unix line endings, single quotes when possible, and no forced call parentheses, as defined in `.stylua.toml`. Keep editor options in `lua/core/` and plugin-specific logic in `lua/setup/`. Name setup files after the plugin or feature they configure (`nvim-cmp.lua`, `todo-comments.lua`). Prefer small, single-purpose modules over large combined configs.

## Testing Guidelines
There is no dedicated test suite yet. Validate changes by running `stylua` and `luacheck`, then launch Neovim or use `nvim --headless '+checkhealth' +qa`. For plugin changes, confirm the related command or keymap still works interactively. Keep manual verification notes in the PR when behavior changes are user-facing.

## Commit & Pull Request Guidelines
Recent history uses short Conventional Commit-style subjects such as `feat: add dap` and `feat: format`; keep that pattern (`feat:`, `fix:`, `chore:`) with a brief imperative summary. Pull requests should include: a short description, the motivation for the change, impacted modules (for example `lua/setup/mason.lua`), and screenshots or terminal output when UI behavior changes.

## Configuration Tips
Avoid editing `lazy-lock.json` by hand. If you add tools managed by Mason, update the relevant lists in `lua/setup/mason.lua` and verify installation through `:checkhealth`.
