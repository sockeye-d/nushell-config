use clipboard.nu paste

export def video [
    output: string = "",
    --url: string,
    --crf: int = 40 # Constant rate factor, from 0-51. 25 is normal, 40 is hella compressed and good for small videos.
    ] {
    let final_url = $url | default { paste }
    let final_output = if ($output | is-empty) { kdialog --textinputbox "Filename" | complete | get stdout | str trim } else $output
    if ($final_output | is-empty) {
    	print "Cancelling"
    	return
    }
    print $"Downloading ($final_url) to ($final_output)"
    yt-dlp $final_url -o - | ffmpeg -i - -crf $crf $final_output
}
