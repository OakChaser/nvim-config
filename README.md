# Neovim Configuration

## ⚡ Requirements

- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
- [Tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md)
- Nodejs
- Python
- [Yazi](https://github.com/sxyazi/yazi/releases)
- [ripgrep](https://github.com/BurntSushi/ripgrep/releases)
- [lazygit](https://github.com/jesseduffield/lazygit/releases)
- [bottom](https://github.com/ClementTsang/bottom/releases)
- [go DiskUsage()](https://github.com/dundee/gdu/releases)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Or, you can delete them

``` shell
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

#### Clone the repository

```shell
git clone https://github.com/Broken-Deer/nvim-config ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```

## After Installation

- Run `:checkhealth`
