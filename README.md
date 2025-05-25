# 🛠️ .dotfiles

A curated collection of configuration files for a consistent, productive development environment across multiple machines.

> **Primary Target**: macOS (should work with GNU/Linux as well with some changes.)

## ✨ What You'll Get

This configuration transforms your terminal into a powerful, efficient workspace with carefully selected tools and optimizations. Inspired by [dreamsofcode-io/dotfiles](https://github.com/dreamsofcode-io/dotfiles) but customized for modern development workflows.

### 🎯 Core Tools

| Tool | Purpose | Why It's Great |
|------|---------|----------------|
| **[Helix](https://helix-editor.com/)** | Code/text editor | Modern, modal editor with built-in LSP support |
| **[Yazi](https://yazi-rs.github.io/)** | Terminal file manager | Lightning-fast file navigation with preview |
| **[Lazygit](https://github.com/jesseduffield/lazygit)** | Git UI | Beautiful terminal Git interface |
| **[Scooter](https://github.com/thomasschafer/scooter)** | Find & replace | Blazing fast search and replace tool |
| **[Mise](https://mise.jdx.dev/)** | Version manager | Universal tool version management |
| **[Ghostty](https://ghostty.org/)** | Terminal emulator | GPU-accelerated, feature-rich terminal |
| **[Fzf](https://github.com/junegunn/fzf)** | Fuzzy finder | Powerful command-line fuzzy finder |
| **[Zoxide](https://github.com/ajeetdsouza/zoxide)** | Smart cd | Jump to directories intelligently |
| **[Fastfetch](https://github.com/fastfetch-cli/fastfetch)** | System info | Beautiful system information display |

### 🎨 Shell Customization

- **Theme**: [Typewritten](https://github.com/reobin/typewritten) - Clean, minimal prompt
- **Plugin Manager**: [Zinit](https://github.com/zdharma-continuum/zinit) - Fast, lightweight alternative to oh-my-zsh
- **Enhanced Features**: Auto-completion, syntax highlighting, intelligent history

## 🚀 Quick Start

### Prerequisites

- **macOS**: Comes with `zsh` pre-installed
- **Homebrew**: Install from [brew.sh](https://brew.sh/)
- **Git**: Should be available on most systems. If not, use `brew`

### Installation

#### 1. Clone Repository in your $HOME
```bash
cd ~ && git clone https://github.com/shetty-tejas/.dotfiles.git
```

#### 2. Backup Existing Configs

**⚠️ Important**: Backup or remove these files/directories from your `$HOME`:
- `.zshrc`
- `.hushlogin` 
- `.gitconfig`
- `.config`

```bash
# Backup existing configs (optional)
mkdir ~/dotfiles-backup
mv ~/.zshrc ~/.hushlogin ~/.gitconfig ~/.config ~/dotfiles-backup/ 2>/dev/null || true
```

#### 3. Install DevSetup

Install the custom dependency manager from [shetty-tejas/devsetup](https://github.com/shetty-tejas/devsetup):

```bash
curl -fsSL https://raw.githubusercontent.com/shetty-tejas/devsetup/main/install.sh | bash
```

This would be used to install and manage dependencies for various tools.

#### 4. Create Symlinks

```bash
brew install stow
cd ~/.dotfiles
stow .
```

Also check that symlinks were created correctly:

```bash
ls -al ~ | grep -E "\.(zshrc|gitconfig|hushlogin|config)"
```

You should see symlinks pointing to your `.dotfiles` directory.

#### 5. Install Dependencies

```bash
devsetup install mac_dependencies
```

This installs:
- **Development tools**: helix, lazygit, mise, fzf, etc.
- **System utilities**: ffmpeg, jq, ripgrep, fd, etc.  
- **Ruby dependencies**: readline, openssl, libyaml, etc.

#### 6. Activate Configuration

```bash
source ~/.zshrc
```

## ⚙️ Customization

### Update Git Configuration

The repository includes a `.gitconfig` file with placeholder information. Update it with your details:

```bash
# Edit the gitconfig file
hx ~/.dotfiles/.gitconfig

# Or use git commands after installation
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Modify Dependencies

Want to skip certain tools? Edit the dependency list before installation:

```bash
hx ~/.dotfiles/.config/devsetup.json
```

### Shell Customization

The `.zshrc` file includes several customizable sections:
- **Aliases**: Add your frequently used commands
- **Environment variables**: Customize paths and tool settings  
- **Key bindings**: Modify shortcuts (currently `Ctrl+k/j` for history)

## 🎯 Key Features

### Smart History
- 2500 command history with deduplication
- Shared across terminal sessions
- Ignore commands starting with space

### Enhanced Navigation  
- **Zoxide**: Jump to frequently used directories
- **Fzf integration**: Fuzzy find everything
- **Hidden file support**: See dotfiles in completions

### Development Optimizations
- **Ruby YJIT**: Enabled for better performance
- **Mise integration**: Automatic tool version switching
- **Helix as default editor**: Modern editing experience

### Visual Enhancements
- **Typewritten theme**: Clean, informative prompt
- **Syntax highlighting**: Color-coded commands
- **Fastfetch**: System info on terminal startup

## 🔧 Troubleshooting

### Common Issues

**Symlinks not created or added new files in .dotfiles**:
```bash
cd ~/.dotfiles && stow --restow .
```

**Zsh not default shell**:
```bash
chsh -s $(which zsh)
```

**Permissions issues**:
```bash
sudo chown -R $(whoami) ~/.local ~/.config
```

## 🤝 Contributing

Found an issue or have an improvement? Feel free to open an issue or submit a pull request!

## 📝 License

This configuration is provided as-is. Feel free to fork and customize for your needs.

---

*Happy coding! 🚀*
