% ----------------------------------------------------------------
% File:     gradescopeexam.cls
% ----------------------------------------------------------------
% 
% Author:   Marek Rychlik (rychlik@email.arizona.edu)
% Date:     Tue Mar 29 20:52:35 2022
% Copying:  (C) Marek Rychlik, 2020. All rights reserved.
% 
% ----------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{gradescopeexam}[By Marek Rychlik]

\RequirePackage{ifthen}

\newif\ifprintanswers
\printanswersfalse

\newif\ifprintsolutionkey
\printsolutionkeyfalse

\DeclareOption{answers}{\printanswerstrue}
\DeclareOption{noanswers}{\printanswersfalse}
\DeclareOption{solutionkey}{\printsolutionkeytrue}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{report}%
}
\ProcessOptions\relax
\LoadClass{report}
\RequirePackage{fullpage}
\RequirePackage[framemethod=tikz]{mdframed}
\RequirePackage{comment}
\RequirePackage{tikz}
\RequirePackage{enumitem}
\RequirePackage{xcolor}
\RequirePackage{tcolorbox}

\usetikzlibrary{shapes}
\usetikzlibrary{shapes.misc,shadows}
\usetikzlibrary{calc} 

\def\printanswers{\printanswerstrue}
\def\noprintanswers{\printanswersfalse}
\def\printsolutionkey{\printsolutionkeytrue}

\newif\if@insolution
\@insolutionfalse

\newif\if@correctchoice
\@correctchoicefalse

\newif\if@pointschanged
\@pointschangedfalse


\newcounter{numquestions}
\newcounter{numquestionparts}
\newcounter{numpoints}
\newcounter{choice}

\def\numpoints{\@ifundefined{exam@numpoints}%
  {\mbox{\normalfont\bfseries ??}}%
  \exam@numpoints
}% numpoints


\newcommand\ovalnode[1]{%
  \if@correctchoice%
    \tikz[baseline=(oval.base)]{
      \node[draw,thick,ellipse,inner ysep=2pt,inner xsep=2pt](oval){\makebox[1em]{#1\vphantom{A}}};
      \draw[red!80,thick] ($(oval.north west)+(-2pt,-6pt)$) --
      ($(oval.north west)+(1pt,0pt)$) --
      ($(oval.south)+(0,0pt)$) --
      ($(oval.north east)+(2pt,2pt)$) --
      ($(oval.south)+(0,2pt)$) -- ($(oval.north west)+(1pt,0pt)$) -- cycle;
    }%
  \else
    \tikz[baseline=(oval.base)]{\node[draw,thick,ellipse,inner ysep=2pt,inner xsep=2pt](oval){\makebox[1em]{#1\vphantom{A}}};}%
  \fi}



\renewcommand\thechoice{\Alph{choice}}
\newcommand\choicelabel{\ovalnode{\thechoice}}

\newenvironment{questions}{%
  \setcounter{numquestions}{0}%
  \setcounter{numquestionparts}{0}%
  \setcounter{numpoints}{0}%
}%
{%
}

% Define the question environment
\newenvironment{question}[1][]{%
  \addtocounter{numquestions}{1}%
  \ifnum\value{numquestions}>1 \pagebreak[4]\fi%
  \def\temp{#1}\ifx\temp\empty
    \let\question@points\relax
  \else
    \addtocounter{numpoints}{#1}
    \def\question@points{(#1 \ifnum#1>1 points\else point\fi)}  
  \fi
  \ifhmode\hfill\break\fi%
  \noindent\hbox to 0pt{\hss \textbf{Q~\thenumquestions.\enspace}\hskip1em}%
  \question@points%
}{%
  \let\question@points\relax
}

% Define the parts environment
\newenvironment{parts}{%
  \ifx\question@points\relax
    % Do nothing if question@points is not defined or is \relax
  \else
    \errmessage{gradescopeexam error: Question which sets the number of points cannot have parts}
  \fi
  \setcounter{numquestionparts}{0}%
}{}

% Redefine the \part command
\renewcommand{\part}[1][]{%
  \addtocounter{numquestionparts}{1}%
  \def\temp{#1}\ifx\temp\empty
    \def\part@points{\relax}
  \else
    \addtocounter{numpoints}{#1}
    \def\part@points{(#1 \ifnum#1>1 points\else point\fi)}  
  \fi
  \pagebreak[3]%
  \ifhmode\hfill\break\fi%
  \noindent\hbox to 0pt{\hss \textbf{Q~\thenumquestions.\thenumquestionparts.}\hskip1em}%
  \part@points%
}

\newcommand\SolutionEmphasis[1]{%
  \def\Solution@Emphasis{#1}%
}
\SolutionEmphasis{}

\newcommand\ProofEmphasis[1]{%
  \def\Proof@Emphasis{#1}%
}
\ProofEmphasis{}


\newcommand{\makenonemptybox}[3]{%
  % \centering\fcolorbox{blue}{yellow}{\parbox[c][#1][c]{\dimexpr0.6\linewidth}{#2}}%
  \centering%
  \parbox[c][#1][c]{\dimexpr\linewidth}{%
    \hbox to\linewidth{\color{black!70}{\tiny\sc The Scratch Area}\hfill}\par%
    \vfill%
    \hbox to \textwidth{
      \hss
      \fcolorbox{blue!80}{yellow!10}{%
        \begin{minipage}[b][1in][b]{#2}
          #3%
          \vfill%
          \hbox to \textwidth{\hfill\color{black!70}{\tiny \sc The Answer}}
        \end{minipage}
      }%
    }%
  }%
}

\newcommand{\makeproofbox}[3]{%
  % \centering\fcolorbox{blue}{yellow}{\parbox[c][#1][c]{\dimexpr0.6\linewidth}{#2}}%
  \centering%
  \parbox[c][#1][c]{\dimexpr\linewidth}{%
    \hbox to\linewidth{\color{black!90}{\tiny\sc The Proof}\hfill}\par%
    \vfill%
    \hbox to \textwidth{
      \hss
      \begin{minipage}[b][1in][b]{#2}
        #3%
        \vfill%
        \hbox to \textwidth{\hfill\color{black!70}{\tiny \sc QED}}
      \end{minipage}
    }%
  }%
}



\newif\if@answerless
\@answerlesstrue

\newif\if@proofless
\@prooflesstrue

\newif\if@inmathmode
\@inmathmodefalse

\newlength{\left@boxmargin}
  \newlength{\right@boxmargin}
\newlength{\answerbox@width}
\setlength{\answerbox@width}{0.6\textwidth}


\newcommand{\LeftBoxMargin}[1]{\setlength{\left@boxmargin}{#1}}
  \newcommand{\RightBoxMargin}[1]{\setlength{\right@boxmargin}{#1}}
\newcommand{\AnswerBoxWidth}[1]{\setlength{\answerbox@width}{#1}}


\newenvironment{solutionorbox}[1][]%
{%
  \nopagebreak[3]
  \ifprintanswers
    \def\TheAnswer##1{%
      {\sc The Answer:}
      \begin{mdframed}[shadow=false,
        backgroundcolor=yellow!10,
        linecolor=blue,
        linewidth=0.2pt,
        ]%
        ##1
      \end{mdframed}%
    }
    \def\the@answer{\relax}
    \begingroup
    \Solution@Emphasis
    \begin{TheSolution}%
    \else
      \begin{mdframed}[shadow=true,
        linecolor=blue,
        linewidth=1pt,
        shadowcolor=black!40,
        leftmargin=\dimexpr\left@boxmargin\relax,
          rightmargin=\dimexpr\right@boxmargin\relax,
        ]%
        \par
        \penalty 0
        \def\v@space{#1}
        % \vspace*{#1}%
        \@answerlesstrue
        \setbox\z@\vbox\bgroup
        \ifprintsolutionkey
          \def\TheAnswer##1{%
            \egroup
            \def\the@answer{##1}
            \@answerlessfalse
            \setbox\z@\vbox\bgroup
          }% answer
        \else
          \def\TheAnswer##1{##1}% answer
        \fi
      \fi
    }{%
      \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
      \if@answerless
        \def\the@answer{}
      \fi
      \makenonemptybox{\v@space}{\dimexpr\answerbox@width}{\the@answer}%
      % \vspace*{\v@space}%
    \end{mdframed}%
  \fi
  \pagebreak[3]
}%

\newenvironment{prooforbox}[1][]%
{% 
  \nopagebreak[3]
  \ifprintanswers
    \def\TheAnswer##1{%
      {\sc The Answer:}
      \begin{mdframed}[shadow=false,
        backgroundcolor=yellow!10,
        linecolor=blue,
        linewidth=0.2pt,
        ]%
        ##1
      \end{mdframed}%
    }
    \def\the@answer{\relax}
    \begingroup
    \Solution@Emphasis
    \begin{TheProof}%
  \else
    \begin{mdframed}[shadow=true,
      linecolor=blue,
      linewidth=1pt,
      shadowcolor=black!40,
      leftmargin=\dimexpr\left@boxmargin\relax,
        rightmargin=\dimexpr\right@boxmargin\relax,
      ]%
      \par
      \penalty 0
      \def\v@space{#1}
      \@prooflesstrue
      % \vspace*{#1}%
      \setbox\z@\vbox\bgroup
    \fi
  }%
  {%
    \ifprintanswers
      \end{TheProof}
      \endgroup
    \else
      \egroup
      \if@answerless
        \def\the@answer{}
      \fi
      \makeproofbox{\v@space}{\dimexpr\answerbox@width}{\the@answer}%
      \end{mdframed}
    \fi
    \pagebreak[3]
  }%
% \newenvironment{solutionorbox}[1][]{\begin{mdframed}}{\end{mdframed}}


\newcommand{\solutiontitle}{\noindent\textbf{Solution:}\enspace}


\newenvironment{TheSolution}%
{%
  \begin{mdframed}[shadow=true, linecolor=red, linewidth=1pt,shadowcolor=black!40]%
    \solutiontitle
  }%
  {%
  \end{mdframed}%
}%
\newcommand{\prooftitle}{\noindent\textbf{Proof:}\enspace}  
\newenvironment{TheProof}%
{%
  \begin{mdframed}[shadow=true, linecolor=red, linewidth=1pt,shadowcolor=black!40]%
    \prooftitle
  }%
  {%
  \end{mdframed}%
}%

% Added 22 April 2004: Increased the \leftmargin by 2.5em,
% so the choices will be visibly indented.
\newenvironment{choices}%
{\list{\choicelabel}%
  {\usecounter{choice}\def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{W.\hskip\labelsep\hskip 2.5em}%
    \def\choice{%
      \if@correctchoice
        \endgroup
      \fi
    \item
    } % choice
    \def\CorrectChoice{%
      \if@correctchoice
        \endgroup
      \fi
      \ifnum\ifprintanswers 1\else\ifprintsolutionkey 1\else 0\fi\fi=1%
        \begingroup \@correctchoicetrue
      \fi
    \item
    } % CorrectChoice
    \let\correctchoice\CorrectChoice
    % \labelwidth\leftmargin\advance\labelwidth-\labelsep
    % \topsep=0pt
    % \partopsep=0pt
  }%
}%
{\if@correctchoice \endgroup \fi \endlist}


\newcommand{\CourseName}[1]{\def\course@name{#1}}
\newcommand{\AssignmentTitle}[1]{\def\assignment@title{#1}}

\newcommand{\FirstName}[1]{\def\first@name{#1}}
\newcommand{\LastName}[1]{\def\last@name{#1}}
\newcommand{\StudentId}[1]{\def\student@id{#1}}

\FirstName{}
\LastName{}
\StudentId{}

\newcommand{\makeheader}{%
  \hrule height .12cm%
  \vspace{.2in}\noindent%
  \hbox to 0.55\textwidth{\textbf{Name:}\enspace\hrulefill\raisebox{3pt}{\first@name}\ \raisebox{3pt}{\last@name}\hrulefill\enspace}%
  \hbox to 0.45\textwidth{\textbf{Student ID:}\enspace\hrulefill\raisebox{3pt}{\student@id}\hrulefill\enspace}\par%
  \vspace{.1in}%
  \hbox to \textwidth{\begin{small}{\textbf{\assignment@title}\hfill\textbf{\course@name}}\end{small}}%
  \vspace{1pt}%
  \hrule height .12cm}

\newcommand*{\CheckIfChanged@hlf}[2]{%
  % The first argument is the name of a half counter.
  % The second argument expands to the name (without the escape
  % character, and not assumed to be defined) of the control sequence
  % holding the previous value.
  \@ifundefined{#2}%
  {\global\@pointschangedtrue}%
  {%
    % OK; it's defined.  See if it's changed:
    \edef\f@o{\expandafter\csname #2\endcsname}
    \typeout{Name defined: #2, value: \f@o}
    \edef\b@r{\expandafter\csname the#1\endcsname}
    \typeout{Half counter: #1, value: \b@r}
    \ifx\f@o\b@r\typeout{Old/new points equal}\else\typeout{Old/enw points unequal, need to rerun.}\fi
  }%
}%


\AtEndDocument{%
  \clearpage
  \immediate\write\@mainaux
  {\string\gdef\string\exam@numpoints{%
      \thenumpoints}}%
  % See if this has changed from the last run of LaTeX:
  \CheckIfChanged@hlf{numpoints}{exam@numpoints}%
}

\endinput
