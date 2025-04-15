# Neovim Configuration

[![Neovim Version](https://img.shields.io/badge/Neovim-0.9.5-green)](https://neovim.io/)
[![License](https://img.shields.io/github/license/ismailmajeeb/Neovim-Config)](LICENSE)

Modern Neovim configuration optimized for productivity and developer ergonomics, built with:
- **LazyVim** framework for plugin management
- **Lua**-based configuration
- Cross-platform support (Windows/Linux/macOS)

## Features

- 🚀 **Fast startup** with optimized plugin loading
- ✨ **Modern UI** enhancements:
  - Custom statusline
  - Smooth scrolling
- 🔍 **Intelligent autocompletion** via LSP and snippets
- 📦 **Preconfigured tools**:
  - LaTeX compilation (pdflatex/xelatex/lualatex)
  - Git integration
  - Terminal emulator
- 🔧 **Developer-friendly**:
  - Smart syntax highlighting
  - Code formatting
  - Debugging support

## Installation

1. **Backup existing config**:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. **Clone repository**:
   ```bash
   git clone https://github.com/ismailmajeeb/Neovim-Config ~/.config/nvim
   ```

3. **Install dependencies**:
   - [Neovim 0.9.5+](https://github.com/neovim/neovim/releases)
   - [LazyVim dependencies](https://www.lazyvim.org/installation)
   - TexLive (for LaTeX support)

4. **First launch**:
   ```bash
   nvim
   ```
   (Wait for plugins to auto-install)


## Performance

- Average startup time: **80ms** (measured with `:StartupTime`)
- Memory usage: ~50MB (varies with plugins)

## Credits

- Inspired by modern Neovim configurations
- Uses [LazyVim](https://github.com/LazyVim/LazyVim) framework
- Includes configurations from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
