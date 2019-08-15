# Resumay

Resumay is a super-simple LaTeX class for a clear, concise resum\\\'e.
CVs are also supported!

Distributed under WTFPL (see `LICENSE.txt`)

## Usage

Simply place the resumay.cls file into your working directory, and use the
`resumay` document class.

Pass the `sans` option to use sans class.

Provide a `name`, `email`, and `phone` for your header.

Specify if you want the header to be underlined with `underlinetitle`

Use the `positionlist` and `positionenv` environments to create a bulleted list
or a simple paragraph. Take optional arguments: title, start date, end date,
skills

## JSON Conversion

A script is included to convert from a CV in JSON format to TeX. This may be
useful if (for example) you wish to separtely render your same CV in HTML to go
on your website.

## Todos

* Built-in position list commands
* Custom bib style? (Or better suggestion in example CV?)
* More options for headers
* Automatic placing of items in header
* Manual control over order of items in header
* Improve support of Python converter (see file)
* Proper description of JSON schema
* Compatibility with JSONresume (?)
