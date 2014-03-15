py from templatevimadapter import *

command! Template :py expandTemplates()

function! template#AddPath(path)
    let cmd = "py addTemplatePath(\"" . a:path . "\")"
    exec cmd
endf

