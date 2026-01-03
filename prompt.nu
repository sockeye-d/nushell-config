def git_prompt_block [value: int, icon: string, color: string, value_color: string = ''] {
    if $value > 0 {
        $" ($color)($icon)($value_color)($value)"
    } else {
        ""
    }
}

def prompt [] {
    let dir = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi yellow_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)(ansi reset)"


    mut topbar: list<string> = []
    $topbar ++= [$"(ansi blue)(whoami)(ansi default)@(ansi yellow)(sys host | get hostname)"]
    if ('.git' | path exists) {
        let tag_count: int = git tag --list | lines | length
        let gstat_result: record = if ($tag_count > 30) { gstat --no-tag } else { gstat }
        if $gstat_result.repo_name != "no_repository" {
            let remote: string = if (git remote get-url origin | complete | get exit_code) == 0 {
                git remote get-url origin | url parse | get path | str trim --char / | split row / | first
            } else {
                "?"
            }
            mut git_stat = $"(ansi blue)($remote)(ansi reset)/(ansi blue_bold)($gstat_result.repo_name)"
            $git_stat += $"(ansi reset)/(ansi purple_bold)($gstat_result.branch)"
            if $gstat_result.tag != 'no_tag' {
                $git_stat += $"(ansi reset)#(ansi yellow)($gstat_result.tag)"
            }

            $git_stat += git_prompt_block $gstat_result.wt_modified '⋅' (ansi yellow)
            $git_stat += git_prompt_block $gstat_result.wt_untracked '+' (ansi green)
            $git_stat += git_prompt_block $gstat_result.wt_deleted '-' (ansi red)

            $git_stat += git_prompt_block $gstat_result.idx_modified_staged '⋅' $"(ansi yellow_reverse)"
            $git_stat += git_prompt_block $gstat_result.idx_added_staged '+' $"(ansi green_reverse)"
            $git_stat += git_prompt_block $gstat_result.idx_deleted_staged '-' $"(ansi red_reverse)"
            $git_stat += git_prompt_block $gstat_result.idx_renamed '✏ ' $"(ansi purple_reverse)"

            if $gstat_result.ahead > 0 {
                $git_stat += $" (ansi green)⤒"
                $git_stat += $"(ansi reset)($gstat_result.ahead | into string)"
            }
            if $gstat_result.behind > 0 {
                $git_stat += $" (ansi yellow)⤓"
                $git_stat += $"(ansi reset)($gstat_result.behind | into string)"
            }
            $topbar ++= [$git_stat]
        }
    }

    $"
(ansi reset)(ansi green)╭⧼($topbar | str join $"(ansi green)⧼")
(ansi reset)(ansi green)╰($path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)")" | str substring 1..
}

def "prompt right" [] {
    let time_segment = [
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X')
    ] | str join

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) { $"(ansi rb)($env.LAST_EXIT_CODE)" } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

export-env {
    $env.PROMPT_COMMAND = { prompt }

    $env.PROMPT_COMMAND_RIGHT = { prompt right }

    $env.PROMPT_INDICATOR = (ansi green) + "⧽ "
}
