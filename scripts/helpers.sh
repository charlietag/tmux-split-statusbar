# --------------------- bind key ---------------------
split_bind_key() {
  # unbind all tmux-split-statusbar related
  tmux list-keys |grep tmux-split-statusbar | awk '{print $2" "$3" "$4}' | xargs -i bash -c "tmux unbind-key {}"

  # Define bind key for status bar togle
  local bind_key="$(tmux show-option -gqv "@split-statusbar-bindkey")"
  [[ -z "${bind_key}" ]] && bind_key="M-s"
  tmux bind-key ${bind_key} run-shell '~/.tmux/plugins/tmux-split-statusbar/tmux-split-statusbar.tmux toggle'

  # Define bind key for status left right toggle
  local bind_key_hide="$(tmux show-option -gqv "@split-status-hide-bindkey")"
  [[ -z "${bind_key_hide}" ]] && bind_key_hide="M-d"
  tmux bind-key ${bind_key_hide} run-shell '~/.tmux/plugins/tmux-split-statusbar/tmux-split-statusbar.tmux hide'
}

# --------------------- Initialize ---------------------
# --- backup default setting ---
#  status-format[6]       -  status_format_0_default
#  status-format[7]       -  status_format_1_default
#  @status-left-default   -  status_left_default
#  @status-right-default  -  status_right_default
set_default_status_format() {
  local status_format_0_default="$(tmux show-option -gqv "status-format[6]")"
  #local status_format_1_default="$(tmux show-option -gqv "status-format[7]")"

  if [[ -z "${status_format_0_default}" ]]; then
    # --- status line ---
    local status_format_0_default="$(tmux show-option -gqv "status-format[0]")"
    local status_format_1_default="$(tmux show-option -gqv "status-format[1]")"
    tmux set -g status-format[6] "${status_format_0_default}"
    tmux set -g status-format[7] "${status_format_1_default}"

    # --- status left right ---
    local status_left_default="$(tmux show-option -gqv "status-left")"
    local status_right_default="$(tmux show-option -gqv "status-right")"
    tmux set -g @status-left-default "${status_left_default}"
    tmux set -g @status-right-default "${status_right_default}"
  fi
}

# --------------------- statusbar lines ---------------------
split_statusbar_on() {
  local status_format_0_default="$(tmux show-option -gqv "status-format[6]")"

  status_format_0_tobe="$(echo "${status_format_0_default}" | sed 's/:status-left//g' | sed 's/:status-right//g')"
  status_format_1_tobe="$(echo "${status_format_0_default}" | sed 's/:window-status-current-format//g' | sed 's/:window-status-format//g')"
  tmux set -g status-format[0] "${status_format_0_tobe}"
  tmux set -g status-format[1] "${status_format_1_tobe}"
  tmux set -g status 2
}

split_statusbar_off() {
  local status_format_0_default="$(tmux show-option -gqv "status-format[6]")"
  local status_format_1_default="$(tmux show-option -gqv "status-format[7]")"

  tmux set -g status-format[0] "${status_format_0_default}"
  tmux set -g status-format[1] "${status_format_1_default}"
  tmux set -g status on
}

split_statusbar_toggle() {
  local status_format_current="$(tmux show-option -gqv "status-format[0]")"
  local status_format_0_default="$(tmux show-option -gqv "status-format[6]")"
  if [[ "${status_format_current}" = "${status_format_0_default}" ]]; then
    split_statusbar_on
  else
    split_statusbar_off
  fi
}

# --------------------- hide status left right ---------------------
hide_status_on() {
  tmux set -g status-left "#[fg=colour232,bg=red,bold]#{?client_prefix, <PREFIX> ,}#[fg=colour232,bg=colour203,bold]#{?pane_in_mode, <COPY> ,}"
  tmux set -g status-right ""
}

hide_status_off() {
  local status_left_default="$(tmux show-option -gqv "@status-left-default")"
  local status_right_default="$(tmux show-option -gqv "@status-right-default")"
  tmux set -g status-left "${status_left_default}"
  tmux set -g status-right "${status_right_default}"
}

hide_status_toggle() {
  local status_left_current="$(tmux show-option -gqv "status-left")"
  local status_left_default="$(tmux show-option -gqv "@status-left-default")"
  if [[ "${status_left_current}" = "${status_left_default}" ]]; then
    hide_status_on
  else
    hide_status_off
  fi
}

