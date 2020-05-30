import os, strformat, times, strutils
let target = "~/.deltrash".expandTilde()

if paramCount() < 1:
    echo "You need to pass at least one argument"
    quit()

let sources = commandLineParams()
let timeid = now().format("yyMMddhhmmss")
let error = "There was an error moving the file to the trash"
var trash: string

for source in sources:
    var src = source.normalizePathEnd(false)
    trash = target / src

    if source.existsDir():
        if (target / source).existsDir():
            trash = target / fmt"{src}_{timeid}"
        try:
            moveDir(source, trash)
        except OSError:
            echo error

    if source.existsFile():
        if (target / source).existsDir():
            trash = target / fmt"{src}_{timeid}"
        try:
            moveFile(source, trash)
        except OSError:
            echo error
