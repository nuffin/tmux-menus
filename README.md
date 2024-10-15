# Tmux-Menus

![main](https://github.com/user-attachments/assets/a9cd1d01-ede5-414c-a8cf-0c04f857f648)


Popup menus to help with managing your environment.

For tmux < 3.0 whiptail will be used, since the tmux feature
`display-menu` is not available.

Not too hard to adapt to fit your needs. Items that some
might find slightly redundant are included, easier to remove excess for more
experienced users, then add more for newbies.

<details>
<summary>Upcomming feature - styling</summary>
<br>


</details>
<details>
<summary>Recent Changes</summary>
<br>

- Menu Styling has arrived - Checkout branch `themeable`  to take a look
- Rewrote cache handling for better optimization
- Moved Toggle status line -> Advanced in order to shrink main menu
- Removed pointers to default key-bindings, instead using shortcuts that
makes sense from a tmux-menus perspective.
- Replaced Paste Buffers menu, to list all features and default bindings.
- If whiptail is needed, but not installed, hitting the trigger key will display:
`DEPENDENCY: tmux-menus needs whiptail`

</details>
<details>
<summary>Purpose</summary>
<br>

Tmux provides a few basic popup menus by default, but they're quite limited and
difficult to extend due to their complex, mouse-based one-liner implementations.
A more integrated, user-friendly approach with better navigation and flexibility
seemed like the right solution.

Not solely meant for beginners, I use it myself all the time:

- When connecting using terminals without much support for Meta or Ctrl,
this gives access to all the actions that aren't available with the
regular shortcuts. For instance, when running the built in Terminal on
MacOS the console keyboard is pretty limited.
- Tasks that would need external scripts to avoid hard-to-read
complex bind one-liners, such as killing the current session without getting
disconnected.
- When direct typing would be much longer.
Example: Kill the server directly with 12 keys:
`<prefix> : kill-ser <tab> <enter>`
with the menus 5 keys: `<prefix> \ A x y`
- Actions used to seldom to be remembered as shortcuts.

</details>
<details>
<summary>Usage</summary>
<br>

Once installed, hit the trigger to get the main menu to pop up.
The default is `<prefix> \` see Configuration below for how to change it.

</details>
<details>
<summary>Screenshots of some menus</summary>
<br>

The grey one is generated with whiptail, as can be seen whiptail menus use a lot more screen real estate, however if they dont fit they can be scrollable unlike the tmux menus. The rest are generated by the tmux built-in `display-menu`

![help](https://github.com/user-attachments/assets/bdcb1657-456c-4f4a-979f-72392e609d74)
![pane](https://github.com/user-attachments/assets/64f081a7-5b2d-475e-869d-1e2ab8c20924)
![missing_keys](https://github.com/user-attachments/assets/6000fca3-d5ef-4043-a37e-9e20a6c6d46c)
![sessions](https://github.com/user-attachments/assets/c1ae533d-cfc1-47e2-94f7-13912209e9f5)
![sessions-wt](https://github.com/user-attachments/assets/6f62f85d-ccb9-40ae-b4bb-a3e7f068f296)

</details>
<details>
<summary>Dependencies & Compatibility</summary>

## Dependencies

If tmux >= 3.0 is used, whiptail is not needed

### Linux

In most cases whiptail is installed by default on Linux distros. If not, install it using your package manager.
One gotcha is that in the Red Hat universe the package is not called whiptail, the package containing whiptail is called `newt`.

### MacOS

MacOS does not come with whiptail, but it is available in Homebrew

## Compatability

Version | Notice
-|-
3.2 | Fully compatible
3.0 - 3.1c | Menu centering is not supported, it's displayed top left if C is selected.
< 3.0 | Needs whiptail. Menu location setting ignored.
1.7 - 1.8  | tpm is not available, so the plugin needs to be initialized by running [path to tmux-menus]/menus.tmux directly from the conf file

The above table covers compatibility for the general tool. Some items
has a min tmux version set, if the running tmux doesn't match this,
that item will be skipped, if you find I set incorrect limits on some feature,
please let me know!

</details>
<details>
<summary>Installing</summary>

## Via TPM (recommended)

The easiest way to install `tmux-menus` is via the [Tmux Plugin
Manager](https://github.com/tmux-plugins/tpm).

1. Add plugin to the list of TPM plugins in `.tmux.conf`:

    ``` tmux
    set -g @plugin 'jaclu/tmux-menus'
    ```

2. Hit `<prefix> + I` to install the plugin and activate it. You should
    now be able to use the plugin.

## Manual Installation

1. Clone the repository

    ``` sh
    git clone https://github.com/jaclu/tmux-menus ~/clone/path
    ```

2. Add this line to the bottom of `.tmux.conf`

    ``` tmux
    run-shell ~/clone/path/menus.tmux
    ```

3. Reload the `tmux` environment

    ``` sh
    # type this inside tmux
    $ tmux source-file ~/.tmux.conf
    ```

You should now be able to use `tmux-menus` immediately.

</details>
<details>
<summary>Whiptail</summary>
<br>

These menus can also be displayed using Whiptail, be aware that in order
to run whiptail dialogs via a shortcut, the current (if any) task is
suspended, dialogs are run, and when done the suspended task is
reactivated.

The downside of this is that if no current tasks were running in
the active pane, you will see `fg: no current job` being printed when
the dialog is exited. This can be ignored.

The menu system works the same using Whiptail, however the menu
shortcuts are not as convenient, since Whiptail does not differentiate
between upper and lower case letters, and does not at all support
special keys like 'Left' or 'Home'

If tmux is < 3.0 whiptail will automatically be used.
If you want to use Whiptail on modern tmuxes set this env variable outside tmux, or in tmux conf: `export FORCE_WHIPTAIL_MENUS=1`

</details>
<details>
<summary>Configuration</summary>

## Changing the key bindings for this plugin

The default trigger is `<prefix> \` The trigger is configured like this:

```tmux
set -g @menus_trigger F12
```

Please note that non-standard keys, like the default backslash need to
be prefixed with an `\` in order not to confuse tmux.

If you want to trigger menus without first hitting `<prefix>`

```tmux
set -g @menus_without_prefix Yes
```

This param can be either Yes/true or No/false (the default)

### Menu location

The default locations are: `C` for tmux >= 3.2 `P` otherwise. If whiptail is used, menu location is ignored

```tmux
set -g @menus_location_x W
set -g @menus_location_y S
```

For all location options see the tmux man page, search for `display-menu`. The basic options are:

Value | Flag | Meaning
-|-|-
C | Both | The centre of the terminal (tmux 3.2 or newer)
R | -x   | The right side of the terminal
P | Both | The bottom left of the pane
M | Both | The mouse position
W | Both | The window position on the status line
S | -y   | The line above or below the status line

### Disable caching

By default menu items are cached, set this to `No` to disable all caching.

```tmux
set -g @menus_use_cache No
```

To be more precise, items listed inside `static_content()` are cached.
Some items need to be freshly generated each time a menu is displayed,
those items are defines in `dynamic_content()` see
[scripts/panes.sh](items/panes.sh) for an example of this. In that case,
the label changes between Zoom and Un-Zoom for the zooming action and
mark/unmark for current pane.

The plugin remmebers what tmux version you used last time.
If another version is detected as the plugin is initialized, the entire
cache is dropped, so that the right version dependant items can be
selected as the cache is re-populated.
Same if a menu script is changed, if the script is newer than the cache,
that cache item is regenerated.

### Pointer to the config file

```tmux
set -g @menus_config_file '~/.configs/tmux.conf'
```

In the main menu, you can request the config file to be reloaded.
The defaults for this are:

 1. @menus_config_file - if this is defined in the tmux config file, it will be used.
 2. $TMUX_CONF - if this is present in the environment, it will be used.
 3. $XDG_CONFIG_HOME/tmux/tmux.conf - if $XDG_CONFIG_HOME is defined.
 4. ~/.tmux.conf - Default if none of the above are set.

When a reload is requested, the conf file will be prompted for, defaulting
to the above. It can be manually changed.

### Logging

Per default logging is disabled. If you want to use it, provide a log file name like this

```tmux
set -g @menus_log_file '~/tmp/tmux-menus.log'
```

</details>
<details>
<summary>Screen might be too small</summary>
<br>

tmux does not give any error if a menu doesn't fit the available screen.
The only hint is that the menu is terminated instantaneously.
Since this test is far from perfect, and some computers are really slow,
the current assumption is that if it was displayed < 0.5 seconds
(on most modern computers it will be below 0.03), it was likely due
to screen size. And this error will be displayed on the status-bar:

```tmux
tmux-menus ERROR: Screen might be too small
```

It will also be displayed if the menu is closed right away intentionally
or unintentionally, so there will no doubt sometimes be false positives.
If it doesen't happen the next time the menu is attempted, it can be ignored.

</details>
<details>
<summary>Modifications</summary>
<br>

Each menu is a script, so you can edit a menu script, and once saved,
the new content is displayed the next time you trigger that menu.

Rapid development with minimal fuzz!

If you are struggling with a menu edit, run that menu item in a pane
of the tmux session you are working on, something like

```bash
./items/sessions.sh
```

This directly triggers that menu and displays any syntax errors on the
command line.

If `@menus_log_file` is defined, either in the tmux conf, or hardcoded
in `scripts/helpers.sh` arround line 295, you can use logging like this:

```bash
log_it "foo is now [$foo]"
```

If having two terminals with one tailing a log file is unpractical,
setting the log file to `/dev/stderr` would essentially make it into `echo`.
Choosing `/dev/stderr` instead of `/dev/stdout` avoids triggering errors if
the `log_it` is called during string assignment.
</details>
<details>
<summary>Menu building</summary>
<br>

## Menu building

Each item consists of at least two params

- min tmux version for this item, set to 0.0 if assumed to always work
- Type of menu item, see below
- Additional params depending on the item type

Item types and their parameters

- M - Open another menu
  - shortcut for this item, or "" if none wanted
  - label
  - menu script
- C - run tmux Command
  - shortcut for this item, or "" if none wanted
  - label
  - tmux command
- E - run External command
  - shortcut for this item, or "" if none wanted
  - label
  - external command
- T - Display text line
  - text to display. Any initial "-" (making it unselectable in tmux menus) will be skipped if whiptail is used, since a leading "-" would cause it to crash.
- S - Separator/Spacer line line
  - no params

### Sample script

```shell
#!/bin/sh

static_content() {
  # Be aware:
  #   'set -- \' creates a new set of parameters for menu_generate_part
  #   'set -- "$@" \' should be used when appending parameters

  set -- \
    0.0 M Left "Back to Main menu  #{@nav_home}" "main.sh" \
    0.0 S \
    0.0 T "Example of a line extending action" \
    2.0 C "r" "Rename this session" "command-prompt -I '#S' \
        'rename-session -- \"%%\"'" \
    0.0 S \
    0.0 T "Example of action reloading the menu" \
    1.8 C "z" "Zoom pane toggle" "resize-pane -Z $menu_reload"

  menu_generate_part 1 "$@"
}

menu_name="Simple Test"

#  This script is assumed to have been placed in the items folder of
#  this repo, if not, you will need to change the path to dialog_handling.sh
#  below.

#  Full path to tmux-menux plugin
D_TM_BASE_PATH="$(realpath "$(dirname -- "$(dirname -- "$0")")")"
. "$D_TM_BASE_PATH"/scripts/dialog_handling.sh
```

### Complex param building for menu items

If whilst building the dialog, you need to take a break and check some
condition, you just pause the `set --` param assignments, do the check
and then resume param assignment using `set -- "$@"`

Something like this:

```shell
...
    1.8 C z "Zoom pane toggle" "resize-pane -Z $menu_reload"

if tmux display-message -p '#{pane_marked_set}' | grep -q '1'; then
    set -- "$@" \
        2.1 C s "Swap current pane with marked" "swap-pane $menu_reload"
fi

set -- "$@" \
    1.7 C p "Swap pane with prev" "swap-pane -U $menu_reload" \
...
```

</details>
<details>
<summary>Contributions</summary>
<br>

Contributions are welcome, and they're appreciated.
Every little bit helps, and credit is always given.

The best way to send feedback is to file an [issue](https://github.com/jaclu/tmux-menus/issues)

</details>

## Thanks to

- [JuanGarcia345](https://github.com/JuanGarcia345) for suggesting to make menu-cache optional.
- [phdoerfler](https://github.com/phdoerfler) for noticing TMUX_BIN was often not set,
I had it defined in my .tmux.conf, so totally missed such errors, in future testing I
will make sure not to rely on env variables.
- [giddie](https://github.com/giddie) for suggesting "Re-spawn current pane"
- [wilddog64](https://github.com/wilddog64) for suggesting adding a prefix
to the curl that probes public IP

## License

[MIT](LICENSE)
