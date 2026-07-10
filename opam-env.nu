export-env {
    load-env ($"(opam env)\nprintenv" | sh | lines | parse "{column0}={column1}" | let data | get column0 | iter zip-into-record $data.column1 | first | reject PWD)
}
