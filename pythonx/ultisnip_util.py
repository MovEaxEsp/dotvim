""""
ultisnip_util.py: Utility functions used by snippets
"""

import bdeformatutil
import string
import vim
import parseutil
from sectiontype import SectionType

def copyright():
    import datetime
    return """// ----------------------------------------------------------------------------
// NOTICE:
//      Copyright (C) Bloomberg L.P., {0}
//      All Rights Reserved.
//      Property of Bloomberg L.P. (BLP)
//      This software is made available solely pursuant to the
//      terms of a BLP license agreement which governs its use.
// ------------------------------ END-OF-FILE ---------------------------------""".format(datetime.date.today().year)

def getFtCommentStr(ft = None):
    """
    Get the comment string for the specified 'ft', or for the filetype of the
    current vim buffer if 'ft == None'
    """

    if not ft:
        ft = vim.current.buffer.options['ft']

    if ft == "c" or ft == "cpp" or ft == "javascript":
        return "// "
    elif ft == "python":
        return "# "
    else:
        # Most other things use # (I think)
        return "# "

def rightAlign(width, text):
    return (width - len(text))*' ' + text

def centerPadding(text):
    """
    Return the padding necessary to center the specified 'text' in a line 79
    chars wide.
    """
    return ' ' * int(39 - (len(text))/2)

def centerBorder(border, text, commentStr="// "):
    """
    Return the border consisting of the specified 'border' character,
    beginning with the specified 'commentStr' for the specified 'text'
    centered in a line 79 chars wide.
    """
    return centerPadding(commentStr + text) + commentStr + border*len(text)

def centerComment(text, commentStr="// "):
    """
    Return the beginning of a centered comment, i.e. the padding and the
    specified 'commentStr' characters needed to center the specified 'text' in
    a line 79 chars wide.
    """
    return centerPadding(commentStr + text) + commentStr

def header(border, text):
    lines = [
        centerBorder(border, text),
        centerComment(text) + text,
        centerBorder(border, text)]
    return "\n".join(lines)

