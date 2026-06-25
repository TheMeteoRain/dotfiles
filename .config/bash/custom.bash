# ~/.config/bash/custom.bash
# Tracked by yadm. Sourced from ~/.bashrc. Edit freely.

export EDITOR=nvim
export VISUAL=nvim

# Run `git` as `yadm` while inside the yadm config dir.
git() {
  if [ "$PWD" = "$HOME/.config/yadm" ]; then
    command yadm "$@"
  else
    command git "$@"
  fi
}
