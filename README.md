# beamui

**beamui** is a complete rewrite of [dlangui](https://github.com/buggins/dlangui) - the rich widget toolkit, written entirely in the D language.

[API documentation](https://dayllenger.github.io/beamui/)

[Contribution guide](https://github.com/dayllenger/beamui/blob/master/CONTRIBUTING.md)

[The differences to dlangui](https://github.com/dayllenger/beamui/wiki/The-differences-to-dlangui)

Please note that the library is unstable until v1.0, and minor versions may and will break API and old concepts.

## Main features

* Cross-platform (Linux, Windows, macOS)
* CSS theming: implementation of a [part of CSS 3](https://github.com/dayllenger/beamui/wiki/CSS-Reference), with few adjustments
* Flexbox layout and a small subset of CSS Grid
* Hardware acceleration using OpenGL 3.1+
* Fallback to software renderer when OpenGL is not available
* Painting API with antialiased filling and stroking of arbitrary paths

Things that are under development:
* Component-based VDOM-like approach to declarative views
* Virtualized list/table views
* CSS encapsulation
* Simple media queries
* Dark theme, color schemes
* Animations and transitions
* Native dialogs
* Formatted text
* Localization using GNU gettext
* HiDPI support
* Render to texture for embedding into apps like game level editors
* Android platform, OpenGL ES
* Console text interfaces

This library aims to stay fairly simple and not to compete with Flutter, Avalonia, or Qt. There is no webview, no support for gestures, camera or microphone devices, no utilities for networking. I can only recommend to search for separate packages for your concrete case. Also, the library is not thread safe - all UI operations should perform in a single thread.

## Build Requirements

You will need *dub* package manager, *dmd* or *ldc* compiler. Other compilers were not tested. Visit [dlang download page](https://dlang.org/download.html) for various installation methods.

Supported compiler versions are dmd ≥ 2.086, ldc ≥ 1.16.

### Dependencies

`pixman sdl2 x11 xext` are the external dependencies. Not all configurations require them, but it's simpler to just install them all at once.

If you develop for 32-bit target, install respective 32-bit packages, e.g. on `apt` by adding `:i386` after their names.

#### Ubuntu

```sh
sudo apt install libpixman-1-dev libsdl-dev libx11-dev libxext-dev
```

#### Arch Linux

```sh
sudo pacman -S --needed pixman sdl2 libx11 libxext
```

#### macOS

```sh
brew install pixman sdl2
```

#### Windows

Necessary dlls are shipped with the toolkit. `dub` automatically copies them into the app build folder.

To build 32-bit apps on Windows, use dub option `--arch=x86_mscoff`. OPTLINK is not supported anymore.

## Quick Guide

Clone the repository (or download zip and unpack it):
```sh
git clone https://github.com/dayllenger/beamui.git
cd beamui
```

Run some examples:
```sh
dub run :basic
dub run :canvas
dub run :css
```
