
renpy = require './renpy'
provider = require './provider'

module.exports =
  activate: ->
    atom.commands.add('atom-workspace',
      'renpy-command:run-game': renpy.run_game
    )
    atom.commands.add('atom-workspace',
      'renpy-command:open-launcher': renpy.open_launcher
    )
    atom.commands.add('atom-workspace',
      'renpy-command:dump-navigation': ->
        renpy.update_project_info(null, true)
    )
    console.info 'renpy-provider init'
    @observe_texteditor = atom.workspace.observeActiveTextEditor((editor) ->
      if editor? and renpy.is_renpy_grammars(editor)
        renpy.status_tile.show()
        renpy.update_project_info(editor)
    )

  provide: -> provider

  status_bar: (statusBar) ->
    @statusBarTile = statusBar.addLeftTile(item: renpy.status_tile.tile, priority: -1)
  deactivate: ->
    @statusBarTile?.destroy()
    @statusBarTile = null
    @observe_texteditor.dispose()

  config: require './config'
