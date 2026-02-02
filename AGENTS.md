# AGENTS.md

This repository is a Neovim configuration (mostly Lua). Use this guide when making changes.

## Repository Overview
- Primary language: Lua (Neovim config)
- Entry points: `init.lua`, `lua/` modules, plugin configs in `lua/eb/plugins/`
- Node metadata: `package.json` exists but has empty scripts; no JS tooling configured

## Build / Lint / Test Commands
There are no explicit build, lint, or test commands configured in this repo.

Recommended manual checks after changes:
- Open Neovim and ensure startup succeeds (no errors on launch)
- `:checkhealth` for environment sanity
- `:messages` to inspect any runtime errors

If you add tooling, document it here and prefer commands that can target a single file/module.
Example for single-file Lua formatting (only if you add stylua):
- `stylua lua/eb/plugins/mini.lua`

## Cursor / Copilot Rules
- No `.cursor/rules/` or `.cursorrules` found
- No `.github/copilot-instructions.md` found

## Code Style Guidelines

### Lua Formatting
- Indentation: 4 spaces, no tabs
- Line length: keep reasonable; wrap long tables/strings for readability
- Prefer trailing commas in multi-line tables
- Align table fields consistently where it improves readability

### Module Structure
- Plugins live in `lua/eb/plugins/` and typically `return` a table
- `config = function()` sections should require only what is needed for the module
- Keep Mini modules grouped and labeled with clear headings (see `lua/eb/plugins/mini.lua`)

### Naming Conventions
- Files: `kebab-case.lua` or descriptive folder paths under `lua/eb/`
- Functions: `snake_case`
- Local variables: `snake_case`
- Constants: `UPPER_SNAKE_CASE` only for true constants

### Imports / Requires
- Use `local x = require("module")` at the top of the config block
- Avoid global access; keep helpers in `eb.utils.*`
- Prefer small helper modules for reusable logic (statusline helpers, etc.)

### Tables and Options
- Use explicit keys in tables for clarity
- Prefer `true/false` over `1/0` for booleans
- Keep `setup({ ... })` arguments grouped and ordered by importance

### Error Handling and Safety
- Guard optional modules or feature checks with `pcall` if availability is uncertain
- Use `vim.notify` for user-facing warnings instead of silent failures
- Prefer early returns for invalid state (missing dirs, missing files)

### Neovim API Usage
- Prefer `vim.api.nvim_*` for buffer/window calls
- Use `vim.bo`, `vim.wo`, `vim.o` for buffer/window/global options respectively
- Avoid side effects at module top-level; keep them inside `config` or functions

### Keymaps
- Use helper functions (`keymap_silent`, etc.) where available
- Provide a `desc` whenever mapping is user-facing

### Plugin Configuration
- Keep plugin configs minimal and scoped
- Avoid heavy logic in config blocks; move complex logic to `eb.utils.*`
- Do not enable plugins in multiple files

### UI / Statusline Patterns
- Prefer clear, readable segments over dense icons
- Keep statusline components conditional for small window widths
- When coloring, define explicit highlight groups and reuse them

### Comments and Docs
- Add comments only when the code is non-obvious
- Use short, structured section headers for Mini modules
- Keep doc references in a single-line `SOURCE:` comment where helpful

## Suggested Workflows

### Making Small Changes
- Edit the module in `lua/eb/plugins/`
- Restart Neovim or reload the module
- Validate with `:messages`

### Adding a New Helper
- Create the helper in `lua/eb/utils/`
- Require it in the plugin file that uses it
- Keep helper interfaces small and explicit

### Statusline Work
- Centralize formatting helpers in `eb.utils.*`
- Avoid side effects in formatting functions
- Use buffer-local state (`vim.bo`) when formatting file info

## Notes for Agents
- This repo is user-configurable; avoid destructive changes
- Preserve existing visual style and conventions unless asked
- When you add new commands or tooling, update this file
