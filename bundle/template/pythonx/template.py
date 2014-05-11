#!/usr/bin/env python
import glob
import os
import sys

# Map of template name (i.e. bde.cpp) to path of file defining it
TEMPLATES = {}

FUNCTION_OPEN = "[*"
FUNCTION_CLOSE = "*]"


# Functions intended to be invoked from templates
def expandTemplate(*args):
    """
    Expand the template 'args[0]', passing it the remaining arguments
    """
    ret = generate(args[0], args[1:])
    return ret

def leftCenterRight(left, center, right, width=79):
    centerPos = (width - len(center))/2
    pad1 = centerPos - len(left)
    pad2 = width - len(right) - centerPos - len(center)

    return left + (' ' * pad1) + center + (' ' * pad2) + right

# End template functions

def addTemplatePath(templatePath):
    """
    Add all the *.template files at the specified 'templatePath' to the list of
    available templates.
    """
    files = glob.glob(templatePath + "/*.template")
    templates = [os.path.basename(x)[:-len(".template")] for x in files]
    for f, t in zip(files, templates):
        TEMPLATES[t] = f

def isTemplateName(name):
    """
    Return 'True' if the specified 'name' is a known template name, and
    'False' otherwise
    """
    return name in TEMPLATES

def handleFunction(functionOpening, line):
    """Evaluate the function starting at 'functionOpening' in line and return
       a copy of line with the result applied to it"""

    functionEndIndex = line.find(FUNCTION_CLOSE, functionOpening)
    functionText = line[functionOpening + len(FUNCTION_OPEN):functionEndIndex]

    return line[:functionOpening] + \
           eval(functionText) + \
           line[functionEndIndex + len(FUNCTION_CLOSE):]

def generate(template, replacements):
    if template not in TEMPLATES:
        return "Template '" + template + "' not found."

    templateFile = open(TEMPLATES[template], "r")

    ret = ""
    replacementStrings = []
    for idx in xrange(len(replacements)):
        # Lowercase arg
        replacementStrings.append(("[-" + str(idx + 1) + "-]",
                                   replacements[idx].lower()))

        # Unmodified case arg
        replacementStrings.append(("[=" + str(idx + 1) + "=]",
                                   replacements[idx]))

        # Uppercase arg
        replacementStrings.append(("[+" + str(idx + 1) + "+]",
                                   replacements[idx].upper()))

        # All args from current point forward
        replacementStrings.append(("[$" + str(idx + 1) + "$]",
                                  " ".join(replacements[idx:])))

    for line in templateFile:
        for replacement in replacementStrings:
            line = line.replace(replacement[0], replacement[1])

        functionOpenings = [] #Locations of occurrences of FUNCTION_OPEN
        openingIndex = line.find(FUNCTION_OPEN)
        while openingIndex > -1:
            functionOpenings.append(openingIndex)
            openingIndex = line.find(FUNCTION_OPEN, openingIndex + 1)

        #evaluate functions in reverse to support nested functions
        functionOpenings.reverse()
        for function in functionOpenings:
            line = handleFunction(function, line)

        ret += line

    return ret

def expandLine(line):
    """
    Expand the specified 'line' if it begins with a template name and do
    nothing otherwise.  Return a list of lines that form the result of the
    template expansion, or simply '[line]' otherwise.
    """
    parts = line.split()
    if len(parts) == 0 or not isTemplateName(parts[0]):
        return [line]

    return generate(parts[0], parts[1:]).split("\n")[:-1]

if __name__ == "__main__":
    addTemplatePath(".")
    if len(sys.argv) == 1: # No args, each line has its template and arguments
        for line in sys.stdin:
            lineParts = line.split();
            if len(lineParts) == 0:
                print #empty line
                continue

            print "".join(generate(lineParts[0], lineParts[1:])),

        sys.exit(0)
    else:
        print "".join(generate(sys.argv[1], sys.argv[2:])),
        sys.exit(0)

    sys.exit(1)

