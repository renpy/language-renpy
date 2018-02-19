
module.exports =
  useAutocompleteProvider:
    type: 'boolean'
    default: true
    order: 0
    title: 'Enable Autocomplete Provider (Tested only on Windows and Linux)'
    description: '''TODO'''
  renpyExecutable:
    type: 'string'
    default: 'path/to/renpy'
    order: 1
    title: 'Ren\'Py Executable Path'
    description: '''
    \nWindows: path/to/renpy.exe
    \nLinux: path/to/renpy.sh
    '''
  projectsPath:
    type: 'string'
    default: ''
    order: 2
    title: 'Projects Directory'
    description: '''TODO'''
