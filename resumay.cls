\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resumay}[2019/02/26 Resumay is for resumes]

\LoadClass{article}
\RequirePackage{titlesec} % Customise section headings
\RequirePackage{environ}
\RequirePackage{enumitem}
\RequirePackage[a4paper, total={6in,8in}]{geometry}

% No headers or footers (page numbers)
\pagestyle{empty}
% Dense text
\setlength{\parskip}{0.1mm}

% TODO Create web-friendly sans serif CV
\DeclareOption{sans}{\OptionNotUsed}
\ProcessOptions\relax

% Header arguments
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\email}[1]{\def\@email{#1}}
\newcommand{\phone}[1]{\def\@phone{#1}}

% New maketitle
\date{} % Hide date
\renewcommand{\maketitle}{
\bgroup\setlength{\parindent}{0pt}
\begin{flushleft}
  \textbf{\Huge\@name}\\
  \vspace{4pt}
  \large\@email\\
  \large\@phone\\
  \noindent\makebox[\linewidth]{\rule{\linewidth}{0.4pt}}
\end{flushleft}\egroup
}



%\newcommand{\name}[1]{\title{\@phone}}
%\patchcmd{\@maketitle}{\@title}{\textbf{\@email{}}}
%\renewcommand{\maketitle}{
%  \begin{titlepage}
%  \@title
%  \end{titlepage}
%}

% Section headers should be large, with small capitals and left aligned
\titleformat{\section}
  {\Large\scshape\raggedright}
  {}
  {0em}
  {}
% Reduce spacing
\titlespacing*{\section}{0pt}{2pt}{2pt}

% Subsection should be indented
\titleformat{\subsection}
  {\bfseries}
  {\hspace{1em}}
  {0em}
  {}
% Reduce spacing
\titlespacing*{\subsection}{0pt}{2pt}{2pt}

% Define a position header
\newcommand{\position}[3]{
  \subsection{#1 \hfill #2--#3}
}

% Position environment produces a position header, then bullets any items
\NewEnviron{positionlist}[3]{
  \position{#1}{#2}{#3}
  \list{}{\leftmargin=2em \topsep=0pt \partopsep=0pt \itemsep=1pt \parsep=0pt}
    \BODY
  \endlist
}
