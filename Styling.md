# Layout Introduction

This is still experimental, so some variables might change names if it turns out that the current choices don’t make much sense.

Be aware that cashing isnt fully operational in this branch as of yet. It is highly recomended to disable it until this warning is removed

```tmux
set -g @menus_use_cache false
```

## New menu style variables

The prefix `simple_style` indicates that it doesn’t support full style notation like `#[fg=blue,bg=yellow,blink,underline]`. 
The -H, -s, and -S parameters seem to only support setting fg, bg, and default, but I could be mistaken.

The -T parameter (`@menus_format_title`) is a FORMAT field. Use `#{@menu_name}` to display the menu name, but most formatting options should work here.

In the table below, Param refers to display-menu parameters (see the tmux man page). The default for all of these is `default`.

Param | variable
------|----------
-T    | @menus_format_title
-H    | @menus_simple_style_selected
-s    | @menus_simple_style
-S    | @menus_simple_style_border

To maximize styling freedom, these variables are not wrapped in quotes, as tmux scripting has limitations that quickly exhaust available quotes.
This could be more trouble than it's worth, so let me know if this method isn’t practical. On the upside, it should allow for maximum styling flexibility.
All quoting of spaces, etc., is up to the style creator. For example, I prefer spaces around the title, so in this implementation, those spaces must be wrapped.

Example:

```tmux
set -g @menus_format_title "'#[align=centre] #[fg=colour34]#{@menu_name}#[default] '"
```

## Menu navigaion hints

I’ve also made the navigation hints fully customizable. These fields seem to support full styling.

  action  |default|  variable
----------|-------|----------------
next menu |  -->  | @menus_nav_next
prev menu |  <--  | @menus_nav_prev
home      |  <==  | @menus_nav_home

## Per menu overrides

All these items support overrides on a per-menu level, for those who want full control over dynamic menus. If an override is defined in a menu, it will take precedence over the config variables.

override variable | tmux conf variable
------------------|-------------------
override_title    | @menus_format_title
override_selected | @menus_simple_style_selected
override_style    | @menus_simple_style
override_border   | @menus_simple_style_border
override_next     | @menus_nav_next
override_prev     | @menus_nav_prev
override_home     | @menus_nav_home

These overrides are ideal for testing themes and styles. By assigning overrides in a menu and saving it, you’ll invalidate the cache (if used), and the menu will be regenerated with the new style the next time it’s displayed.

![sample of dynamic changes using overrides](https://github.com/user-attachments/assets/8fdafd7a-e344-450b-b2fc-ec33996ce2c2)

## Sample config

```tmux
set -g @menus_format_title "'#[align=centre] #[fg=colour34]#{@menu_name}#[default] '"
set -g @menus_simple_style_selected "fg=#ff79c6,bg=colour236"
set -g @menus_simple_style "fg=colour62"
set -g @menus_simple_style_border "fg=colour223"

set -g @menus_nav_next "#[fg=yellow]-->"
set -g @menus_nav_prev "#[fg=green]<--"
set -g @menus_nav_home "#[fg=red]<=="
```

## Aesthetic Disclaimer

I have little sense of visual aesthetics, so these features are not driven by a personal need for visual appeal. However, it was recently suggested that it would be useful to match menus to various themes, which made me curious about how to provide such features.
For me, it’s more about making it technically easy to use and implement. I’ve included some samples to show what’s possible, but please be kind—creating themes isn’t my goal.
Hopefully, those with an eye for design can put this to good use!
