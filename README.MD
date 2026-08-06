# Installation

Scripts have been created for cross-platform support! Mainly `install.sh` for macOS and `install.ps1`
for Windows!

They also have their own uninstallers if ever you want to start from scratch. Note that they do **not**
uninstall packages installed from either Homebrew or Chocolatey.

And yes, Chocolateyfile is not standard. It's just to mirror the macOS installation.

If instead you like to be manual, the following are steps where each component should be located.


## Maintaining vim

Should the time come when nvim becomes staple across all devices and machines that I will ever use,
then I will stop maintaining vim altogether. I started tracking my vim files because I thought Azure
VMs wouldn't be able to support nvim, as well as Windows. Turns out nvim was available to Windows
way, way, *waaaay* back, and that I should start reading documentations.


## MUST KNOW!

The `vifm` plugin from Chocolatey is currently `v0.11` at time of writing. It must be at least `v0.14`
to be able to use highlight groups. To deal with this, install the `vifm` binaries and put it in your
home directory under `Tools/vifm`

There is also an issue with `vim-navigator-tmux` with its usage of `shellcmdflag`, which I have
raised a PR for. Until the time it gets addressed, install my fork instead of the original's to make
`vim` work with `psmux`.


## Manual Installation

***Common***
- The `tmux.conf`, renamed to `.tmux.conf`, should be found in your home directory.
- Take out `git` from the `config` directory and put it in your home directory's `.config`.

***For Windows***
- Take out `vim` from the `config` directory and rename it to `vimfiles`. Then, put it in your home directory.
- Take out `nvim` from the `config` directory and put it in `~\AppData\Local`.
- Take out `vifm` from the `config` directory and put it in `~\AppData\Roaming`.
- Take out `powershell` from the `config` directory and put it in your home directory's `.config`.
- Put the `profile.ps1` file in your ~/Documents/PowerShell directory
- Take out `open-file.cmd` from the `bin` directory and put it in your home directory's `.local\bin`.

***For macOS***
- Rename the `config` to `.config` directory in your home directory.
- Put the `zprofile`, `zshenv`, `zshrc` files in your home directory, all prefixed by `.`
- Take out `open-file` from the `bin` directory and put it in your home directory's `.local\bin`.


## Philosophy

What I set out to do as an architecture for my dotfiles was a layer of concerns by intent. This of 
course is with help from AI, after struggling to memorize and make sense of all of my keymaps. I 
then resorted to have the following principles as my guide:
- Modifier keys should be *universal as much as possible* across keyboards, device-agnostic. This is
  why I have `config.txt` for `ililim/dual-key-remap` on Windows and `karabiner` on macOS.
- I separate binds, remaps, and shortcuts logically by `navigation`, `tool`, and `prefix`.
- `Navigation` should be instant, hence all movement keymaps bypass prefixes or leader keys. This is
  also the reason why I spent time making `vim-tmux-navigator` work with nvim and vim, as well as my
  alt overhaul to make tiling managers work.
- `Tool`s should function via leader keys, hence why there are namespace leaders in nvim, and the
  customizable leader key namespace for extensions and plugins.
- `Prefix` is technically a leader, but set aside for terminal multiplexers and special tools.
- I guess what sets apart `tool` and `prefix` namespaces are their layers; `tool` commands via the
  leader key namespace (space and a logical letter symbol for me) in the *editor*, and `prefix` via
  Alt-b for the multiplexer.


## For Vim dotfiles

The following must be installed for the dotfiles to work:
1. *vim-plug*
For plugins. I have included the autoload/plug.vim file for this reason.
2. *Nodejs*
coc.nvim depends on this


## Terminal Plugins

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
11. *neovim*
A fork of the ultimate barebones text editor to be IDE--and it does a great heck of a job at it.
12. *zoxide*
The jump to anywhere is just truly magnificent.
13. *git*
Mainly because I want it to be ready immediately, which chocolatey helps a lot in.
14. *Nodejs*
The above reason.


## Device Plugins

For ensuring ergonomic workflow, reducing strain on my left pinky for holding ctrl all day, I resorted
to use `ililim/dual-key-remap` to remap my caps lock and Copilot keys to ctrl.

I had initially resorted to mapping almost ctrl mapping in nvim and vim to alt. This was because kitty
did not do well with command mappings, which I was expecting to be the default with mac nvim and vim.
I have to live with only one control key on macOS though, which sucks when I get used to the ctrl b
prefix that I could do with the Copilot key.

I think reverting back to ctrl this way would make me conflict-free with tiling managers.

***For Windows***
1. `ililim/dual-key-remap`
Does one job and does it well.

***For macOS***
1. `pqrs-org/Karabiner-Elements`
Powerful. I only use it for remaps though :p
