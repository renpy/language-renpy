'use babel'

export default {

    provideGrammar () {
        return [{
            grammarScopes: ['source.renpy'],
            checkedScopes: {
                "constant.other.placeholder.tags.renpy" : false,
                "string.quoted.double.single-line.python.renpy" : true,
                "string.quoted.single.single-line.python.renpy" : true,
                "string.quoted.double.block.python.renpy" : true,
                "string.quoted.single.block.python.renpy" : true,
            }
        }]
    }

}
