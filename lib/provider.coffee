# TODO: re-organize this file (it's messy, sorry)

path = require 'path'
fs = require 'fs'
cp = require 'child_process'

is_busy = false
navigation_data = null
current_project = null

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
    @text current_project

status_tile = new StatusTile

sample_suggestion =
  text: 'Sample Suggestion: ok' # OR
  #snippet: 'someText(${1:myArg})'
  displayText: 'Sample Suggestion' # (optional)
  #replacementPrefix: 'renpy' # (optional)
  type: 'value' # (optional)
  #leftLabel: '' # (optional)
  #leftLabelHTML: '' # (optional)
  #rightLabel: '' # (optional)
  #rightLabelHTML: '' # (optional)
  #className: '' # (optional)
  #iconHTML: '' # (optional)
  description: 'Just a sample suggestion' # (optional)
  #descriptionMoreURL: '' # (optional)
  #characterMatchIndices: [0, 1, 2] # (optional)

get_sample = (prefix) ->
  if prefix == 'renpy' then sample_suggestion else []

get_labels = (prefix) ->
  suggestions = []
  if prefix.startsWith('call') or prefix.startsWith('jump')
    cmd = if prefix.startsWith('call') then 'call ' else 'jump '
    labels = navigation_data.location.label
    console.log labels
    for label in Object.keys(labels)
      suggestions.push(
        text: cmd+label
        displayText: label
        rightLabel: 'Label at: '+labels[label][0]+':'+labels[label][1]
        iconHTML: '<i class="icon-tag"></i>'
        type: 'tag'
      )
  console.info suggestions
  return suggestions

get_transforms = (prefix) ->
  suggestions = []
  if prefix.match /at/ # TODO: use bufferPosition for a better completion
    transforms = navigation_data.location.transform
    for t in Object.keys(transforms)
      suggestions.push(
        text: prefix.replace(/at/, (p) -> p+' '+t+',')
        displayText: t
        rightLabel: 'Transform at: '+transforms[t][0]+':'+transforms[t][1]
        iconHTML: '<i class="icon-alignment-align"></i>'
        type: 'method'
      )
  return suggestions

generate_navigation = (project) ->
  is_busy = true
  status_tile.text "Updating project info..."
  renpy = renpy_executable()
  if renpy
    proj = atom.config.get('language-renpy.projectsPath')
    dest = path.join(path.dirname(renpy), 'tmp', project, 'navigation.json')
    if not fs.existsSync(path.dirname(dest))
      fs.mkdirSync(path.dirname(dest)) # TODO: add mkdir recursive
    cmd = ['--json-dump', dest, path.join(proj, project), 'quit']
    #console.log cmd
    ex = cp.execFile(renpy, cmd, (error, stdout, stderr) ->
      unless stderr
        navigation_data = require dest
        console.log navigation_data
        current_project = project
        status_tile.text project
        is_busy = false
    )
  else
    is_busy = false

update_projects_path = ->
  is_busy = true
  console.log 'Updating projects path'
  status_tile.text 'Looking for projects directory...'
  renpy = renpy_executable()
  if renpy
    cmd = [path.dirname(renpy), 'get_projects_directory']
    ex = cp.execFile(renpy, cmd, (error, stdout, stderr) ->
      unless stderr
        atom.config.set('language-renpy.projectsPath', stdout.trim())
        atom.notifications.addSuccess('Projects directory found: '+stdout.trim())
        is_busy = false
    )
  else
    is_busy = false

renpy_executable = ->
  renpy = atom.config.get('language-renpy.renpyExecutable')
  if fs.existsSync renpy
    return renpy
  status_tile.text "Ren'Py Executable was not found/defined."
  return false

find_project_name = (file) ->
  dirs = file.replace(/\\/g, '/').split('/')
  count = dirs.length
  proj_root = atom.config.get('language-renpy.projectsPath')
  while count > 0
    if dirs[count] == 'game'
      if fs.existsSync path.join(proj_root, dirs[count-1])
        return dirs[count-1]
    count-=1

is_renpy_grammars = (editor) ->
  if not editor?
    editor = atom.workspace.getActivePaneItem()
  return editor.getGrammar().scopeName == "source.renpy"

update_project_info = (editor, force_update=false) ->
  if not editor?
    editor = atom.workspace.getActivePaneItem()
  proj = find_project_name(editor.getPath())
  if proj?
    if current_project != proj or force_update
      generate_navigation(proj)

provider =
  selector: '.source.renpy'
  disableForSelector: '.source.renpy .comment'
  #inclusionPriority: 1
  #excludeLowerPriority: true
  suggestionPriority: 2
  #filterSuggestions: true

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix, activatedManually}) ->
    status_tile.show()
    new Promise (resolve) ->
      suggestions = []
      if not is_busy
        if atom.config.get('language-renpy.useAutocompleteProvider')
          if atom.config.get('language-renpy.projectsPath') == ''
            update_projects_path()
          else if navigation_data == null
            update_project_info(editor)
          else
            console.log prefix
            suggestions = suggestions.concat(
              get_sample(prefix), # debug stuff
              get_labels(prefix),
              get_transforms(prefix)
            )
      resolve(suggestions)

module.exports =
  provider: provider
  status_tile: status_tile
  is_renpy_grammars: is_renpy_grammars
  update_project_info: update_project_info
