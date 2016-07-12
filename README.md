# Ren'Py language support in Atom

<a href='https://pledgie.com/campaigns/31864'><img alt='Click here to lend your support to: Ren&#x27;Py Package for Atom and make a donation at pledgie.com !' src='https://pledgie.com/campaigns/31864.png?skin_name=chrome' border='0' ></a>
[![Build Status](https://travis-ci.org/williamd1k0/language-renpy.svg)](https://travis-ci.org/williamd1k0/language-renpy)
[![Join the chat at https://gitter.im/williamd1k0/language-renpy](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/williamd1k0/language-renpy?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[Português](https://github.com/williamd1k0/language-renpy/blob/master/README_PT-BR.md)

Adds syntax highlighting and snippets to Ren'Py files in Atom.

Originally converted from the [Python package for Atom](https://github.com/atom/language-python).

Syntax highlighting test: [`GitHub Lightshow`](https://github-lightshow.herokuapp.com/?utf8=%E2%9C%93&scope=from-url&grammar_url=https%3A%2F%2Fgithub.com%2Fwilliamd1k0%2Flanguage-renpy%2Fblob%2Fmaster%2Fgrammars%2Frenpy.cson&grammar_text=&code_source=from-url&code_url=https%3A%2F%2Fgithub.com%2Fwilliamd1k0%2Flanguage-renpy%2Fblob%2Fmaster%2Fexample.rpy&code=)

Contributions are greatly appreciated. Please fork this repository and open a
pull request to add snippets, make grammar tweaks, etc.

* The highlight may vary depending on the syntax theme used.
* Default suggested syntax theme: [`Atom Dark`](https://atom.io/themes/atom-dark-syntax).
* Alternative suggested syntax theme:
 * [`Monokai`](https://atom.io/themes/monokai).
 * [`octocat-syntax`](https://atom.io/themes/octocat-syntax)
* To have better functionality is advisable to ~~install~~ (the following plugins are now included in the Atom >1.0) the plugins `autocomplete-plus` and `autocomplete-snippets`.
* Other recommended plugin:
 * [`file-icons`](https://atom.io/packages/file-icons)  - Just for file icons style
 * [`pigments`](https://atom.io/packages/pigments) - Display colors in project (Hex, RGB etc)
 * [`color-picker`](https://atom.io/packages/color-picker) - Color picker (Hex, RGB etc)
 * [`minimap`](https://atom.io/packages/minimap) - Code minimap


>Ren'Py is a Visual Novel development tool, available from [www.renpy.org](http://www.renpy.org/)

>Thanks to [Koroshiya](https://github.com/koroshiya) (Sublime-Renpy) and [PyTom](https://github.com/renpytom) (Ren'Py), of course!

>[Known issues](https://github.com/williamd1k0/language-renpy/issues/8)

## Getting Started

### Installation

With [Atom](https://atom.io/) already installed, open the Settings tab: `File`>`Settings` (or with <kbd>Ctrl</kbd>+<kbd>,</kbd>)

Click in <kbd>+ Install</kbd> and search for `renpy` then click in <kbd>Install</kbd> button of the package `language-renpy`.

It's also possible installing using the cli command `apm` (atom package manager):
```sh
apm install language-renpy
```

### Usage

Open a `.rpy` file or create a new one and test the syntax highlighting of the Ren'Py. Also use the [example file](https://github.com/williamd1k0/language-renpy/blob/master/example.rpy) available on the package repository.

## Snippets:

Snippets are pieces of code like in the following example.

![Snippets](http://i.imgur.com/J6Y17rA.gif)

The usage is done with keywords followed by a <kbd>Tab</kbd> to insert the snippet.

For example, there's a snippet with useful links, type `dochelp` and press <kbd>Tab</kbd> or <kbd>Enter</kbd>.

You can check the snippets list with Atom, being at the tab of a `.rpy` file and pressing <kbd>Shift</kbd>+<kbd>Alt</kbd>+<kbd>S</kbd> or going to the package settings (`Settings`>`Packages`>`language-renpy`>`Snippets`).

Snippets are added by need, so suggestions are welcomed. Use the [repository issue](https://github.com/williamd1k0/language-renpy/issues/6) to leave your suggestion or send a message to `tumeowilliam@gmail.com`.
