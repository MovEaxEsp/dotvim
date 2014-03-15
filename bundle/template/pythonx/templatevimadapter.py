"""
templatevimadapter.py: Adapter to expose 'template' inside vim
"""

import vim
import template

def addTemplatePath(templatePath):
    template.addTemplatePath(templatePath)

def expandTemplates():
    """
    Check the lines above and below the current line to see if they are
    template specifications, and replace all templates found this way with
    their expanded form in both directions until a line that doesn't match a
    template is found.
    """

    buf = vim.current.buffer
    row, col = vim.current.window.cursor

    def isTemplate(rowIdx):
        lineS = buf[rowIdx].strip()
        ret = len(lineS) == 0 or template.isTemplateName(lineS.split()[0])
        return ret

    if not isTemplate(row - 1):
        return

    startRow = endRow = row - 1
    while startRow >= 0 and isTemplate(startRow):
        startRow -= 1
    startRow += 1

    while endRow < len(buf) and isTemplate(endRow):
        endRow += 1
    endRow -= 1

    lines = []
    for row in range(startRow, endRow + 1):
        lines += template.expandLine(buf[row].strip())

    # TODO this code is copied from bdeformatvimadapter.  Make a separate vim
    # plugin containing utility python vim adapter functions
    oldLines = endRow - startRow + 1
    newLines = len(lines)
    if oldLines < newLines:
        # Add lines
        for i in range(newLines - oldLines):
            vim.command("normal o")
    elif newLines < oldLines:
        # Delete lines
        del buf[startRow:startRow + oldLines - newLines]

    for i in range(len(lines)):
        buf[startRow + i] = lines[i]
