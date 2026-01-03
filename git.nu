export def sync-fork [--branch: string] {
    git fetch --all
    git merge --ff-only upstream/($branch | default { git rev-parse --abbrev-ref HEAD })
}
