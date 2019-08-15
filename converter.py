# Resumay is for resum\'es
# A super-simple LaTeX class for a clear, concise resum\'e
# (CVs also supported!)

# Copyright (C) 2019 Cameron McGarry <cameron@cmcgarry.co.uk>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the LICENSE file for more details.

"""
Author: Cameron McGarry 2019

This is a simple method of converting a CV stored in a JSON format into a TeX
file compatible with the Resumay LaTeX class. Input as arguments:
input JSON file,
output TeX file (optional, default to cv_.tex)
output BibTeX file (optional, default to bib_.bib)

TODO:
    - Warn on overwriting files
    - Proper saving of file rather than printing to console
    - Do something with position subtitles (just roll in with title?)
    - Ensure capitalisation on first letter in skills
    - Improved documentation
    - Properly handle missing keys
    - Respect "publish" key
    - Handle positions without comments (should have a description, which goes
      in a positionenv)
    - Clean JSON, which we can assume may contain HTML tags, for LaTeX
"""

import json
import sys

def get_paths():
    """
    Get file paths from argvs
    """
    arg_no = len(sys.argv)
    if arg_no < 2:
        print("Supply input file as argument (input, tex out, bib out)")
        quit()
    if arg_no > 4:
        print("Warning: too many arguments supplied")
    json_path = sys.argv[1]
    tex_path = 'cv_.tex'
    bib_path = 'bib_.bib'
    if arg_no > 2:
        tex_path = sys.argv[2]
    if arg_no > 3:
        bib_path = sys.argv[3]
    return json_path, tex_path, bib_path


def build_position_tex(position):
    """
    Takes a position in the form of JSON schema and produces tex output for that
    env.
    """
    tex_env = "positionenv"
    end = ''
    comments = []
    skills = ''
    if "end" in position:
        end = position["end"]
    if "comments" in position:
        # If we find comments then assume a positionenv, i.e. build the comments
        # into a list
        tex_env = "positionlist"
        comments = position["comments"]
    if "skills" in position:
        skills = "; ".join(position["skills"])

    position_data = {
            "tex_env": tex_env,
            "title": position["title"],
            "start": position["start"],
            "end": end,
            "skills": skills
            }
    
    output = "\\begin{{{tex_env}}}{{{title}}}{{{start}}}{{{end}}}{{{skills}}}"
    output = output.format(**position_data)

    for comment in comments:
        output += ("\n    \\item " + comment)

    output += ("\n\\end{{{tex_env}}}\n\n".format(**position_data))
    
    return output

def build_publication_bibtex(publication):
    """
    Build a bibtex entry from a JSON of structure
    {...  "fieldname":"fieldentry" ...} where special fieldnames "bibtype" and
    "bibid" form the bibtex id and bibtex type
    """
    bib_id = publication["bibid"]
    bib_type = publication["bibtype"]
    bibtex = '@{}{{{}\n'.format(bib_id, bib_type)
    del publication["bibid"]
    del publication["bibtype"]

    for field_name in publication:
        field_entry = publication[field_name]
        bibtex += "{}  =  {{{}}},\n".format(field_name, field_entry)

    bibtex += '}\n\n'
    return bibtex


def main():
    """
    Load JSON and convert to TeX and BiBTeX
    """

    json_path, tex_path, bibtex_path = get_paths()
    json_file = open(json_path)
    json_cv = json.load(json_file)

    tex = """
\documentclass{{resumay}}

\\name{{{name}}}
\\email{{{email}}}
\\phone{{{phone}}}
\\underlinetitle

% For publication list, rely on bibentry
\\usepackage{{bibentry}}

\\begin{{document}}

\\maketitle
\n"""

    tex = tex.format(**json_cv)

    if "sections" in json_cv:
        sections = json_cv["sections"]
        for section in sections:
            positions = section["positions"]
            for position in positions:
                tex += build_position_tex(position)

    if "publications" in json_cv:
        bibtex = ""
        publications = json_cv["publications"]
        tex += "\n\\begin{enumerate}"
        for publication in publications:
            tex += "\n\\item[] \\bibentry{{{}}}".format(publication["bibid"])
            bibtex += build_publication_bibtex(publication)
        tex += "\n\\end{enumerate}"

    print(tex)
    print('\n\n\n\n')
    print(bibtex)

if __name__ == "__main__":
    main()
