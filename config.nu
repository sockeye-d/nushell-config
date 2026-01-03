use std *
use themes/catppuccin_mocha.nu
use fish_completer.nu
use coho.nu
use prompt.nu
use gradlew.nu
use flatpak.nu
use dl.nu
use git.nu
use clipboard.nu *
use plasma.nu *
use local.nu *

$env.config.show_banner = false
$env.config.buffer_editor = 'micro'
$env.config.table.mode = 'rounded'
$env.config.table.trim = {
  methodology: "wrapping"
  wrapping_try_keep_words: false
}
$env.config.table.missing_value_symbol = ' '
$env.config.filesize.unit = 'binary'
$env.config.render_right_prompt_on_last_line = true
$env.config.table.header_on_separator = true
$env.config.completions.algorithm = 'fuzzy'
$env.config.rm.always_trash = true

alias fg = job unfreeze
