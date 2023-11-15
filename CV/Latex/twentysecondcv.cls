\ProvidesClass{twentysecondcv}[2017/01/08 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%----------------------------------------------------------------------------------------
%	 REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T5,T1]{fontenc}
\RequirePackage[vietnamese]{babel}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}
\RequirePackage{anyfontsize}
\RequirePackage{enumitem}
\RequirePackage{fontawesome}
\RequirePackage{bm}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{changepage}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%----------------------------------------------------------------------------------------
%	 COLOURS
%----------------------------------------------------------------------------------------

\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{maingray}{HTML}{B9B9B9}

%----------------------------------------------------------------------------------------
%	 MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

\renewcommand{\bfseries}{\color{gray}} % Make \textbf produce coloured text instead

\pagestyle{empty} % Disable headers and footers

\setlength{\parindent}{0pt} % Disable paragraph indentation

%----------------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Define a new length to hold the remaining line width after the section title is printed
\newlength{\SectionTitleLength} % Define a new length to hold the width of the section title
\newcommand{\profilesection}[1]{%
	\setlength\TotalSectionLength{\linewidth}% Set the total line width
	\settowidth{\SectionTitleLength}{\huge #1 }% Calculate the width of the section title
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Subtract the section title width from the total width
	\addtolength\TotalSectionLength{-2.22221pt}% Modifier to remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{black!80} \huge #1 \rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print the title and auto-width rule
}

% Define custom commands for CV info
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, fill=mainblue,mainblue,text=white] (char) {#1};}}

% Command for printing skill progress bars
\newcommand\skills[1]{ 
	\renewcommand{\skills}{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}{
				\draw[fill=maingray,maingray] (0,\i) rectangle (6,\i+0.4);
				\draw[fill=white,mainblue](0,\i) rectangle (\y,\i+0.4);
				\node [above right] at (0,\i+0.4) {\x};
			}
		\end{tikzpicture}
	}
}

% Command for printing skills text
\newcommand\skillstext[1]{ 
	\renewcommand{\skillstext}{
		\begin{flushleft}
			\foreach [count=\i] \x/\y in {#1}{ 
				\x$ \star $\y
			}
		\end{flushleft}
	}
}

%----------------------------------------------------------------------------------------
%	 SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\makeprofile}{
	\begin{tikzpicture}[remember picture,overlay]
   		\node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
	\end{tikzpicture}

	%------------------------------------------------

	\begin{textblock}{6}(0.5, 0.2)
			
		%------------------------------------------------
		\ifthenelse{\equal{\profilepic}{}}{}{
			\begin{center}
				\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
					\clip (600/2, 567/2) circle (567/2);
					\node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
				\end{tikzpicture}
			\end{center}
		}

		%------------------------------------------------

		{\fontsize{23}{27}\selectfont\color{mainblue}\cvname}

		%------------------------------------------------

		{\Large\color{black!80}\cvjobtitle}

		%------------------------------------------------

		\renewcommand{\arraystretch}{2}
		\begin{tabular}{p{0.5cm} @{\hskip 0.5cm}p{5cm}}
    \ifthenelse{\equal{\cvdate}{}}{}{\textsc{\fontsize{12pt}{14pt}\selectfont\icon{\faCalendar}} & \cvdate\\}
    \ifthenelse{\equal{\cvaddress}{}}{}{\textsc{\fontsize{14pt}{16pt}\selectfont\icon{\faMapMarker}} & \cvaddress\\}
    \ifthenelse{\equal{\cvnumberphone}{}}{}{\textsc{\fontsize{14pt}{16pt}\selectfont\icon{\faPhone}} & \cvnumberphone\\}
    \ifthenelse{\equal{\cvsite}{}}{}{\textsc{\fontsize{14pt}{16pt}\selectfont\icon{\faGlobe}} & \cvsite\\}
    \ifthenelse{\equal{\cvmail}{}}{}{\textsc{\fontsize{16pt}{18pt}\selectfont\icon{@}} & \href{mailto:\cvmail}{\cvmail}\\}
    \ifthenelse{\equal{\cvgithub}{}}{}{\textsc{\fontsize{14pt}{16pt}\selectfont\icon{\faGithub}} & \href{\cvgithub}{\cvgithub}\\}
\end{tabular}

		%------------------------------------------------
		
		\ifthenelse{\equal{\aboutme}{}}{}{
			\profilesection{About me}
			\begin{justify}
                \aboutme
                \end{justify}
		}

		%-----------------------------------------------

		
			
		%------------------------------------------------
			
	\end{textblock}
}

%----------------------------------------------------------------------------------------
%	 COLOURED SECTION TITLE BOX
%----------------------------------------------------------------------------------------

% Command to create the rounded boxes around the first three letters of section titles
\newcommand*\round[2]{%
	\tikz[baseline=(char.base)]\node[anchor=north west, draw,rectangle, rounded corners, inner sep=1.6pt, minimum size=5.5mm, text height=3.6mm, fill=#2,#2,text=white](char){#1};%
}

\newcounter{colorCounter}
\newcommand{\sectioncolor}[1]{%
	{%
		\round{#1}{
			\ifcase\value{colorCounter}%
			maingray\or%
			mainblue\or%
			maingray\or%
			mainblue\or%
			maingray\or%
			mainblue\or%
			maingray\or%
			mainblue\or%
 			maingray\or%
			mainblue\else%
			maingray\fi%
		}%
	}%
	\stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
	{%
		\color{gray}%
		\Large\sectioncolor{#1}%
	}
}

\renewcommand{\subsection}[1]{
	\par\vspace{.5\parskip}{%
		\large\color{gray} #1%
	}
	\par\vspace{.25\parskip}%
}

%----------------------------------------------------------------------------------------
%	 LONG LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the long list
\newenvironment{twenty}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{% 
	\end{tabular*}
}

\newcommand{\twentyitem}[4]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\textbf{#2}%
		\hfill%
		{\footnotesize#3}\\%
		#4\vspace{\parsep}%
	}\\
}

%----------------------------------------------------------------------------------------
%	 SMALL LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the small list
\newenvironment{twentyshort}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\twentyitemshort}[2]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\textbf{#2}%
	}\\
}

%----------------------------------------------------------------------------------------
%	 SKILLs
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

\newenvironment{myskills1}{%
    \begin{minipage}{0.5\textwidth}
        \skills{{System Analysis/4},{Modeling/4.8},{Communication and Collaboration/3},{Requirements Analysis/4.5}}
        \skills
    \end{minipage}%
    \begin{minipage}{0.5\textwidth}
        \begin{flushright}
            \skills{{Knowledge of Data Analysis/3.3},{Project Management/3.7},{Logical Thinking/2.5},{English/3.5}}
            \skills
        \end{flushright}
    \end{minipage}
    \vspace{0.2cm}
}{%
    % Lệnh chạy sau khi môi trường kết thúc (nếu cần)
}

%----------------------------------------------------------------------------------------
%	 Project
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

\newenvironment{project1}{%
{\Large Blockchain-based Ticketing Platform - BBB} \\
(10/2023 - Hiện tại) \par
\begin{tabular*}{\linewidth}{|>       {\raggedright\arraybackslash}p{3.5cm}|>{\raggedright\arraybackslash}p{9.45cm}|}
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Project Description & \hspace{0.3cm}The ticketing system consists of a website and a mobile\par
    \hspace{0.3cm}application that utilize blockchain technology for security\par
    \hspace{0.3cm}and electronic tickets.\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Number of members & \hspace{0.3cm}4 (1 BA, 2 Dev, 1 Designer)\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Job position & \hspace{0.3cm}Business Analyst\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Role in the project & \vspace{-0.3cm}\begin{itemize}[label=-, leftmargin=0.5cm, topsep=-0.3cm, partopsep=0cm]
                \item Market research on expense management and invoicing issues.
                \item Research and survey on event and ticketing issues.
                \item Charting.
                \item Database design and management.
                \item Project management.
            \end{itemize} \vspace{0.1cm}\\
    \hline
\end{tabular*}
}{%
    % Lệnh chạy sau khi môi trường kết thúc (nếu cần)
}

\newenvironment{project2}{%
{\Large Expense Management App} \\
(03/2023 - 06/2023) \par
\begin{tabular*}{\linewidth}{|>       {\raggedright\arraybackslash}p{3.5cm}|>{\raggedright\arraybackslash}p{9.45cm}|}
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Project Description & \hspace{0.3cm}Mobile application for remote financial management of \par
    \hspace{0.3cm}store owners. \vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Number of members & \hspace{0.3cm}4 (1 BA, 2 Dev, 1 Designer)\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Job position & \hspace{0.3cm}Business Analyst\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Role in the project & \vspace{-0.3cm}\begin{itemize}[label=-, leftmargin=0.5cm, topsep=-0.3cm, partopsep=0cm]
                \item Market research on expense management and invoicing issues.
                \item Requirement analysis, system design analysis.
                \item Charting.
                \item Database design and management.
                \item Project management.
            \end{itemize} \vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Technologies used & \hspace{0.3cm}VS Code, C\#, Winform, WPS, SQL, StarUml\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}GitHub & \vspace{-0.3cm}\begin{itemize}[label=-, leftmargin=0.5cm, topsep=-0.3cm, partopsep=0cm]
                \item \href{https://github.com/Bach293/Projects/blob/main/ExpenseManagementApp/BaoCao.pdf}{Report Link}
                \item \href{https://github.com/Bach293/Projects/tree/main/ExpenseManagementApp/DiagramUML}{DiagramUML Link}
                \item \href{https://github.com/Bach293/Projects/blob/main/ExpenseManagementApp/GiaiThuong.jpg}{Prize Link}
                \item \href{https://github.com/NguyenDucAnh1010/Expense-tracking.git}{Source Code \& Database Link}
            \end{itemize} \vspace{0.1cm}\\
    \hline
\end{tabular*}
}{%
    % Lệnh chạy sau khi môi trường kết thúc (nếu cần)
}

\newenvironment{project3}{%
{\Large Hospital Management System} \\
(02/2023 - 04/2023) \par
\begin{tabular*}{\linewidth}{|>       {\raggedright\arraybackslash}p{3.5cm}|>{\raggedright\arraybackslash}p{9.45cm}|}
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Project Description & \hspace{0.3cm}Mobile application for remote financial management of \par
    \hspace{0.3cm}store owners. \vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Number of members & \hspace{0.3cm}4 (1 BA, 3 Dev)\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Job position & \hspace{0.3cm}Business Analyst\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Role in the project & \vspace{-0.3cm}\begin{itemize}[label=-, leftmargin=0.5cm, topsep=-0.3cm, partopsep=0cm]
                \item Research and survey hospitals along with their operations.
                \item Requirement analysis, system design analysis.
                \item Charting.
                \item Database design and management.
                \item Project management.
            \end{itemize} \vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Technologies used & \hspace{0.3cm}VS Code, C\#, Winform, WPS, SQL, StarUml\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}GitHub & \vspace{-0.3cm}\begin{itemize}[label=-, leftmargin=0.5cm, topsep=-0.3cm, partopsep=0cm]
                \item \href{https://github.com/Bach293/Projects/blob/main/HospitalManagementSystem/Bao_cao.pdf}{Report Link}
                \item \href{https://github.com/Bach293/Projects/tree/main/HospitalManagementSystem/DiagramUml}{DiagramUML Link}
            \end{itemize} \vspace{0.1cm}\\
    \hline
\end{tabular*}
}{%
    % Lệnh chạy sau khi môi trường kết thúc (nếu cần)
}

\newenvironment{project4}{%
{\Large Project Magagement - Ticket Sales Website} \\
(09/2023 - 10/2023) \par
\begin{tabular*}{\linewidth}{|>       {\raggedright\arraybackslash}p{3.5cm}|>{\raggedright\arraybackslash}p{9.45cm}|}
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Project Description & \hspace{0.3cm}Managing the Ticket Sales Website project with the \par
    \hspace{0.3cm}following criteria: overall, scope, cost, quality, time, \par
    \hspace{0.3cm}resources, risks. \vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Number of members & \hspace{0.3cm}1 (PM)\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Job position & \hspace{0.3cm}Project Manager\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Role in the project & \vspace{-0.3cm}\begin{itemize}[label=-, leftmargin=0.5cm, topsep=-0.3cm, partopsep=0cm]
                \item Research and survey on event and ticketing issues.
                \item Project management.
            \end{itemize} \vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}Technologies used & \hspace{0.3cm}Latex, Canva\vspace{0.1cm}\\
    \hline
    \rule{0pt}{0.4cm}\hspace{0.1cm}GitHub & \vspace{-0.3cm}\begin{itemize}[label=-, leftmargin=0.5cm, topsep=-0.3cm, partopsep=0cm]
                \item \href{https://github.com/Bach293/Latex/blob/main/ProjectMagagement-TicketSalesWebsite/BaoCao.pdf}{Report Link}
                \item \href{https://github.com/Bach293/Latex/tree/main/ProjectMagagement-TicketSalesWebsite/Latex}{Latex Link}
            \end{itemize} \vspace{0.1cm}\\
    \hline
\end{tabular*}
}{%
    % Lệnh chạy sau khi môi trường kết thúc (nếu cần)
}
%----------------------------------------------------------------------------------------
%	 MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\RequirePackage[left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}

\RequirePackage{hyperref}
