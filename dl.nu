export def video [
    output: string = "",
    --url: string,
    --crf: int = 40 # Constant rate factor, from 0-51. 25 is normal, 40 is hella compressed and good for small videos.
    ] {
    yt-dlp ($url | default { paste }) -o - | ffmpeg -i - -crf $crf (if ($output | is-empty) { kdialog --textinputbox "Filename" | complete | get stdout | str trim } else $output)
}
