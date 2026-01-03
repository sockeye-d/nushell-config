export def copy [what?: string]: [string -> string, nothing -> nothing] {
    qdbus6 org.kde.klipper /klipper setClipboardContents ($what | default { $in })
}

export def paste [] {
    qdbus6 org.kde.klipper /klipper getClipboardContents
}
