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
\setlength{\poslevel}{1em}
\setlength{\detaillevel}{2\poslevel}

% TODO Create web-friendly sans serif CV
\DeclareOption{sans}{\OptionNotUsed}
\ProcessOptions\relax

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
  \textbf{\Huge\@name}\\
  \vspace{4pt}
  \large\@phone \hfill \large\@email\\
  \ifultitle
  \noindent\makebox[\linewidth]{\rule{\linewidth}{0.4pt}}
  \fi
\end{flushleft}\egroup
}

%%%%%%%%%%
% Custom commands and environments
%%%%%%%%%%

% TODO Publication list

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
  {\hspace{\poslevel}}
  {0em}
  {}
% Reduce spacing
\titlespacing*{\subsection}{0pt}{2pt}{2pt}

% Define a position header
\newcommand{\position}[3]{
  \subsection{#1 \hfill #2--#3}
}

% Position list environment produces a position header, then bullets any items
\NewEnviron{positionlist}[3]{
  \position{#1}{#2}{#3}
  \list{}{\leftmargin=\detaillevel \topsep=0pt \partopsep=0pt \itemsep=1pt \parsep=0pt}
    \BODY
  \endlist
}

% TODO: Combine with positionlist into one thing?
% Position para produces a position header, then puts text into paragraph
\NewEnviron{positionenv}[3]{
  \position{#1}{#2}{#3}
  \begin{minipage}{\textwidth}
  \leftskip=\detaillevel \BODY
  \end{minipage}
  \vspace{-2pt}
}
