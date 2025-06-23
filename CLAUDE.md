# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive dotfiles repository containing configurations for Zsh, Neovim, Tmux, and development tools. Uses GNU Stow for symlink management and focuses on performance optimization and AI-assisted development.

## Key Architecture

### Neovim Configuration Structure
- **Entry Point**: `.config/nvim/init.lua` → loads `lazy_setup` and `core` modules
- **Plugin Manager**: Lazy.nvim with modular plugin configs in `lua/plugins/`
- **LSP Configs**: Individual server configs in `lsp/` directory
- **Core**: Options, keymaps, autocmds in `lua/core/`

### Integration Architecture
- **Shell → Tmux → Neovim**: Seamless navigation with vim-tmux-navigator
- **Plugin Systems**: Lazy.nvim (Neovim), TPM (Tmux), Zinit (Zsh)
- **AI Integration**: Avante plugin with Claude/OpenAI API support

## Essential Commands

### Installation & Setup
```bash
# Primary installation method
cd ~/dotfiles && stow .

# Reload configurations
tmux source-file ~/.config/tmux/tmux.conf
# Or use bound key: <prefix> + r
```

### Neovim Plugin Management (Lazy.nvim)
```bash
:Lazy               # Open plugin manager
:Lazy update        # Update all plugins
:Lazy clean         # Remove unused plugins
:Lazy install       # Install missing plugins
```

### Development Tools (Mason)
```bash
:Mason              # Open Mason interface
:MasonInstall <tool>  # Install specific LSP/formatter/linter
:MasonUpdate        # Update all tools
```

### Tmux Plugin Management (TPM)
```bash
# Prefix key: Ctrl+a
<prefix> + I        # Install plugins
<prefix> + U        # Update plugins
<prefix> + alt + u  # Uninstall plugins
```

### Code Formatting & Development
```bash
# Neovim keybindings (leader: <Space>)
<leader>lp          # Format current file/selection
<leader>lP          # Format entire project
:FormatDirectory    # Format project-wide

# Testing with Neotest
<leader>tn          # Run nearest test
<leader>tf          # Run file tests
<leader>ta          # Run all tests

# DAP Debugging
<leader>db          # Toggle breakpoint
<leader>dc          # Continue debugging
<leader>di          # Step into
<leader>do          # Step over
```

### File Navigation & Search
```bash
# Telescope (leader: <Space>)
<leader>ff          # Find files
<leader>fc          # Live grep
<leader>fb          # Find buffers
<leader>fr          # Recent files

# Oil file manager
-                   # Open file explorer
<leader>-           # Open Oil in float
```

## Language Support & Tools

### Auto-installed via mason-tool-installer
- **Linters**: eslint_d, golangci-lint, ruff
- **Formatters**: black, prettier, stylua, gofumpt, goimports-reviser
- **Debug Adapters**: delve, go-debug-adapter, java-debug-adapter

### LSP Servers Configured
Go (gopls), Python (basedpyright), TypeScript (ts_ls, vtsls), HTML, TailwindCSS, Lua, Bash, Docker, GraphQL, YAML

## Performance & Workflow Features

### Session Management
- **Tmux**: Automatic session persistence with tmux-resurrect + tmux-continuum
- **Neovim**: Workspace restoration with auto-session plugin
- **Session Keys**: `<leader>wr` (restore), `<leader>ws` (save)

### Shell Enhancements (Zsh)
- **Smart Navigation**: `cd <query>` uses zoxide for intelligent directory jumping
- **Modern Commands**: `ls` → eza, `cat` → batcat
- **Fuzzy Finding**: `Ctrl+R` (history), `Ctrl+T` (files) via fzf

### AI Development Integration
- **Avante Plugin**: Claude/OpenAI integration for AI-assisted coding
- **API Keys**: Set `ANTHROPIC_API_KEY` and/or `OPENAI_API_KEY` environment variables

## Development Patterns

### Key Binding Organization
- `<leader>f` → Telescope (find/search)
- `<leader>s` → Window management
- `<leader>d` → DAP debugging
- `<leader>l` → Language/formatting
- `<leader>w` → Session management
- `<leader>x` → Trouble diagnostics

### Configuration Reload Workflow
1. Edit dotfiles
2. Run `stow .` to update symlinks (if needed)
3. Reload specific configs:
   - Neovim: `:source $MYVIMRC` or restart
   - Tmux: `<prefix> + r` or restart session
   - Zsh: `source ~/.zshrc` or new shell