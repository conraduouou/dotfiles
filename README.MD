
# Introduction

A few answers to common issues when using this dotfile configuration:
- When using vim on macOS, rename `vimfiles` to `.vim`
- When using PowerShell, especially for Windows machines, put the `profile.ps1` file in your ~/Documents/PowerShell directory
- The `nvim` directory should be under '.config' in your home directory on macOS. 
- The `.tmux.conf` file should be found in your home directory.
- The `_vimrc` file likewise should be renamed to `.vim` when used on macOS, both found in your home directory.

## For Vim

The following must be installed for your dotfiles to work:
1. *vim-plug*
For plugins
2. *Nodejs*
coc.nvim depends on this

## Chocolatey plugins

These are things I consider essential for my dev experience:
1. *bat*
Not as helpful as I thought it would be since I usually preview files with vim but it does the job at times.
2. *eza*
I usually traverse directories with vifm but this is handy for viewing things quickly.
3. *fd*
You need to be able to find stuff.
4. *grep*
You need to be able to find stuff in files.
5. *ripgrep*
You need to be able to find stuff in files better.
6. *less*
Less is better than more.
7. *vifm*
What better way to traverse directories than by what you already know? Vim rules bro.
8. *vim*
The ultimate barebones text editor to be IDE.
9. *zoxide*
The jump to anywhere is just truly magnificent.
10. *git*
Mainly because I want it to be ready immediately, which chocolatey helps a lot in.
11. *Nodejs*
The above reason.
