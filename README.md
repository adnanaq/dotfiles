# 🏠 Dotfiles

A modern, productivity-focused development environment configuration optimized for Linux systems. This repository contains my personal dotfiles with configurations for shell environments, terminal multiplexer, text editor, and various development tools.

## 🚀 Features

### Shell Configuration

- **Zsh** with optimized startup time and performance monitoring
- **Bash** configuration as fallback
- **Starship** prompt with Gruvbox Dark theme
- Enhanced history management and smart completions

### Development Environment

- **Neovim** - Highly customized with modern plugins and AI assistance
- **Tmux** - Terminal multiplexer with session management and Tokyo Night theme
- **Multiple Language Servers** - Go, Lua, Docker, GraphQL, TailwindCSS, Bash
- **AI-Powered Coding** - Avante plugin with Anthropic API integration

### Productivity Tools

- **fzf** - Fuzzy finder for files and command history
- **zoxide** - Smart directory navigation
- **eza** - Modern replacement for `ls` with icons
- **batcat** - Syntax-highlighted `cat` replacement

## 📦 Included Tools & Languages

### Programming Languages & Runtimes

- **Node.js** (with NVM)
- **Go** programming language
- **Python** (with Conda/Anaconda)
- **Protocol Buffers** compiler

### Development Tools

- **Docker** with context awareness
- **Kafka** for stream processing
- **Git** with enhanced status display
- **Tmux** session persistence and restoration

### Shell Enhancements

- **Zinit** - Fast Zsh plugin manager
- **Zsh plugins**: syntax highlighting, autosuggestions, completions
- **fzf-tab** - Enhanced tab completion with fzf

## 🎨 Theming

- **Starship Prompt**: Gruvbox Dark color scheme with comprehensive info display
- **Tmux**: Tokyo Night theme with custom status bar
- **Terminal**: 256-color support with consistent theming

## ⚡ Performance Optimizations

- Zsh startup time monitoring and optimization
- Lazy loading of heavy tools (Conda, NVM)
- Efficient plugin management with Zinit
- Optimized PATH configurations

## 🛠️ Installation

1. **Clone the repository:**

   ```bash
   git clone <repository-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. **Backup existing configurations:**

   ```bash
   # Backup your existing dotfiles
   mv ~/.zshrc ~/.zshrc.backup
   mv ~/.bashrc ~/.bashrc.backup
   mv ~/.config ~/.config.backup
   ```

3. **Install and use GNU Stow:**

   ```bash
   # Install GNU Stow (if not already installed)
   sudo apt install stow  # Ubuntu/Debian
   # or
   sudo dnf install stow  # Fedora
   # or
   brew install stow      # macOS

   # Use stow to create symbolic links
   cd ~/dotfiles
   stow .
   ```

4. **Install required tools:**

   ```bash
   # Install Starship prompt
   curl -sS https://starship.rs/install.sh | sh

   # Install fzf
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install

   # Install zoxide
   curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
   ```

## 📁 Directory Structure

```
.
├── .bashrc                 # Bash shell configuration
├── .zshrc                  # Zsh shell configuration
├── .config/
│   ├── nvim/              # Neovim configuration
│   │   ├── init.lua       # Neovim entry point
│   │   ├── lua/           # Lua configuration modules
│   │   └── lsp/           # Language server configurations
│   ├── tmux/              # Tmux configuration
│   │   └── tmux.conf      # Tmux settings and key bindings
│   └── starship.toml      # Starship prompt configuration
└── README.md              # This file
```

## 🔧 Key Configurations

### Zsh Features

- **Startup time**: ~100ms optimized loading
- **History**: 10,000 commands with smart deduplication
- **Completions**: Case-insensitive with fuzzy matching
- **Plugins**: Syntax highlighting, autosuggestions, fzf integration

### Neovim Features

- **Plugin Manager**: Lazy.nvim for efficient plugin loading
- **LSP**: Multiple language servers with auto-completion
- **AI Assistance**: Avante plugin with Anthropic Claude integration
- **Modern UI**: Enhanced with telescope, which-key, and more

### Tmux Features

- **Prefix**: `Ctrl+a` (instead of default `Ctrl+b`)
- **Vi Mode**: Vi-style key bindings for copy mode
- **Session Management**: Persistent sessions with automatic restore
- **Smart Navigation**: Seamless pane switching with Neovim

## 🌟 Highlights

- **AI-Powered Development**: Integrated Claude API for coding assistance
- **Session Persistence**: Never lose your work with tmux session restoration
- **Smart Navigation**: Quick directory jumping with zoxide
- **Performance Monitoring**: Real-time startup time and command duration display
- **Modern Alternatives**: Using `eza`, `batcat`, and other modern CLI tools

## 🔑 Environment Variables

Make sure to set up your API keys:

```bash
export OPENAI_API_KEY="your-openai-key"
export ANTHROPIC_API_KEY="your-anthropic-key"
```

## 📝 Customization

Feel free to modify configurations to suit your needs:

- Edit `.zshrc` for shell customizations
- Modify `.config/starship.toml` for prompt appearance
- Update `.config/nvim/` for editor preferences
- Adjust `.config/tmux/tmux.conf` for terminal multiplexer settings

## 🤝 Contributing

This is a personal dotfiles repository, but feel free to:

- Fork and adapt for your own use
- Submit issues for bugs or suggestions
- Share improvements via pull requests

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

_Happy coding! 🚀_
