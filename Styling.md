# Layout Introduction

This is still sort of experimental, so some variables might change name
if it turns out what I picked for now doesnt make much sense.

## New menu style variables

The prefix `simple_style` means that this doesnt allow for full style notation
like `#[fg=blue,bg=yellow,blink,underline]` they seem to only allow for
fg,bg and default

The -H -s and -S paramss seems to only allow for setting fg & bg and default, but I might be wrong.

The -T param (`@menus_format_title`) is a FORMAT field, use `#{@menu_name}`
to display the name of the menu, but mostly anything goes here.

In this table Param refers to display-menu parameters, see the `tmux`
man page. The default for all of theese is: default

Param | variable
------|----------
-T    | @menus_format_title
-H    | @menus_simple_style_selected
-s    | @menus_simple_style
-S    | @menus_simple_style_border

To give max freedom for styling, theese variables are NOT wrapped in any quotes,
since due to the limitations with tmux and scripting you quickly run out of them.

This might be more pain than gain, so let me know if this is not a practical
method. On the upside it should give styling freedom.

All quoting of spaces etc is up to the style creator.
For example I tend to want white spaces arround the title, so with this
implementation those must be wrapped.

Example:

```tmux
set -g @menus_format_title "'#[align=centre] #[fg=colour34]#{@menu_name}#[default] '"
```

## Menu navigaion hints

Once I got going I also made the navigation hints fully customizable.
Theese fields seem to have full styling support

  action  |default|  variable
----------|-------|----------------
next menu |  -->  | @menus_nav_next
prev menu |  <--  | @menus_nav_prev
home      |  <==  | @menus_nav_home

## Per menu overrides

All theese items support overrides on a per menu level for thoose that
really want to go all out when it comes to dynamic menus.
if an override is defines in a menu, that setting will be used for the
menu regardless of config variables

override variable | tmux conf variable
------------------|-------------------
override_title    | @menus_format_title
override_selected | @menus_simple_style_selected
override_style    | @menus_simple_style
override_border   | @menus_simple_style_border
override_next     | @menus_nav_next
override_prev     | @menus_nav_prev
override_home     | @menus_nav_home

Theese overrides are also the ideal method to test out themes and styles,
assign overrides in a menu and save it. Since the menu has changed the
cache (if it is used) is invalidated, and the menu is regenerated,
so the new style will immeditally be used the next tiem the menu is displayed.

![sample of dynamic changes using overrides](https://github.com/user-attachments/assets/8fdafd7a-e344-450b-b2fc-ec33996ce2c2)

## Estetic disclaimer

I have almost no sense of what makes visual sense, so theese features is
not something I have a strong urge for from a visual perspective.

However it was recently mentioned that it would be nice to be able to match
the menus to various themes, and it got me curious how to provide such features.

So for me its more from a technical perspective - how to make it easy to use
and implement.

I have included some samples just to show how things can be done,
but be kind to me, I am not aiming to create themes.

Hopefully people with sense of styling can use this!

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
