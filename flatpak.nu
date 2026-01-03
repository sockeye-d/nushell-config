def flatpak-id [] {
    flatpak list --columns=application,options | lines | split column "\t" id options | where options =~ "system,(?!runtime)" | get id
}

export extern run [
    id: string@flatpak-id,
]

export extern remove [
    id: string@flatpak-id,
]

export extern update [
    id: string@flatpak-id,
]
