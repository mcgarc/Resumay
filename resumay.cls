% Resumay is for resum\'es
% A super-simple LaTeX class for a clear, concise resum\'e
% (CVs also supported!)

% Copyright © 2019 Cameron McGarry <cameron@cmcgarry.co.uk>
% This work is free. You can redistribute it and/or modify it under the
% terms of the Do What The Fuck You Want To Public License, Version 2,
% as published by Sam Hocevar. See the LICENSE file for more details.

%%%%%%%%%%
% Setup and requirements
%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resumay}[2019/02/26 Resumay is for resumes]

\LoadClass{article}
\RequirePackage{titlesec} % Customise section headings
\RequirePackage{environ}
\RequirePackage{enumitem}
\RequirePackage[a4paper, total={6in,8in}]{geometry}

%%%%%%%%%%
% Basic formatting
%%%%%%%%%%

% No headers or footers (page numbers)
\pagestyle{empty}
% Dense text
\setlength{\parskip}{0.1mm}
% New lengths
\newlength{\poslevel}
\newlength{\detaillevel}
\newlength{\sectionsep}
\setlength{\poslevel}{1em}
\setlength{\detaillevel}{2\poslevel}
\setlength{\sectionsep}{3pt}

% Sans serif option
\newif\if@sansres
\DeclareOption{sans}{\@sansrestrue}

\ProcessOptions\relax

%%%%%%%%%%
% Sans-serif
%%%%%%%%%%

\if@sansres
  \renewcommand{\familydefault}{\sfdefault}
\fi

%%%%%%%%%%
% Title
%%%%%%%%%%

% Header arguments
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\email}[1]{\def\@email{#1}}
\newcommand{\phone}[1]{\def\@phone{#1}}
\newif\ifultitle
\newcommand{\underlinetitle}{\ultitletrue}

% New maketitle
\date{} % Hide date
\renewcommand{\maketitle}{
\bgroup\setlength{\parindent}{0pt}
\begin{flushleft}
  \textbf{\Large\@name}\\
  \vspace{4pt}
  \small\@phone \hfill \@email\\
  \ifultitle
  \noindent\makebox[\linewidth]{\rule{\linewidth}{0.4pt}}
  \fi
\end{flushleft}\egroup
}

%%%%%%%%%%
% Custom commands and environments
%%%%%%%%%%

\if@sansres
% Sans: Section headers should be large and left aligned
\titleformat{\section}
  {\large\raggedright}
  {}
  {0em}
  {}
\else
% Serif: Section headers should also be small capitals
\titleformat{\section}
  {\large\scshape\raggedright}
  {}
  {0em}
  {}
\fi
% Reduce spacing
\titlespacing*{\section}{0pt}{\sectionsep}{2pt}

% Subsection should be indented
\titleformat{\subsection}
  {\bfseries}
  {\hspace{\poslevel}}
  {0em}
  {}
% Reduce spacing
\titlespacing*{\subsection}{0pt}{2pt}{2pt}

% Define a position header
\newcommand{\position}[3]{
  \def\enddate{#3}
  \ifx\enddate\empty
    \subsection{#1 \hfill #2}
  \else
    \subsection{#1 \hfill #2--#3}
  \fi
}

% Position list environment produces a position header, then bullets any items
\NewEnviron{positionlist}[3]{
  \position{#1}{#2}{#3}
  \list{}{\leftmargin=\detaillevel \topsep=0pt \partopsep=0pt \itemsep=1pt \parsep=0pt}
    \BODY
  \endlist
}

% Position para produces a position header, then puts text into paragraph
\NewEnviron{positionenv}[4]{
  \def\techdetails{#4}
  \position{#1}{#2}{#3}
  \begin{minipage}{\textwidth}
  \ifx\techdetails\empty
    \leftskip=\detaillevel \BODY
  \else
    \leftskip=\detaillevel \BODY \\ (\techdetails)
  \fi
  \end{minipage}
  \vspace{-2pt}
}
