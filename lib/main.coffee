
provider = require './provider'

module.exports =
  activate: ->
    console.info 'renpy-provider init'
    @observe_texteditor = atom.workspace.observeActiveTextEditor((editor) ->
      if editor? and provider.is_renpy_grammars(editor)
        provider.status_tile.show()
        provider.update_project_info(editor)
    )

  provide: -> provider.provider

  consumeStatusBar: (statusBar) ->
    @statusBarTile = statusBar.addLeftTile(item: provider.status_tile.tile, priority: -1)
  deactivate: ->
    @statusBarTile?.destroy()
    @statusBarTile = null
    @observe_texteditor.dispose()

  config: require './config'
