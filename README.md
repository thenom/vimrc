# My Vim Configuration (Dotfiles)

This repository contains my personal Vim (`.vimrc`) and CoC (`coc-settings.json`) configurations for Fedora. This setup aims to provide a modern, IDE-like experience in Vim, primarily powered by `coc.nvim` for Language Server Protocol (LSP) features, completion, and diagnostics.

-----

## Table of Contents

1.  [Overview](https://www.google.com/search?q=%231-overview)
2.  [Prerequisites](https://www.google.com/search?q=%232-prerequisites)
3.  [Setup Instructions](https://www.google.com/search?q=%233-setup-instructions)
      * [Clone the Repository](https://www.google.com/search?q=%23clone-the-repository)
      * [Install Vim-Plug](https://www.google.com/search?q=%23install-vim-plug)
      * [Link Configuration Files](https://www.google.com/search?q=%23link-configuration-files)
      * [Install Vim Plugins](https://www.google.com/search?q=%23install-vim-plugins)
      * [Install CoC Extensions](https://www.google.com/search?q=%23install-coc-extensions)
      * [Install Language Servers and Tools](https://www.google.com/search?q=%23install-language-servers-and-tools)
4.  [Configuration Details](https://www.google.com/search?q=%234-configuration-details)
      * [`vimrc` (Main Vim Configuration)](https://www.google.com/search?q=%23vimrc-main-vim-configuration)
      * [`coc-settings.json` (CoC Language Server Configuration)](https://www.google.com/search?q=%23coc-settingsjson-coc-language-server-configuration)
5.  [Usage & Keybindings](https://www.google.com/search?q=%235-usage--keybindings)
6.  [Troubleshooting](https://www.google.com/search?q=%236-troubleshooting)

-----

## 1\. Overview

This configuration provides:

  * **Hybrid Line Numbers:** (`set nu rnu`)
  * **Modern Autocompletion & Diagnostics:** Powered by `coc.nvim` (Language Server Protocol client) for various languages.
  * **File Tree Navigation:** NERDTree for project Browse.
  * **Git Integration:** `vim-fugitive` for Git commands within Vim.
  * **Status Line:** `lightline.vim` for a sleek and informative status bar.
  * **Folding & Commenting:** Convenient keybindings and plugins for code manipulation.
  * **Language-Specific Features:** Enhanced support for Python, Go, Terraform, Dockerfile, Rego, JSON, and YAML.
  * **Testing Integration:** `vim-test` for running tests from Vim.
  * **Code Formatting:** Auto-formatting and custom format commands (XML, JSON).
  * **Customizable Color Scheme:** Currently using 'gotham' with true color support.

-----

## 2\. Prerequisites

Before starting, ensure you have the following installed on your system:

  * **Vim 9.0+**: This configuration is tested with Vim 9.1.
      * To check your Vim version, open Vim and run `:version`.
  * **Node.js (LTS version recommended)**: `coc.nvim` relies on Node.js for its backend.
      * Download from [nodejs.org](https://nodejs.org/).
      * Verify installation: `node -v` and `npm -v`.
  * **Python 3**: For `coc-python` and general Python utilities.
      * Verify installation: `python3 --version`.
  * **Go (optional, but recommended for Go development)**:
      * Download from [go.dev](https://go.dev/dl/).
      * Verify installation: `go version`.
  * **`git`**: For cloning repositories and Vim-Plug.
  * **`curl` or `wget`**: For downloading `vim-plug`.
  * **`ctags`**: For Tagbar plugin.
      * On Debian/Ubuntu: `sudo apt install ctags`
      * On macOS (Homebrew): `brew install ctags`
  * **`jq`**: For JSON formatting command.
      * On Debian/Ubuntu: `sudo apt install jq`
      * On macOS (Homebrew): `brew install jq`

-----

## 3\. Setup Instructions

Follow these steps to get your Vim environment up and running:

### Clone the Repository

First, clone this repository to your home directory:

```bash
git clone https://github.com/thenom/vimrc.git ~/.vim_config
```

### Install Vim-Plug

Vim-Plug is the plugin manager used in this configuration. Run the following command in your terminal:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Link Configuration Files

Create symbolic links from your home directory's Vim configuration files to the ones in your cloned repository. This ensures Vim uses the version-controlled files.

```bash
ln -sfn ~/.vim_config/vimrc ~/.vimrc
mkdir -p ~/.vim/
ln -sfn ~/.vim_config/coc-settings.json ~/.vim/coc-settings.json
```

### Install Vim Plugins

Open Vim and run the `PlugInstall` command. This will download and install all the plugins listed in your `vimrc`.

```vim
:PlugInstall
```

You should see a status window showing the progress. Once complete, close the status window by pressing `q`.

### Install CoC Extensions

`coc.nvim` requires specific extensions for language support. After `:PlugInstall` is done, **stay in Vim** and run these commands:

```vim
:CocInstall coc-pyright coc-go coc-json coc-yaml coc-snippets
```

This will install the extensions providing LSP features for Python, Go, JSON, YAML, and general snippet functionality.

### Install Language Servers and Tools

Some language servers and tools need to be installed separately on your system.

  * **Python Language Server (`python-lsp-server[all]`), Black (formatter), Flake8 (linter):**
    These should be installed in your Python environment. It's recommended to install them into your global Python 3 environment or within any virtual environments you use.

    ```bash
    pip install "python-lsp-server[all]" black flake8
    ```

  * **Go Language Server (`gopls`):**
    `coc-go` should manage `gopls` automatically. If you encounter issues, ensure it's installed:

    ```bash
    go install golang.org/x/tools/gopls@latest
    ```

  * **Terraform Language Server (`terraform-ls`):**
    Ensure the official `hashicorp/terraform-ls` is installed and in your system's `PATH`.

    Use your distribution's package manager if `terraform-ls` is available. (Example for Fedora/RHEL):
    ```bash
    wget -O- https://rpm.releases.hashicorp.com/fedora/hashicorp.repo | sudo tee /etc/yum.repos.d/hashicorp.repo
    sudo dnf install terraform-ls
    ```
