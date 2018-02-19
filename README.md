
# Ren'Py language support in Atom

[![Build Status](https://travis-ci.org/renpy/language-renpy.svg)](https://travis-ci.org/renpy/language-renpy)

Adds syntax highlighting and snippets to Ren'Py files in Atom. It also adds syntax
highlighting to GitHub files, markdown code blocks and GitHub Gist
([more info here](https://gist.github.com/williamd1k0/3b231c42e4a3efdd9759)).

![renpy-banner](https://t.gyazo.com/teams/thetimetunnel/952724864733e37ac528f4c9f3a07cf2.png)

Originally converted from the [Python package for Atom](https://github.com/atom/language-python).

Syntax highlighting test: [`GitHub Lightshow`](https://github-lightshow.herokuapp.com/?utf8=%E2%9C%93&scope=from-url&grammar_format=cson&grammar_url=https%3A%2F%2Fgithub.com%2Frenpy%2Flanguage-renpy%2Fblob%2Fmaster%2Fgrammars%2Frenpy.cson&grammar_text=&code_source=from-url&code_url=https%3A%2F%2Fgithub.com%2Frenpy%2Flanguage-renpy%2Fblob%2Fmaster%2Fexample.rpy)

Contributions are greatly appreciated. Please fork this repository and open a
pull request to add snippets, make grammar tweaks, etc.

* The highlight may vary depending on the syntax theme used.
* Default suggested syntax theme: [`Ren'Py Dark`](https://atom.io/themes/renpy-dark-syntax).
* Alternative suggested syntax theme:
 * [`Atom Dark`](https://atom.io/themes/atom-dark-syntax).
 * [`Monokai`](https://atom.io/themes/monokai).
 * [`octocat-syntax`](https://atom.io/themes/octocat-syntax)
* Other recommended packages:
 * [`file-icons`](https://atom.io/packages/file-icons)  - Just for file icons style
 * [`pigments`](https://atom.io/packages/pigments) - Display colors in project (Hex, RGB etc)
 * [`color-picker`](https://atom.io/packages/color-picker) - Color picker (Hex, RGB etc)
 * [`minimap`](https://atom.io/packages/minimap) - Code minimap

>Ren'Py is a Visual Novel development tool, available from [www.renpy.org](http://www.renpy.org/)

>Thanks to [Koroshiya](https://github.com/koroshiya) (Sublime-Renpy).

## Getting Started

### Installation

When using Ren'Py 6.99.14.2 or higher, go to preferences and select Atom as your text editor.

With [Atom](https://atom.io/) already installed, open the Settings tab: `File`>`Settings` (or with <kbd>Ctrl</kbd>+<kbd>,</kbd>)

Click in <kbd>+ Install</kbd> and search for `renpy` then click in <kbd>Install</kbd> button of the package `language-renpy`.

It's also possible installing using the cli command `apm` (atom package manager):
```sh
apm install language-renpy
```

### Usage

Open a `.rpy` file or create a new one and test the syntax highlighting of the Ren'Py. You can also use the [example file](example.rpy) available on the package repository.

## Snippets:

Snippets are pieces of code like in the following example.

![Snippets](http://i.imgur.com/J6Y17rA.gif)

The usage is done with keywords followed by a <kbd>Tab</kbd> to insert the snippet.

For example, there's a snippet with useful links, type `dochelp` and press <kbd>Tab</kbd> or <kbd>Enter</kbd>.

You can check the snippets list while editing a `.rpy` file, just open the Command Palette (<kbd>Ctrl/Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>) and search for **Snippets: Available** or go to the package settings (`Settings`>`Packages`>`language-renpy`>`Snippets`).

Snippets are added by need, so suggestions are welcome.
