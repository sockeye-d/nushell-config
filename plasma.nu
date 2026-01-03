export def show [path: path = .] {
    kioclient exec $path o+e> (null-device)
}

export def shell [] {
    nohup plasmashell e+o> (std null-device)
}

export def "shell replace" [] {
    nohup plasmashell --replace e+o> (std null-device)
}
