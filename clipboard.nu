export def copy [what?: string]: [string -> string, nothing -> nothing] {
	let IN
    qdbus6 org.kde.klipper /klipper setClipboardContents ($what | default { $IN })
}

export def paste [] {
    qdbus6 org.kde.klipper /klipper getClipboardContents
}
