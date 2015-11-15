# Suporte para a linguagem Ren'Py no editor Atom  
[![Build Status](https://travis-ci.org/williamd1k0/language-renpy.svg)](https://travis-ci.org/williamd1k0/language-renpy)
[![Join the chat at https://gitter.im/williamd1k0/language-renpy](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/williamd1k0/language-renpy?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[English](https://github.com/williamd1k0/language-renpy#renpy-language-support-in-atom)

Adiciona o destaque de sintaxe e snippets para arquivos Ren'Py no editor Atom.

Originalmente convertido de [Python package for Atom](https://github.com/atom/language-python).

Contribuições são muito apreciados. Por gentileza, faça um fork do repositório e abra pull requests para adicionar snippets, fazer alterações na sintaxe, etc.

* O destaque de sintaxe pode variar dependendo do tema de sintaxe usado.
* Tema padrão indicado: Atom Dark.
* Tema mais indicado: [Monokai](https://atom.io/themes/monokai) (você pode indicar um tema abrindo uma issue ou pull request).
* Para ter uma melhor funcionalidade é aconselhável ~~instalar~~ (os seguintes plugins agora estão inclusos a partir da versão 1.0 do Atom) os plugins `autocomplete-plus` e `autocomplete-snippets`.
* Outro plugin recomendado (somente pela estilização): `file-icons`.

>Ren'Py é uma ferramenta de desenvolvimento de Visual Novel, disponível em [www.renpy.org](http://www.renpy.org/)

>Agradecimentos a [Koroshiya](https://github.com/koroshiya) (Sublime-Renpy) e [PyTom](https://github.com/renpytom) (Ren'py), é claro!

## Como Começar

### Instalação

Com o [Atom](https://atom.io/) já instalado, abra a aba de Configurações: `File`>`Settings` (ou com o atalho <kbd>Ctrl</kbd>+<kbd>,</kbd>).

Clique em `+ Install` e pesquise por `renpy` e então clique no `Install` do pacote `language-renpy`.

Também é possível instalar usando o comando do terminal/prompt `apm`(atom package manager):
```sh
apm install language-renpy
```

### Uso

Abra um arquivo `.rpy` ou crie um novo e teste o destaque da sintaxe do Ren'Py.
Use também o [arquivo de exemplo](https://github.com/williamd1k0/language-renpy/blob/master/example.rpy) disponível no repositório do pacote.

## Snippets:

Snippets são pedaços de código como no seguinte exemplo.

![Snippets](http://i.imgur.com/XIlsFjr.gif)

O uso é feito com palavras-chave e em seguida um <kbd>Tab</kbd> para inserir o snippet.

Por exemplo, há um snippet com links úteis, digite `dochelp` e pressione <kbd>Tab</kbd> ou <kbd>Enter</kbd>.

Você pode conferir a lista dos snippets pelo Atom, estando na aba de um arquivo `.rpy` e pressionando <kbd>Shift</kbd>+<kbd>Alt</kbd>+<kbd>S</kbd> ou indo nas configurações do pacote (`Settings`>`Packages`>`language-renpy`>`Snippets`).

Snippets serão adicionados de acordo com a necessidade, por isso sujestões são muito bem vindas.
Utilize a [issue do repositório](https://github.com/williamd1k0/language-renpy/issues/6) para deixar seu snippet ou envie uma mensagem para o email `tumeowilliam@gmail.com`.
