#!/bin/sh

set -eu
# https://github.com/dcreager/dotfiles/blob/main/install
if [ -z "$USER" ]; then
    USER=$(id -un)
fi

echo >&2 "====================================================================="
echo >&2 " Setting up codespaces environment"
echo >&2 ""
echo >&2 " USER        $USER"
echo >&2 " HOME        $HOME"
echo >&2 "====================================================================="

# Make passwordless sudo work
export SUDO_ASKPASS=/bin/true

sudo chsh -s /usr/bin/fish $USER

echo >&2 "====================================================================="
echo >&2 " Installing required dependencies"
echo >&2 "====================================================================="
# Install ripgrep and fd-find for telescope
sudo apt-get update
sudo apt-get install -y ripgrep fd-find libfuse2

echo >&2 "====================================================================="
echo >&2 " Installing neovim"
echo >&2 "====================================================================="
# Install neovim
mkdir -p ~/.local
cd ~/.local
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
mkdir -p ~/.local/bin
ln -s ~/.local/squashfs-root/AppRun ~/.local/bin/nvim

echo >&2 "====================================================================="
echo >&2 " Installing and running chezmoi"
echo >&2 "====================================================================="
# Set up and run chezmoi (https://github.com/chezmoi/dotfiles/blob/master/install.sh)
if ! chezmoi="$(command -v chezmoi)"; then
  bin_dir="${HOME}/.local/bin"
  chezmoi="${bin_dir}/chezmoi"
  echo "Installing chezmoi to '${chezmoi}'" >&2
  if command -v curl >/dev/null; then
    chezmoi_install_script="$(curl -fsSL https://chezmoi.io/get)"
  elif command -v wget >/dev/null; then
    chezmoi_install_script="$(wget -qO- https://chezmoi.io/get)"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
  sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
  unset chezmoi_install_script bin_dir
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
"$chezmoi" "$@"
