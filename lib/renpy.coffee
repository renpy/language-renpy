# TODO: Remove redundant code..
path = require 'path'
fs = require 'fs'
cp = require 'child_process'

class StatusTile
  constructor: ->
    @tile = document.createElement 'div'
    @tile.classList.add 'renpy-statusbar'
  show: ->
    @tile.classList.add 'inline-block'
  hide: ->
    @tile.classList.remove 'inline-block'
  text: (txt) ->
    @tile.textContent = "Ren'Py: " + txt
  clear: ->
    @text ''


class RenPy
  constructor: ->
    @status_tile = new StatusTile
    @is_busy = false
    @navigation_data = null
    @current_project = null
    @file_watcher = null


  generate_navigation: (project) ->
    @is_busy = true
    @status_tile.text("Updating project info...")
    exec = @renpy_executable()
    if exec
      proj = atom.config.get('language-renpy.projectsPath')
      dest = @get_navigation_path(project)
      if not fs.existsSync(path.dirname(dest))
        fs.mkdirSync(path.dirname(dest)) # TODO: add mkdir recursive
      cmd = ['--json-dump', dest, path.join(proj, project), 'quit']
      #console.log cmd
      ex = cp.execFile(exec, cmd, (error, stdout, stderr) =>
        unless stderr
          if not @file_watcher?
            @update_navigation(dest, project)
      )
    else
      @is_busy = false

  update_navigation: (dest, project) ->
    @navigation_data = require dest
    @current_project = project
    @status_tile.text(project)
    @is_busy = false

  update_projects_path: ->
    @is_busy = true
    console.log 'Updating projects path'
    @status_tile.text('Looking for projects directory...')
    exec = @renpy_executable()
    if exec
      cmd = [path.dirname(exec), 'get_projects_directory']
      ex = cp.execFile(exec, cmd, (error, stdout, stderr) ->
        unless stderr
          atom.config.set('language-renpy.projectsPath', stdout.trim())
          atom.notifications.addSuccess('Projects directory found: '+stdout.trim())
          @is_busy = false
      )
    else
      @is_busy = false

  renpy_executable: ->
    exec = atom.config.get('language-renpy.renpyExecutable')
    if fs.existsSync exec
      return exec
    @status_tile.text("Ren'Py Executable was not found/defined.")
    return false

  find_project_name: (file) ->
    return if not file? # Ignore `untitled` editors
    dirs = file.replace(/\\/g, '/').split('/')
    count = dirs.length
    proj_root = atom.config.get('language-renpy.projectsPath')
    while count > 0
      if dirs[count] == 'game'
        if fs.existsSync path.join(proj_root, dirs[count-1])
          return dirs[count-1]
      count-=1

  update_project_info: (editor, force_update=false) ->
    if not editor?
      editor = atom.workspace.getActivePaneItem()
    proj = @find_project_name(editor.getPath())
    if proj?
      if force_update
        @generate_navigation(proj)
      else
        @load_navigation(proj)
      if not @file_watcher?
        @file_watcher = fs.watch(@get_navigation_path(proj), null, (event, file) =>
          @load_navigation(@current_project)
        )

  load_navigation: (project) ->
    @update_navigation(@get_navigation_path(project), project)

  get_navigation_path: (project) ->
    exec = @renpy_executable()
    if exec
      return path.join(path.dirname(exec), 'tmp', project, 'navigation.json')

  is_renpy_grammars: (editor) ->
    if not editor?
      editor = atom.workspace.getActivePaneItem()
    return editor.getGrammar().scopeName == "source.renpy"

  run_game: (event) =>
    return if not @is_renpy_grammars()
    return if not @current_project?
    @status_tile.text("Running "+@current_project)
    exec = @renpy_executable()
    if exec
      projdir = atom.config.get('language-renpy.projectsPath')
      dest = @get_navigation_path(@current_project)
      cmd = ['--json-dump', dest, path.join(projdir, @current_project), 'run']
      ex = cp.execFile(exec, cmd, (error, stdout, stderr) =>
        @status_tile.text(@current_project)
        @load_navigation(@current_project)
      )

renpy = new RenPy
module.exports = renpy
