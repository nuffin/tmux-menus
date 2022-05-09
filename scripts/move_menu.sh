#!/bin/sh
#  shellcheck disable=SC2154
#  Directives for shellcheck directly after bang path are global
#
#   Copyright (c) 2022: Jacob.Lundqvist@gmail.com
#   License: MIT
#
#   Part of https://github.com/jaclu/tmux-menus
#
#   Version: 0.0.3 2022-03-29
#
#   Moving current pane within same session or to other session.
#

#  shellcheck disable=SC2034
#  Directives for shellcheck directly after bang path are global


# shellcheck disable=SC1007
CURRENT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# shellcheck disable=SC1091
. "$CURRENT_DIR/utils.sh"


action="$1"
param_1="$2"
param_2="$3"



log_it "move_menu() w=[$menu_width] h=[$menu_height] [$action] [$param_1] [$param_2"


if [ -z "$action" ]; then
    error_msg "move_menu.sh was called without action param" 1
fi



#  It will be created with defaults if not present
read_config


if [ "$action" = "C" ]; then
    location_x="C"
    location_y="C"
elif [ "$action" = "R" ]; then
    location_x="R"
elif [ "$action" = "P" ]; then
    location_x="P"
    location_y="P"
elif [ "$action" = "W" ]; then
    location_x="W"
    location_y="W"
elif [ "$action" = "S" ]; then
    location_y="S"
elif [ "$action" = "coord" ]; then
    location_x="$param_1"
    location_y="$param_2"
fi

write_config
