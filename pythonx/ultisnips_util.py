import string

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

def rightAlign(width, text):
    return (width - len(text))*' ' + text

def centerPadding(text):
    """
    Return the padding necessary to center the specified 'text' in a line 79
    chars wide.
    """
    return ' ' * (39 - (len(text) + len("// "))/2)

def centerBorder(border, text):
    """
    Return the border consisting of the specified 'border' character for
    specified 'text' centered in a line 79 chars wide.
    """
    return centerPadding(text) + "// " + border*len(text)

def centerComment(text):
    """
    Return the beginning of a centered comment, i.e. the padding and the "// "
    characters needed to center the specified 'text' in a line 79 chars wide.
    """
    return centerPadding(text) + "// "

def header(border, text):
    lines = [
        centerBorder(border, text),
        centerComment(text) + text,
        centerBorder(border, text)]
    return "\n".join(lines)


def classDef(name):
    """
    Return the class definition for a class with the specified 'name'.
    """

    template = string.Template("""class $name {
    // TODO

  private:
    // DATA

    // NOT IMPLEMENTED
    $name(const $name&);
    $name& operator=(const $name&);

  public:
    // TRAITS
    BSLMF_NESTED_TRAIT_DECLARATION($name,
                                   bslma::UsesBslmaAllocator);

    // CREATORS
    explicit $name(bslma::Allocator *basicAllocator = 0);

    // MANIPULATORS

    // ACCESSORS
};""")

    return template.safe_substitute({"name":name})

def structDef(name):
    """
    Return the definition for a struct with the specified 'name'.
    """

    template = string.Template("""struct $name {
    // TODO

  public:
    // PUBLIC DATA

    // NOT IMPLEMENTED
    $name(const $name&);
    $name& operator=(const $name&);

  public:
    // TRAITS
    BSLMF_NESTED_TRAIT_DECLARATION($name,
                                   bslma::UsesBslmaAllocator);

    // CREATORS
    explicit $name(bslma::Allocator *basicAllocator = 0);

    // MANIPULATORS

    // ACCESSORS
};""")

    return template.safe_substitute({"name":name})

def utilDef(name):
    """
    Return the definition for a utility struct with the specified 'name'.
    """

    template = string.Template("""struct $name {
    // TODO

    // CLASS METHODS
};""")

    return template.safe_substitute({"name":name})

def protocolDef(name):
    """
    Return the definition of a protocol class with the specified 'name'.
    """

    template = string.Template("""class $name {

  public:
    // CREATORS
    virtual ~$name();

    // MANIPULATORS
};""")

    return template.safe_substitute({"name":name})
