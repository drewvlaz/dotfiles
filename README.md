# dotfiles

Personal configs — zsh, tmux, neovim, wezterm, plus a pile of shell scripts.
Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick start (macOS)

```sh
git clone git@github.com:drewvlaz/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` is idempotent. It will:

1. Ensure Xcode Command Line Tools are present
2. Install Homebrew (if missing)
3. `brew bundle` the [Brewfile](./Brewfile)
4. Back up any colliding files in `$HOME`, then `stow` this repo into `$HOME`
5. Install [TPM](https://github.com/tmux-plugins/tpm) for tmux plugins
6. Set `zsh` as the default shell

After it finishes, open a new shell and inside tmux hit `prefix + I` to install
tmux plugins.

## Layout

```
.dotfiles/
├── .config/        # ~/.config/* (nvim, tmux, zsh, alacritty, …)
├── .scripts/       # ~/.scripts/* (on PATH; see .zshrc)
├── .zshrc .vimrc .wezterm.lua .bashrc
├── Brewfile
└── install.sh
```

Stow treats the repo as a single package and mirrors its tree into `$HOME`:

```sh
cd ~
stow --target="$HOME" --restow .dotfiles     # link / relink
stow --target="$HOME" --delete .dotfiles     # unlink
```

## Manual steps

Occasionally you'll want to:

- **Add a new config**: drop it in `.dotfiles/` mirroring its target path
  (e.g. `~/.config/foo/bar` → `.dotfiles/.config/foo/bar`), then
  `stow --target="$HOME" --restow .dotfiles`.
- **Ignore a file from stowing**: add a pattern to
  [`.stow-local-ignore`](./.stow-local-ignore).
- **Update packages**: edit [`Brewfile`](./Brewfile) and run
  `brew bundle --file=~/.dotfiles/Brewfile`. To clean up drift:
  `brew bundle cleanup --file=~/.dotfiles/Brewfile`.

## Notes

- `~/.secr` is sourced by `.zshrc` for machine-local secrets — keep it out of
  the repo.
- `.config/zsh/history` and `.config/tmux/plugins/*` are stow-ignored so they
  stay machine-local.
