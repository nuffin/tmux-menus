#!/bin/sh
#
#   Copyright (c) 2022: Jacob.Lundqvist@gmail.com
#   License: MIT
#
#   Part of https://github.com/jaclu/tmux-menus
#
#   Version: 1.0.3  2022-05-10
#
#   Live configuration. So far only menu location is available
#

#  shellcheck disable=SC2034,SC2154
#  Directives for shellcheck directly after bang path are global

# shellcheck disable=SC1007
CURRENT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SCRIPT_DIR="$(dirname "$CURRENT_DIR")/scripts"

# shellcheck disable=SC1091
. "$SCRIPT_DIR/utils.sh"

menu_name="Configure Menu Location"
req_win_width=32
req_win_height=14


this_menu="$CURRENT_DIR/config.sh"
reload="; $this_menu"
change_location="run-shell '$SCRIPT_DIR/move_menu.sh"
open_menu="run-shell $CURRENT_DIR"

#
#  The -p sequence will get wrecked by lnie breaks,
#  so left as one annoyingly long line
#
set_coordinates="command-prompt \
    -I \"$location_x\",\"$location_y\" \
    -p \"horizontal pos (max: #{window_width}):\",\"vertical pos (max: #{window_height}):\" \
    \"$change_location coord %1 %2 $reload'\""


t_start="$(date +'%s')"  #  if the menu closed in < 1s assume it didnt fit

# shellcheck disable=SC2154
tmux display-menu \
    -T "#[align=centre] $menu_name "             \
    -x "$menu_location_x" -y "$menu_location_y"  \
    \
    "Back to Previous menu"  Left  "$open_menu/advanced.sh'"       \
    "" \
    "Center"                 c     "$change_location  C  $reload'"  \
    "Right edge of pane"     r     "$change_location  R  $reload'"  \
    "Pane bottom left"       p     "$change_location  P  $reload'"  \
    "Win pos status"         w     "$change_location  W  $reload'"  \
    "By status line"         l     "$change_location  S  $reload'"  \
    "" \
    "set coordinates"        s     "$set_coordinates"              \
    "" \
    "-When using coordinates"      "" ""                           \
    "-lower left corner is set!"   "" ""


ensure_menu_fits_on_screen
