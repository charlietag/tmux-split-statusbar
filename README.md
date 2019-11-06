# Tmux split status bar plugin

* This is an plugin that split stats bar into 2 parts
  * window part - First line
  * status-left / status-right part - Second line
* This plugin is compatible with Tmux plugin manager([TPM](https://github.com/tmux-plugins/tpm))

# Usage
## Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'charlietag/tmux-split-statusbar'

Hit `prefix + I` to fetch the plugin and source it.

CPU model will appear in `status-left` or `status-right`, after the following config.

* Sample config in ~/.tmux.conf

  ```bash
  # For installing plugin - tmux-cpu-model
  set -g @plugin 'charlietag/tmux-cpu-model'

  # Automatically **append** cpu model into "status-left" or "status-right"
  set -g @cpu-model-mode 'right' # [ left | right | none ]
  set -g @cpu-model-colour 'fg=colour232,bg=colour2,bold'
  ```
