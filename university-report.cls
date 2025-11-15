\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{university-report}[2025/10/17 University Report Class]

\LoadClass[14pt]{extarticle}

% ==================================================
% ГЛОБАЛЬНЫЕ ПАРАМЕТРЫ ОФОРМЛЕНИЯ
% ==================================================
\newlength{\floatvspace}      \setlength{\floatvspace}{14pt}   % отступы вокруг рисунков
\newlength{\listingvspace}    \setlength{\listingvspace}{14pt}   % отступы вокруг lstlisting
\newlength{\tablevspace}      \setlength{\tablevspace}{12pt}    % отступы вокруг таблиц
\newlength{\sectionindent}    \setlength{\sectionindent}{1.25cm} % отступы подпунктов в Оглавлении
\newlength{\structskip}       \setlength{\structskip}{21pt}     % отступы структурных блоков (на будущее)

% ==================================================
% ПАКЕТЫ
% ==================================================
\RequirePackage{
  float, pdfpages, hyphenat, geometry, polyglossia, fontspec,
  amsmath, amssymb, setspace, titlesec, fancyhdr, graphicx, array,
  tabularx, caption, xcolor,  tocloft, enumitem, csquotes,
  xifthen, pgfplots, tikz, multirow, makecell, icomma, svg, parskip
}
\RequirePackage[newfloat]{minted}
\RequirePackage[most]{tcolorbox}
\RequirePackage{capt-of}
\RequirePackage{xstring}
\RequirePackage{etoolbox}
\RequirePackage{newfloat}
\pgfplotsset{compat=1.18}
\MakeOuterQuote{"}
% ==================================================
% Совместимость PGF с matplotlib
% ==================================================
\makeatletter
\providecommand{\mathdefault}[1]{#1}
\makeatother
% ==================================================
% ЯЗЫКИ
% ==================================================
\setmainlanguage{russian}
\setotherlanguage{english}

% ==================================================
% ШРИФТЫ
% ==================================================
\setmainfont{Times New Roman}
\newfontfamily\cyrillicfont{Times New Roman}

\setmonofont{Fira Code}[Scale=0.9]
\newfontfamily\cyrillicfonttt{Fira Code}[Scale=0.9,Script=Cyrillic]

% ==================================================
% ПОЛЯ
% ==================================================
\geometry{
  a4paper,
  top=2cm,
  bottom=2cm,
  left=3cm,
  right=1.5cm,
  headheight=0pt,
  headsep=0pt
}

% ==================================================
% МЕЖСТРОЧНЫЙ И АБЗАЦНЫЙ ОТСТУП
% ==================================================
\onehalfspacing
\setlength{\parindent}{1.25cm}
\setlength{\topskip}{0pt}

% ==================================================
% КОЛОНТИТУЛЫ
% ==================================================
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyfoot[C]{\fontsize{12pt}{12pt}\selectfont \thepage}

% ==================================================
% ЗАГОЛОВКИ РАЗДЕЛОВ
% ==================================================
\titleformat{\section}
  {\centering\bfseries\fontsize{14pt}{16pt}\selectfont}
  {\thesection.}
  {1em}
  {}
  [\vspace{0pt}]

% ==================================================
% ОГЛАВЛЕНИЕ
% ==================================================
\renewcommand{\cfttoctitlefont}{\hfill\fontsize{14pt}{16pt}\bfseries\selectfont\MakeUppercase}
\renewcommand{\cftaftertoctitle}{\hfill}

\renewcommand{\cftbeforesecskip}{0pt}
\renewcommand{\cftbeforesubsecskip}{0pt}
\renewcommand{\cftbeforesubsubsecskip}{0pt}

\AtBeginDocument{
  \addtocontents{toc}{\protect\setstretch{1.5}}
}
\renewcommand{\cftdot}{.}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdot}}

\setlength{\cftsecindent}{0pt}
\setlength{\cftsubsecindent}{\sectionindent}

\renewcommand{\cftsecfont}{\bfseries\fontsize{14pt}{16pt}\selectfont}
\renewcommand{\cftsubsecfont}{\bfseries\fontsize{14pt}{16pt}\selectfont}

\renewcommand{\cftsecpagefont}{\bfseries\fontsize{14pt}{16pt}\selectfont}
\renewcommand{\cftsubsecpagefont}{\bfseries\fontsize{14pt}{16pt}\selectfont}

% ==================================================
% ПОДПИСИ
% ==================================================
\DeclareCaptionLabelSeparator{emdash}{\space\textendash\space}
\DeclareCaptionFont{captionfont}{\fontsize{12pt}{12pt}\selectfont}

\addto\captionsrussian{
  \renewcommand{\figurename}{Рисунок}
  \renewcommand{\tablename}{Таблица}
  \renewcommand{\listingname}{Листинг}
}

\captionsetup[listing]{
  labelsep=emdash,
  font=captionfont,
  justification=raggedright,
  singlelinecheck=false,
  aboveskip=0pt,
  belowskip=0pt
}

\captionsetup[figure]{
  labelsep=emdash,
  font=captionfont,
  aboveskip=12pt,
  belowskip=0pt
}

\captionsetup[table]{
  position=above,
  labelsep=endash,
  justification=raggedright,
  font=captionfont,
  skip=6pt
}

% --- ЛИСТИНГИ MINTED ---
\setlength{\intextsep}{\listingvspace}
\setlength{\textfloatsep}{\listingvspace}
\setlength{\floatsep}{\listingvspace}
\floatname{listing}{Листинг}
\newenvironment{longlisting}{\captionsetup{type=listing}}{}
\newenvironment{code}[3]
{%
	\VerbatimEnvironment
	\begin{longlisting}%
	\label{lst:#3}%
	\caption{#2}%
  \nopagebreak%
	\begin{minted}{#1}%
	}
	{%
	\end{minted}%
	\end{longlisting}%
}


\newenvironment{lst}[3]
{%
  \VerbatimEnvironment
  \vspace{14pt}
  \begin{tcolorbox}[breakable,
                    colback=white,
                    colframe=white,
                    boxrule=0pt,
                    frame hidden,
                    left=0pt,
                    right=0pt,
                    top=0pt,
                    bottom=0pt,
                    sharp corners,
                    enhanced,
                    before skip = 0pt,
                    after skip = 0pt,
                    attach boxed title to top center={yshift=0mm}]%
    \begin{code}{#1}{#2}{#3}%
}
{%
    \end{code}%
  \end{tcolorbox}%
  \vspace{14pt}
}
\renewcommand{\theFancyVerbLine}{\textcolor{black}{\fontsize{8}{12}\selectfont\ttfamily\fontspec{Fira Code}\arabic{FancyVerbLine}}}
\setminted{
  fontsize=\fontsize{10pt}{12pt}\selectfont,           % Размер шрифта
  baselinestretch=1.0,       % Межстрочный интервал
  linenos=true,
  numbersep=2pt,             % Отступ номеров от кода
  xleftmargin=10pt,          % Левый отступ кода
  frame=leftline,            % Рамка (lines, leftline, none)
  framesep=2pt,              % Отступ рамки от кода
  rulecolor=black,           % Цвет рамки
  breaklines=true,           % Перенос длинных строк
  breakautoindent=true,      % Автоотступ при переносе
  tabsize=4,                 % Размер табуляции
  showspaces=false,          % Показывать пробелы
  showtabs=false,            % Показывать табы
  autogobble=true,
  listparameters={\setlength{\topsep}{0pt}\setlength{\partopsep}{0pt}}
}

% ==================================================
% ИЗОБРАЖЕНИЯ
% ==================================================
\newcommand{\insertimage}[4][1]{%
  \vspace{\floatvspace}
  \begin{figure}[H]
    \centering
    \includegraphics[scale=#1]{#2}
    \caption{#3}
    \label{#4}
  \end{figure}
  \vspace{\floatvspace}
}

% ==================================================
% СПИСКИ
% ==================================================
\setlist{nosep, topsep=0pt, itemsep=0pt, parsep=0pt}

\setlist[itemize]{
  label=\textendash,
  labelsep=0.35em,
  labelwidth=0.6em,
  leftmargin=!,
  itemindent=0pt,
  listparindent=0pt
}

\setlist[enumerate]{
  label=\arabic*.,
  leftmargin=1.25cm,
  labelsep=0.5em
}

% ==================================================
% ТАБЛИЦЫ
% ==================================================
\newcolumntype{Y}{>{\centering\arraybackslash}X}
\newcolumntype{C}[1]{>{\centering\arraybackslash}m{#1}}

\newenvironment{csvtable}[3][]{%
  \vspace{\tablevspace}
  \begin{adjustbox}{max width=\textwidth,#1}
    \renewcommand{\arraystretch}{1.5}
    \fontsize{12pt}{14pt}\selectfont
    \setlength{\tabcolsep}{4pt}
    \begin{tabular}{|C{1.5cm}|C{1.5cm}|C{1.5cm}|C{1.5cm}|C{1.5cm}|}
      \hline
      #3 \\ \hline
      \csvreader[
        head to column names,
        late after line=\\\hline,
        late after last line=\\\hline
      ]{#2}{}%
      {%
        \csvcoli & \csvcolii & \csvcoliii & \csvcoliv & \csvcolv
      }
}{%
    \end{tabular}
  \end{adjustbox}
  \vspace{\tablevspace}
}

% ==================================================
% ПРОЧЕЕ
% ==================================================
\frenchspacing
\sloppy
\hyphenpenalty=10000

\floatname{lstfloat}{Listing}
\def\lstfloatautorefname{Listing}
