nord-gtk-theme
==============

nord-gtk-theme is a fork of oomox-gtk-theme: https://github.com/themix-project/oomox-gtk-theme.

#### Prerequisites

You need to have those dependencies:
 - `glib-compile-schemas`
 - `gdk-pixbuf-pixdata`
 - `sassc`
 - `gtk3`

##### Arch Linux

```
sudo pacman -S --needed glib2 gdk-pixbuf2 sassc gtk3
```

#### How to generate the theme using CLI:

```bash
git clone https://github.com/libXq/nord-gtk-theme
cd nord-gtk
./export_theme.sh
```