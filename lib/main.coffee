
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
    atom.commands.add('atom-workspace',
      'renpy-command:run-warp': renpy.run_warp
    )
    atom.commands.add('atom-workspace',
      'core:save': (event) ->
        if renpy.is_renpy_grammars()
          renpy.update_project_info()
    )
    @observe_texteditor = atom.workspace.observeActiveTextEditor((editor) =>
      if editor? and renpy.is_renpy_grammars(editor)
        renpy.status_tile.show()
        renpy.update_project_info(editor)
        @remove_texteditor_observer()
    )
    console.info 'renpy-provider init'

  remove_texteditor_observer: ->
    if @observe_texteditor?
      @observe_texteditor.dispose()
      @observe_texteditor = null

  provide: -> provider

  status_bar: (statusBar) ->
    @statusBarTile = statusBar.addLeftTile(item: renpy.status_tile.tile, priority: -1)
    atom.tooltips.add(renpy.status_tile.trun, {"title": "Run game"})
    atom.tooltips.add(renpy.status_tile.tlauncher, {"title": "Open Ren'Py Launcher"})

  deactivate: ->
    @statusBarTile?.destroy()
    @statusBarTile = null
    @remove_texteditor_observer()

  config: require './config'
