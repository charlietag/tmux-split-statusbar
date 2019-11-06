split_bind_key() {
  local bind_key="$(tmux show-option -gqv "@split-statusbar-bindkey")"
  [[ -z "${bind_key}" ]] && bind_key="M-s"

  tmux unbind-key "${bind_key}"
  tmux bind-key "${bind_key}" run-shell '~/.tmux/plugins/tmux-split-statusbar/tmux-split-statusbar.tmux toggle'
}


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


# --- backup default setting ---
# status-format[6] - status_format_0_default
# status-format[7] - status_format_1_default
set_default_status_format() {
  local status_format_0_default="$(tmux show-option -gqv "status-format[6]")"
  local status_format_1_default="$(tmux show-option -gqv "status-format[7]")"

  if [[ -z "${status_format_0_default}" ]]; then
    status_format_0_default="$(tmux show-option -gqv "status-format[0]")"
    status_format_1_default="$(tmux show-option -gqv "status-format[1]")"
    tmux set -g status-format[6] "${status_format_0_default}"
    tmux set -g status-format[7] "${status_format_1_default}"
  fi
}
