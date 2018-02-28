
renpy = require './renpy'

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
    for label in Object.keys(renpy.labels).sort()
      suggestions.push(
        text: cmd+label
        displayText: label
        rightLabel: 'Label at: '+renpy.labels[label][0]+':'+renpy.labels[label][1]
        iconHTML: '<i class="icon-tag"></i>'
        type: 'tag'
      )
  # console.info suggestions
  return suggestions

get_transforms = (prefix) ->
  suggestions = []
  if prefix.match /at/ # TODO: use bufferPosition for a better completion
    for t in Object.keys(renpy.transforms).sort()
      suggestions.push(
        text: prefix.replace(/at/, (p) -> p+' '+t+',')
        displayText: t
        rightLabel: 'Transform at: '+renpy.transforms[t][0]+':'+renpy.transforms[t][1]
        iconHTML: '<i class="icon-alignment-align"></i>'
        type: 'method'
      )
  return suggestions

get_characters = (prefix) ->
  suggestions = []
  chars = Object.keys(renpy.characters).sort()
  for c in chars.filter((c) => prefix.trim() != c && c.startsWith(prefix.trim()))
    suggestions.push(
      text: c
      displayText: c
      rightLabel: 'Character at: '+renpy.characters[c][0]+':'+renpy.characters[c][1]
      iconHTML: '<i class="icon-person"></i>'
      type: 'constant'
    )
  return suggestions

get_images = (prefix) ->
  suggestions = []
  # TODO: use bufferPosition for a better completion
  if prefix.startsWith('show') or prefix.startsWith('hide') or prefix.startsWith('scene')
    statement = 'show '
    if prefix.startsWith('hide')
      statement = 'hide '
    else if prefix.startsWith('scene')
      statement = 'scene '
    for im in Object.keys(renpy.images).sort()
      suggestions.push(
        text: statement+im
        displayText: im
        rightLabel: 'Image at: '+renpy.images[im][0]+':'+renpy.images[im][1]
        iconHTML: '<i class="icon-file-media"></i>'
        type: 'constant'
      )
  return suggestions

provider =
  selector: '.source.renpy'
  disableForSelector: '.source.renpy .comment'
  #inclusionPriority: 1
  #excludeLowerPriority: true
  suggestionPriority: 2
  #filterSuggestions: true

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix, activatedManually}) ->
    new Promise (resolve) ->
      suggestions = []
      if not renpy.is_busy
        if atom.config.get('language-renpy.useAutocompleteProvider')
          if atom.config.get('language-renpy.projectsPath') == ''
            renpy.update_projects_path()
          else if renpy.navigation_data == null
            renpy.update_project_info(editor)
          else
            console.log prefix
            suggestions = suggestions.concat(
              get_sample(prefix), # debug stuff
              get_labels(prefix),
              get_transforms(prefix),
              get_characters(prefix),
              get_images(prefix),
            )
      resolve(suggestions)

module.exports = provider
