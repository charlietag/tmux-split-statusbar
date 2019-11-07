# Tmux split status bar plugin

This is an plugin that split stats bar into 2 parts (lines)

  `window part` - First line

  `status-left / status-right` part - Second line

This plugin is compatible with Tmux plugin manager([TPM](https://github.com/tmux-plugins/tpm))

## Installation
### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Requirements: `tmux` version 2.9 (or higher), `bash`.

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'charlietag/tmux-split-statusbar'

Hit `prefix + I` to fetch the plugin and source it.

Status bar should be splited now

### Manual Installation

Clone the repo:

    $ git clone https://github.com/charlietag/tmux-split-statusbar.git ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/tmux-split-statusbar.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

Status bar should be splited now


## Examples

Status bar splited (on):<br/>
![split-statusbar-mode-on](/screenshots/split-statusbar-mode-on.png)

Status bar splited (off):<br/>
![split-statusbar-mode-off](/screenshots/split-statusbar-mode-off.png)



## Customization

Here are all available options with their default values:

```shell
@split-statusbar-mode 'on' # [ on | off]
@split-statusbar-bindkey '-n F11' # [ M-s | -n F11 ]
                                  # bindkey for toggle statusbar-mode
                                  # define yourself just like bind-key, default: M-s
```

Don't forget to reload tmux environment (`$ tmux source-file ~/.tmux.conf`)
after you do this.


# Usage


* Sample config in ~/.tmux.conf

  ```bash
  set -g @plugin 'charlietag/tmux-split-statusbar'
  set -g @split-statusbar-mode 'on' # [ on | off]
  set -g @split-statusbar-bindkey '-n F11' # [ M-s | -n F11 ] , this is for toggle statusbar-mode, define yourself just like bind-key

  ```

### License

[MIT license](https://opensource.org/licenses/MIT).
