
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
    labels = renpy.navigation_data.location.label
    #console.log labels
    for label in Object.keys(labels)
      suggestions.push(
        text: cmd+label
        displayText: label
        rightLabel: 'Label at: '+labels[label][0]+':'+labels[label][1]
        iconHTML: '<i class="icon-tag"></i>'
        type: 'tag'
      )
  #console.info suggestions
  return suggestions

get_transforms = (prefix) ->
  suggestions = []
  if prefix.match /at/ # TODO: use bufferPosition for a better completion
    transforms = renpy.navigation_data.location.transform
    for t in Object.keys(transforms)
      suggestions.push(
        text: prefix.replace(/at/, (p) -> p+' '+t+',')
        displayText: t
        rightLabel: 'Transform at: '+transforms[t][0]+':'+transforms[t][1]
        iconHTML: '<i class="icon-alignment-align"></i>'
        type: 'method'
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
              get_transforms(prefix)
            )
      resolve(suggestions)

module.exports = provider
