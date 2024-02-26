<div align="center">
    <h1>Dotfiles</h1>
    <blockquote>
        <p>My Arch Linux dotfiles.</p>
    </blockquote>
</div>

## Installation

You can use [GNU Stow](https://www.gnu.org/software/stow/) to install the
dotfiles contained in this repository. Simply `cd` into your clone of this
repository and run the following command:

```
$ stow --target="$HOME" --no-folding .
```

By default, GNU Stow symlinks directories that don't exist in the target
directory, but with the `--no-folding` flag, GNU Stow will *create* those
directories in your home directory, and only symlink actual files.

## Details

#### Graphical environment

- Window manager: [hypeland](https://github.com/hyprwm/Hyprland)
- Compositor:
- Bar: 
- Notification daemon: 
- Program launcher: [Rofi](https://github.com/davatorium/rofi)
- Screen locker: 

#### Fonts

- Sans-serif font: [Noto Sans](https://www.google.com/get/noto/)
- Serif font: [Noto Serif](https://www.google.com/get/noto/)
- Monospace font: [Consolas](https://aur.archlinux.org/packages/consolas-font)
- Icon font for bar: [Font Awesome](https://fontawesome.com/)
- Shell font : [JetBrains Mono Nerds](https://archlinux.org/packages/extra/any/ttf-jetbrains-mono-nerd/)

#### Command-line

- Shell: [Zsh](https://github.com/zsh-users/zsh)
- Terminal emulator: [Kitty](https://github.com/kovidgoyal/kitty)

#### Development environment

- Primary code editor: [Neovim](https://github.com/neovim/neovim)

#### Miscellaneous

- Web browser: [Brave]([https://github.com/chromium/chromium](https://brave.com/linux/))
- File manager: [ranger](https://github.com/ranger/ranger)
- Document viewer: [zathura](https://github.com/pwmt/zathura)
- Video player: [mpv](https://github.com/mpv-player/mpv)
- Screenshot tool:

#### Theme

- GTK theme: 
- Cursor theme:
