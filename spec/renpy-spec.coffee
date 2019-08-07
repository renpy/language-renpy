describe "Ren'Py grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-renpy")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.renpy")

  it "parses the grammar", ->
    console.log grammar
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.renpy"

  it "tokenizes multi-line strings", ->
    tokens = grammar.tokenizeLines('"1\\\n2"')
    console.log tokens

    # Line 0
    expect(tokens[0][0].value).toBe '"'
    expect(tokens[0][0].scopes).toEqual ['source.renpy', 'string.quoted.double.single-line.python.renpy', 'punctuation.definition.string.begin.python.renpy']

    expect(tokens[0][1].value).toBe '1'
    expect(tokens[0][1].scopes).toEqual ['source.renpy', 'string.quoted.double.single-line.python.renpy']

    expect(tokens[0][2].value).toBe '\\'
    expect(tokens[0][2].scopes).toEqual ['source.renpy', 'string.quoted.double.single-line.python.renpy', 'constant.character.escape.newline.python.renpy']

    expect(tokens[0][3]).not.toBeDefined()

    # Line 1
    expect(tokens[1][0].value).toBe '2'
    expect(tokens[1][0].scopes).toEqual ['source.renpy', 'string.quoted.double.single-line.python.renpy']

    expect(tokens[1][1].value).toBe '"'
    expect(tokens[1][1].scopes).toEqual ['source.renpy', 'string.quoted.double.single-line.python.renpy', 'punctuation.definition.string.end.python.renpy']

    expect(tokens[1][2]).not.toBeDefined()
