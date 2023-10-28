#!/bin/bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"

main() {
  local split_statusbar_mode="$(tmux show-option -gqv "@split-statusbar-mode")"
  local split_statusbar_mode_setto="$(tmux show-option -gqv "@split-statusbar-mode-setto")"
  local hide_statusbar_mode_setto="$(tmux show-option -gqv "@hide-statusbar-mode-setto")"
  local split_statusbar_swap_lines="$(tmux show-option -gqv "@split-statusbar-swap-lines")"
  local toggle_flag="$1"

  if [[ "${toggle_flag}" = "reload" ]];then
    split_statusbar_off
    tmux set -g status-format[6] ""
  fi

  split_bind_key
  set_default_status_format



  if [[ "${toggle_flag}" = "toggle" ]];then
    split_statusbar_toggle
  elif [[ "${toggle_flag}" = "hide" ]];then
    hide_status_toggle
  else

    #---------------- split status bar ----------------------
    if [[ "${split_statusbar_mode_setto}" = "on" ]];then
      split_statusbar_on
      tmux set -g @split-statusbar-mode-setto "on"
    elif [[ "${split_statusbar_mode_setto}" = "off" ]];then
      split_statusbar_off
      tmux set -g @split-statusbar-mode-setto "off"
    else
      if [[ "${split_statusbar_mode}" = "on" ]];then
        split_statusbar_on
        tmux set -g @split-statusbar-mode-setto "on"
      else
        split_statusbar_off
        tmux set -g @split-statusbar-mode-setto "off"
      fi
    fi

    #---------------- Hide status bar ----------------------
    if [[ "${hide_statusbar_mode_setto}" = "on" ]];then
      hide_status_on
      tmux set -g @hide-statusbar-mode-setto "on"
    else
      hide_status_off
      tmux set -g @hide-statusbar-mode-setto "off"
    fi

  fi

}

main "$1"
