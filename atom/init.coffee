atom.commands.add 'atom-workspace', 'vim-mode-plus:toggle-enabled', ->
    disabledPackages = atom.config.get('core.disabledPackages')
    disabledPackageIndex = disabledPackages.indexOf('vim-mode-plus')
    if disabledPackageIndex is -1
        disabledPackages.push('vim-mode-plus')
        console.log "vim mode disabled"
    else
        disabledPackages.splice(disabledPackageIndex,1)
        console.log "vim mode enabled" 
    atom.config.set('core.disabledPackages',disabledPackages)

atom.commands.add 'atom-workspace', 'relative-numbers:toggle-enabled', ->
    disabledPackages = atom.config.get('core.disabledPackages')
    disabledPackageIndex = disabledPackages.indexOf('relative-numbers')
    if disabledPackageIndex is -1
        disabledPackages.push('relative-numbers')
        console.log "relative-numbers disabled"
    else
        disabledPackages.splice(disabledPackageIndex,1)
        console.log "relative-numbers enabled"
    atom.config.set('core.disabledPackages',disabledPackages)
