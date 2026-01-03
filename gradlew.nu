def gradlew-get-tasks [] {
    ./gradlew tasks --all -q | lines | where {|x| $x =~ " - " } | split column " - " value description
}

export def --wrapped main [
    task: string@gradlew-get-tasks,
    ...rest,
] {
    ./gradlew $task ...$rest
}
