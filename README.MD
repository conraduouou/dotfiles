# Introduction

A few answers to common issues when using this dotfile configuration:
- The `.tmux.conf` file should be found in your home directory.
- The `.config/git/config` file uses `nvim` as the diff and merge tool by default. Change this to `vim` when on Windows.

***For Windows***
- Rename `.config/vim` to `vimfiles` (take it out of the `.config` directory) and put it in your home directory.
- Put `.config/vifm` in your home directory.
- Put the `profile.ps1` file in your ~/Documents/PowerShell directory
- The `vimrc` file is located by default in `.config/vim`. Rename it to `_vimrc` and put it in your home directory.
- The `bin` directory should be found in your home directory, containing `vifm.ps1` to run vifm using PowerShell.

***For macOS***
- Put the `.config` directory in your home directory.
- Put the `.zprofile`, `.zshenv`, `.zshrc` files in your home directory

## Philosophy

What I set out to do as an architecture for my dotfiles was a layer of concerns by intent. This of course is with help from AI, after
struggling to memorize and make sense of all of my keymaps. I then resorted to have the following principles as my guide:
- Modifier keys should be *universal* across keyboards, device-agnostic. That's why I opted to use alt/option instead of ctrl/cmd.
- I separate binds, remaps, and shortcuts logically by `navigation`, `tool`, and `prefix`.
- `Navigation` should be instant, hence all movement keymaps bypass prefixes or leader keys.
- `Tool`s should function via leader keys, hence why there are namespace leaders in vim, and the customizable leader key namespace for extensions and plugins.
- `Prefix` is technically a leader, but set aside for terminal multiplexers and special tools.
- I guess what sets apart `tool` and `prefix` namespaces are their layers; `tool` commands via the leader key namespace (space and a logical letter symbol for me) in the *editor*, and `prefix` via Alt-b for the multiplexer.

## For Vim

The following must be installed for your dotfiles to work:
1. *vim-plug*
For plugins
2. *Nodejs*
coc.nvim depends on this

## Plugins

These are things I consider essential for my dev experience:
1. *tmux* (psmux for Windows)
Because duh
2. *fzf*
This is basically ctrl P from VS Code and IT IS GOOD.
3. *bat*
Not as helpful as I thought it would be since I usually preview files with vim but it does the job at times.
4. *eza*
I usually traverse directories with vifm but this is handy for viewing things quickly.
5. *fd*
You need to be able to find stuff.
6. *grep*
You need to be able to find stuff in files.
7. *ripgrep*
You need to be able to find stuff in files better.
8. *less*
Less is better than more.
9. *vifm*
What better way to traverse directories than by what you already know? Vim rules bro.
10. *vim*
The ultimate barebones text editor to be IDE.
11. *zoxide*
The jump to anywhere is just truly magnificent.
12. *git*
Mainly because I want it to be ready immediately, which chocolatey helps a lot in.
13. *Nodejs*
The above reason.
