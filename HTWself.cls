
%    +=================================================+
%    |    LaTeX class file                             |
%    +=================================================+
%    |    Name:         HTWself 		               |
%    |                                                 |
%    |    Purpose: 	    Anwendung für Hochschulalltag  |
%    |                                                 |
%    |    Created:      2022                           |
%    |                                                 |
%    |    Usage note:	Erstellt auf der Basis des     |
%    |                  Templates 'HTW Template' von   |
%    |                  Abdullah Bassem Peter Al Jamal |
%    +=================================================+


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{HTWself}[2022/28/03 general purpose]


\RequirePackage{HTWColor}
%\RequirePackage{HTWMath} %funktioniert nicht mit moderncv!!! wird in exam geladen
\RequirePackage{ifthen}


%optionsspezifische Werte:
\colorlet{cv}{HTWBlue100}
\colorlet{exam}{HTWGreen100}

%Art des Dokumentes:
\def\type{}
\def\empty{}
\DeclareOption{exam}{\newcommand{\Catcolor}{\color{exam}} \def\type{exam}}
\DeclareOption{cv}{
\ifx\type\empty
 \newcommand{\Catcolor}{\color{cv}} \def\type{cv}
\else
 \ClassError{HTWself}{Es kann in dieser Klasse nur eine Option angegeben werden!}
\fi
}

%Erlaube alle Optionen der Basisklasse:
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{
\ifthenelse{\equal{\type}{exam}}{labbook}{moderncv}
}}

\DeclareOption*{\ClassWarningNoLine{HTWself}{Die Option ‘\CurrentOption’ ist fuer diese Klasse nicht definiert!}}


%Wende Eingaben an:
\ProcessOptions\relax

\ifx\type\empty
 \ClassError{HTWself}{Es muss die Art des Dokuments angegeben werden!}{
 Arten des Dokumentes: [exam][cv]}
\fi



%=====================================================%
% Basisklasse und Grundeinstellungen des Dokumentes:  %
%=====================================================%


\ifthenelse{\equal{\type}{exam}}
{%exam:
\LoadClass[
    a4paper,
    oneside,
    hyperref,
    11pt
    ]{labbook}
    
	% !! special behavior for this document class !!
	\RequirePackage[
	%    headtopline,
	    headsepline=1mm
	%    footsepline,
	%    footbotline
	    ]{scrlayer-scrpage}
	\pagestyle{scrheadings}
	
	\clearscrheadfoot
	    \ihead{\normalfont\color{HTWGreen100} \docTitle}
	    \chead{}
	    \ohead{\normalfont\color{HTWGreen100}Kapitel \headmark}
	    \ifoot{}
	    \cfoot{\normalfont\bfseries\color{HTWGreenDark} Seite \thepage}
	    \ofoot{}
	\setkomafont{headsepline}{\color{HTWGreen100}}


	%Links
	\RequirePackage{hyperref}
	\hypersetup{
	pdfborder = {0 0 0},
	colorlinks=true,
	linkcolor=HTWGreenDark,
	urlcolor=HTWBlue100!80!black,
	citecolor=red!80!black,
	pdfhighlight=/O,
	pdftitle={Einführung in die lineare Algebra},
	pdfauthor={Christopher Borchardt}}
%	}
	
	%Doc-Darstellung wie Rand, Head, Foot, etc.:
	\RequirePackage[
	a4paper,
	headsep=1.5cm,
	top=5cm,bottom=4cm,
	]{geometry}
	
	%Font:
	\RequirePackage[abspath]{currfile}%Liest den Pfad vom record-file (.fls)->record-option muss aktiviert sein
	\RequirePackage{fontspec}
	\setmainfont{HTWBerlinOffice}[
	Path = \currfileabsdir font/HTWBerlinOffice/,
	Extension = .ttf,
	UprightFont = *-Regular,
	BoldFont = *-Bold,
	ItalicFont = *-Italic,
	BoldItalicFont = *-BoldItalic
	]	    
   
   \RequirePackage{HTWMath}
}
{%cv:
\LoadClass[
    a4paper,
%    hyperref,
    11pt
    ]{moderncv}

	%Doc-Darstellung wie Rand, Head, Foot, etc.:
	\RequirePackage[a4paper]{geometry}

	\RequirePackage{lmodern}	
	\RequirePackage{mathptmx}
    \RequirePackage[default]{raleway}
    \RequirePackage{colortbl}  
}

\setlength{\parindent}{0pt}


%=====================================================%
% Gemeinsame Pakete der Optionen:                     %
%=====================================================%


%\RequirePackage[T1]{fontenc}    %in xelatex obsolet
%\RequirePackage[utf8]{inputenc} %in xelatex obsolet
\RequirePackage[ngerman]{babel}

\RequirePackage{moresize}

\RequirePackage{multido}
\RequirePackage{amsmath}
\RequirePackage{amssymb}

%Packages zum Laden von Bildern und Graphiken:
\RequirePackage{graphicx}
\RequirePackage{pstricks}
\RequirePackage{auto-pst-pdf}

%Packages zum Laden von Files innerhalb von Tags mit \ExecuteMetaData[file.tex]{tag}:
%Tag muss folgend aussehen: %<*tag> ... %</tag>
\RequirePackage{catchfilebetweentags}

%Package zum Laden von Anhängen:
\RequirePackage{pdfpages}

%Bgnd/Fgnd für Bilder:
\RequirePackage{eso-pic}

%Text-Wrap:
\RequirePackage{wrapfig}

\RequirePackage{blindtext}
\RequirePackage{listings}



%=====================================================%
% Erstelle Überschriften:                             %
%=====================================================%

\ifthenelse{\equal{\type}{exam}}{
	\RequirePackage[nobottomtitles]{titlesec}
	
	\titleformat{\chapter}[block]
	{\bfseries\Huge\color{HTWGreen100}}
	{
	 \hskip-10mm
	 \psset{xunit=0.25cm,yunit=0.25cm}
	 \begin{pspicture}[showgrid=false](0,0)(30,5)
	  \rput[cB](9,7.5){\normalsize Kapitel \thechapter .}
	  \psset{
	  linewidth=1mm,
	  linecolor=HTWGreen100  
	  }
	  \psline(5.5,7.7)(3.5,7.7)(3.5,2)(15,2)
	 \end{pspicture}
	 \vskip-20mm
	}{0.5em}{}[]
	
	\titleformat{\section}[hang]
	{\bfseries\huge\color{HTWGreenDark}}
	{\thesection}{0.5em}{}
	
	\titleformat{\subsection}[hang]
	{\bfseries\Large\color{HTWGreenDark}}
	{\thesubsection}{0.5em}{}
	
	\titleformat{\subsubsection}[hang]
	{\normalfont\bfseries\large\color{HTWGreenDark}}
	{\thesubsubsection}{0.5em}{}
}{}

%=====================================================%
% Initialisierung der Variablen des Dokumentes:       %
%=====================================================%

\newcommand{\HTWTitle}[1]{ \def \docTitle{#1} }
\HTWTitle{}

\newcommand{\HTWSubtitle}[1]{ \def \docSubtitle{#1} }
\HTWSubtitle{}

\newcommand{\HTWReference}[1]{ \def \docReference{#1} }
\HTWReference{}

\newcommand{\HTWIssueDate}[1]{ \def \docIssueDate{#1} }
\HTWIssueDate{}
\HTWIssueDate{Berlin, \today}


\def \empty{}

\ifthenelse{\equal{\type}{exam}}{
	\makeatletter

	\def \HTWStudentCount{0}
	\newcommand{\HTWStudent}[4]{%firstname, lastname, matrikelnum, mail
	 \FPinc{\HTWStudentCount}
	 
	 \expandafter\def\csname firstname\HTWStudentCount\endcsname{#1}
	 \expandafter\def\csname lastname\HTWStudentCount\endcsname{#2}
	 \expandafter\def\csname matrikel\HTWStudentCount\endcsname{#3}		  
	 
	 \ifthenelse{\equal{#4}{\empty}}{
	 	 \ifthenelse{\equal{#3}{\empty}}
		 {\expandafter\def\csname mail\HTWStudentCount\endcsname{/}}
		 {\expandafter\def\csname mail\HTWStudentCount\endcsname{#3@htw-berlin.de}}
	 }{
	 	 \expandafter\def\csname mail\HTWStudentCount\endcsname{#4}
	 }
	}
	
	\newcommand{\HTWReviewer}[1]{ \def \docReviewer{#1} }
	\HTWReviewer{}
	
	\newcommand{\HTWCourse}[1]{ \def \docCourse{#1} }
	\HTWCourse{}
}{
	\newcommand{\HTWJobname}[1]{ \def \docJobname{#1} }
	\HTWJobname{<Beruf>}
	
	\newcommand{\HTWSignature}[2]{
		\ifthenelse{\equal{#1}{\empty}}{\def\signatureScale{1}}{\def\signatureScale{1}} 
		\def \signature{#2}
	}
	\HTWSignature{0.5}{ModernCV/fig/Signatur.png}
	
	\def \HTWAttachmentCount{0}
	\newcommand{\HTWAttachment}[3]{
	\fpAdd{1}{\HTWAttachmentCount}{\HTWAttachmentCount}%aus package multido
	 
	 \expandafter\def\csname attachmentname\HTWAttachmentCount\endcsname{#1}
	 \expandafter\def\csname attachmentpath\HTWAttachmentCount\endcsname{#2}	 
	 \expandafter\def\csname attachmenttype\HTWAttachmentCount\endcsname{#3}
	}
	\newcommand{\HTWTexAttachmentTag}[1]{ \def \texAttachmentTag{#1} }
	\HTWTexAttachmentTag{}
	
	\newcommand{\HTWAttachmentHeight}[1]{\ifthenelse{\equal{#1}{\empty}}
	{\def\attachmentHeight{1\paperheight}}
	{\def \attachmentHeight{#1\paperheight}}}
	\HTWAttachmentHeight{}
	
	\newcommand{\HTWAttachmentAngle}[1]{ \def \attachmentAngle{#1}}
	\HTWAttachmentAngle{0}
	
}


%initialisiere CV:
\ifthenelse{\equal{\type}{cv}}{
	\moderncvstyle{casual}
	%\setlength{\hintscolumnwidth}{3cm}
	\moderncvcolor{blue}
	
	\HTWTitle{Bewerbung}	
	\HTWSubtitle{Um den Ausbildungsplatz als}	
	
	\firstname{Christopher}
	\familyname{Borchardt}
	\title{curriculum vitae}
	\address{Musterstr.03}{12999 Berlin}
	\mobile{0176 34625732}
	%\phone{xxx}
	\email{s0549085@htw-berlin.de}
	\setlength{\fboxsep}{0pt}
	\photo[0cm]{ModernCV/fig/photo.jpg}
}{}


%======================================================%
% Hintergrund des Deckblattes:                         %
%======================================================%

\newcommand{\createBG}{
%%Altes Design:
%\ifthenelse{\equal{\type}{cv}}{
%\AddToShipoutPictureBG*{
%\AtPageLowerLeft{\color{HTWGreen100}\rule{0.71\paperwidth}{0.8\paperheight}
%}}
%\AddToShipoutPictureBG*{
%\AtPageLowerLeft{
% \color{HTWGreen100}\rule{0.7\paperwidth}{0.8\paperheight}
% \includegraphics[height = 0.8\paperheight , keepaspectratio = true]{pspictures/figures/logo/pict_sideways}}}
%}{ 
\ifthenelse{\equal{\type}{exam}}{
\AddToShipoutPictureBG*{
\AtPageLowerLeft{
\includegraphics[height = \paperheight , keepaspectratio = true]{pspictures/BG1.pdf}%Hintergrund separat erstellt
}}
}
%}
}


%======================================================%
% Commands, die das Dokument generieren:               %
%======================================================%

\newcommand{\makebig}[1]{\ifthenelse{\equal{\type}{exam}}{\color{HTWGreenDark}}{\color{HTWBlue100!50!black}}\textbf{#1:}\\}
\newenvironment{HTWdefList}
{\begin{list}
       {}%default Label
       {       
       \labelwidth=3cm
       \leftmargin=3.5cm
       \itemindent=0cm
       \let\makelabel=\makebig
       }
}
{\end{list}}

\newenvironment{HTWBulletList}
{\begin{list}
       {$\Catcolor\blacksquare$}%default Label
       {
       \labelsep=0.75cm  
       \leftmargin=1.5cm     
       }
}
{\end{list}}

\ifthenelse{\equal{\type}{cv}}{
	\newenvironment{titlepage}{\setcounter{page}{0}\thispagestyle{empty}}{\newpage}
	
	\newcommand{\HTWCV}{	
	\input{ModernCV/parts/Lebenslauf}
%	\input{ModernCV/parts/Ergaenzungen}	
	\label{lastpage}    %	muss zusätzlich eingefügt werden, anscheinend liegt bug vor und
						%	anderweitig Seitenzahlen im Dokument nicht ausgegeben
	}
	
	\newcommand{\HTWmakecvtitle}{
	%Ergänzung:
	%Wenn kein Photo angegeben wird, dann setze irgend ein Bild aus den Logos ein und setze die Größe auf Null!
	\makeatletter
	\ifx\@photo\empty
	\setlength{\fboxsep}{0pt}
	\photo[0cm]{pspictures/figures/logo/logo_long}
	\fi
	\makeatother
	\makecvtitle
	}
	
	\def\curTexAttachment{}
		
	\newcommand{\HTWIncludeAttachmentByPath}[2]{
        \ifthenelse{\equal{#1}{pdf}}
        {\includepdf{#2}}{}
        \ifthenelse{\equal{#1}{tex}}
        {
         \CatchFileBetweenTags{\curTexAttachment}{#2}{\texAttachmentTag}
         \newpage
         \pagestyle{empty}         
         \ifx\curTexAttachment\empty
         \input{\attachmentpath}
         \else
         \ExecuteMetaData[#2]{\texAttachmentTag}
         \newpage
         \fi
         \pagestyle{plain}         
        }{}
        \ifthenelse{\equal{#1}{png}\OR\equal{#1}{jpg}}
        {\clearpage
        %\newpage
		\newgeometry{top=0cm, bottom=0cm, left=0cm, right=0cm}
		\begin{center}
        \includegraphics[height=\attachmentHeight, angle=\attachmentAngle, clip, keepaspectratio=true]{#2}		
		\end{center}
        \restoregeometry
        }{}		
	}
	\newcommand{\HTWIncludeAttachments}{
	\ifthenelse{\equal{\HTWAttachmentCount}{0}}{}
    {    
        \multido{\nX=1+1}{\HTWAttachmentCount}{
        \def\attachmenttype{\csname attachmenttype\nX\endcsname}
        \def\attachmentpath{\csname attachmentpath\nX\endcsname}
		\HTWIncludeAttachmentByPath{\attachmenttype}{\attachmentpath}
        }
    }
	}
	\newcommand{\HTWIncludeAttachmentByName}[1]{
	\ifthenelse{\equal{\HTWAttachmentCount}{0}}{}
    { 
	    \multido{\nX=1+1}{\HTWAttachmentCount}{
        \ifthenelse{\equal{\csname attachmentname\nX\endcsname}{#1}}{
	        \def\attachmenttype{\csname attachmenttype\nX\endcsname}
	        \def\attachmentpath{\csname attachmentpath\nX\endcsname}
			\HTWIncludeAttachmentByPath{\attachmenttype}{\attachmentpath}        
        }{}
        }
    }
	}
	\newcommand{\HTWIncludeAttachment}[1]{\HTWIncludeAttachmentByName{#1}}
}{
	\newcommand{\HTWListsOfx}{
	    \setcounter{tocdepth}{1}
	    \tableofcontents
	    \addcontentsline{toc}{section}{Contents}
	}
	
	 %Number->ASCII:
	 \newcommand{\getLetter}[1]{
	 \symbol{
	 \numexpr#1+65
	 }}	
	
	%Schachbrett:
	\newcommand{\HTWChecker}[5]{
		
     %-----------------Handles------------------%
	 \colorlet{darkStartTile}{#1}
	 \colorlet{darkEndTile}{#2}
	 \colorlet{lightTile}{white}
	 \def\nXlen{#3}
	 \def\nYlen{#4}
	 
	 %-------------------Code-------------------%
	 %Checke korrekte Eingabe:
	 \ifthenelse{\isBigger{\nXlen}{26}}{\errmessage{Fehler: Die Breite kann nicht größer als 26 sein!}}{} 
	 \ifthenelse{\isNegative{\nXlen}\OR\isNegative{\nYlen}}{\errmessage{Fehler: Keine negativen Feldangaben möglich!}}{} 

	 %----------Erstelle Schachfeld-------------% 
	 \def\nSw{0}
	 \def\nSwe{0}	 	
	 \def\nXStep{0} \FPeval{\nXStep}{round(50 / (#3-1):2)}
	 \def\nYStep{0} \FPeval{\nYStep}{round(50 / (#4-1):2)}
	 \def\nXhlen{0} \FPeval{\nXhlen}{clip(\nXlen / 2)}
	 
	 \ifthenelse{\equal{#5}{\empty}}
	 {\begin{pspicture}(0,0)(#3,#4)}{
	 \newlength{\XBound} \setlength{\XBound}{#3\psxunit} \addtolength{\XBound}{0.5\psxunit}
	 \newlength{\YBound} \setlength{\YBound}{#4\psyunit} \addtolength{\YBound}{0.5\psyunit}
     \begin{pspicture}(-0.5,-0.5)(\XBound,\YBound)}
	 \psset{fillstyle=solid, linewidth=0}
	 \psframe[fillcolor=lightTile](0,0)(\nXlen, \nYlen)
	 \multido{\nY=0+1, \nYe=1+1, \nYFac=0+\nYStep}{\nYlen}%Reminder: multido akzeptiert KEINE Leerzeilen!!!
	 {
	  \FPeval{\nSw}{\FPmod{\nY}{2}}
	  \FPeval{\nSwe}{\nSw + 1}
	  \multido{\nX=\nSw+2, \nXe=\nSwe+2, \nXFac=0+\nXStep}{\nXhlen}
	  {\FPeval{\nFac}{\nXFac + \nYFac}
	  \psframe[fillcolor=darkEndTile!\nFac!darkStartTile](\nX, \nY)(\nXe, \nYe)}
	 }
	 
	 \ifthenelse{\equal{#5}{\empty}}{}{
	 %----------Erstelle Kennzeichnung-----------%
	 \def\nXs{0}
	 \def\nXos{0}
	 \def\nXe{0}
	 \def\nXoe{0}
	 \def\Xc{0}
	 
	 \def\nYs{0}
	 \def\nYos{0}
	 \def\nYe{0}  
	 \def\nYoe{0}  
	 \def\Yc{0}
	 
	 \psset{linewidth=0.05\psxunit,linecolor=black,fillstyle=none}
	  
	 %--------------top/bottom-line--------------%
	 \def\nYs{-0.525}
	 \def\nYe{0.025}
	 \FPeval{\nYos}{\nYlen - 0.025}
	 \FPeval{\nYoe}{\nYlen + 0.525}  
	 \FPeval{\nYc}{\nYlen + 0.25}  
	 
	 \multido{\nX=0+1}{\nXlen}
	 {
	  \FPeval{\nXs}{\nX - 0.025}
      \FPeval{\nXe}{\nX + 1.025}
      \FPeval{\nXc}{\nX + 0.45} 
	  \psframe(\nXs, \nYs)(\nXe, \nYe) \rput(\nXc,-0.25){\getLetter{\nX}}
	  \psframe(\nXs, \nYos)(\nXe, \nYoe)
	  \FPeval{\nXc}{\nXc + 0.1} \rput{180}(\nXc,\nYc){\getLetter{\nX}} 	  
	 }
	 
	 %-------------left/right-line---------------%
	 \def\nXs{-0.525}
	 \def\nXe{0.025}
	 \FPeval{\nXos}{\nXlen - 0.025}
	 \FPeval{\nXoe}{\nXlen + 0.525}  
	 \FPeval{\nXc}{\nXlen + 0.25}  
	  
	 \multido{\nY=1+1}{\nYlen}
	 {
	  \FPeval{\nYs}{\nY - 1.025}
  	  \FPeval{\nYe}{\nY + 0.025}
 	  \FPeval{\nYc}{\nY - 0.55}
	  \psframe(\nXs, \nYs)(\nXe, \nYe)
	  \rput(-0.25,\nYc){\nY} 
	  \psframe(\nXos, \nYs)(\nXoe, \nYe)
	  \rput{180}(\nXc,\nYc){\nY}
	 } 
	 
	 %------------------Ecken--------------------%
	 \def\nYo{0} 
	 \multido{\nY=0+1}{2}
	 {
	  \FPeval{\nYs}{clip((\nYlen + 0.5) * \nYo - 0.525)}
	  \FPeval{\nYe}{clip((\nYlen + 0.5) * \nYo + 0.025)}
	  \def\nXo{0}  
	  \multido{\nX=0+1}{2}{
	   \FPeval{\nXs}{clip((\nXlen + 0.5) * \nXo - 0.525)}
	   \FPeval{\nXe}{clip((\nXlen + 0.5) * \nXo + 0.025)} 
	   \psframe(\nXs, \nYs)(\nXe, \nYe)
	   \psline(\nXs, \nYs)(\nXe, \nYe)
	   \psline(\nXe, \nYs)(\nXs, \nYe)
	   \FPinc{\nXo}   
	  }
	  \FPinc{\nYo}
	 }} 
	 \end{pspicture}		
	}
}

%Hilftext:
\newcommand{\help}[1]{
\clearpage
\ExecuteMetaData[HTWself_manual.tex]{#1}
\newpage
}
\newcommand{\h}{\help{mainpart}}


% center without vspaces
\newenvironment{novspacecenter}
{\parskip=0pt\par\nopagebreak\centering}
{\par\noindent\ignorespacesafterend}


%======================================================%
% Boxen:                                               %
%======================================================%

%Basis
\newsavebox\HTWbox
\newlength{\HTWbX}
\newlength{\HTWbY}
\newcommand{\createHTWbox}[2]{
\def\txtscale{#1}
\FPeval{\txtscale}{\txtscale - 0.075}
\savebox{\HTWbox}[#1\textwidth][c]{
\raisebox{0.25cm}{
\begin{minipage}[c]{\txtscale\textwidth}
#2
\end{minipage}
}}
\vskip1cm
\usebox{\HTWbox}
\par
}

\ifthenelse{\equal{\type}{exam}}{%Nur exam
%Infobox:
\newcommand{\HTWInfobox}[3]{
\begin{minipage}{#1\textwidth}
\createHTWbox{#1}{#2}
\psset{xunit=1\wd\HTWbox ,yunit=2\ht\HTWbox}
\begin{pspicture}[showgrid=false](0,0)(0,0)
 \psset{
 linewidth=1mm,
 linecolor=\type  
 }
 \psframe(0,-0.5cm)(1,1)
 \setlength{\HTWbX}{1\wd\HTWbox}
 \addtolength{\HTWbX}{-0.48cm}
 \setlength{\HTWbY}{2\ht\HTWbox}
 \addtolength{\HTWbY}{-0cm}
 \ifthenelse{\equal{#3}{}}
 {}{\rput*[l](1cm,2\ht\HTWbox){\normalfont\large\bfseries\Catcolor #3}}  
 \rput*[lc](\HTWbX,\HTWbY){\texttt{\HUGE\bfseries\Catcolor i}}  
\end{pspicture} 
\end{minipage}
\vskip1cm
}

%Quotebox:
\newcommand{\HTWQuotebox}[3]{
\begin{minipage}{#1\textwidth}
\createHTWbox{#1}{#2}
\psset{xunit=1\wd\HTWbox ,yunit=2\ht\HTWbox}
\begin{pspicture}[showgrid=false](0,0)(0,0)
 \psset{
 linewidth=1mm,
 linecolor=\type  
 }
 \setlength{\HTWbY}{0.5\ht\HTWbox}
 \addtolength{\HTWbY}{-0.5cm}
 \psline(0,1.5\ht\HTWbox)(0,1)(0.25\wd\HTWbox,1)
 \psline(0.75\wd\HTWbox,-0.5cm)(1,-0.5cm)(1,\HTWbY)
 \ifthenelse{\equal{#3}{}}{}
 {\rput*[l](1cm,2\ht\HTWbox){\normalfont\large\bfseries\Catcolor #3}}  
\end{pspicture} 
\end{minipage}
\vskip1cm
}

%Bracketbox:
\newcommand{\HTWBracketbox}[2]{
\begin{minipage}{#1\textwidth}
\createHTWbox{#1}{#2}
\psset{xunit=1\wd\HTWbox ,yunit=2\ht\HTWbox}
\begin{pspicture}[showgrid=false](0,0)(0,0)
 \psset{
 linewidth=1mm,
 linecolor=HTWGray25,
 opacity=0.25
 }
 \setlength{\HTWbX}{1\wd\HTWbox}
 \addtolength{\HTWbX}{-0.5cm}
 \psframe*(0,-0.5cm)(1,1)
 \psset{opacity=1,linecolor=\type}
 \psline(0.5cm,1)(0,1)(0,-0.5cm)(0.5cm,-0.5cm)
 \psline(\HTWbX,1)(1,1)(1,-0.5cm)(\HTWbX,-0.5cm)
 %\rput*[lc](1cm,2\ht\HTWbox){\normalfont\large\bfseries\color{HTWGreen100} #3}  
\end{pspicture} 
\end{minipage}
\vskip1cm
}
\newcommand{\HTWHBracketbox}[2]{\HTWBracketbox{#1}{#2}}

\newcommand{\HTWFramebox}[2]{
\begin{minipage}{#1\textwidth}
\createHTWbox{#1}{#2}
\psset{xunit=1\wd\HTWbox ,yunit=2\ht\HTWbox}
\begin{pspicture}[showgrid=false](0,0)(0,0)
 \psset{
 linewidth=1mm,
 linecolor=HTWGray25,
 opacity=0.25
 }
 \setlength{\HTWbX}{1\wd\HTWbox}
 \addtolength{\HTWbX}{-1.5cm}
 \setlength{\HTWbY}{2\ht\HTWbox}
 \addtolength{\HTWbY}{-1.5cm}
 \psframe*(0,-0.5cm)(1,1)
 \psset{opacity=1,linecolor=\type}
 \psline(1.5cm,1)(0,1)(0,\HTWbY)
 \psline(0,1cm)(0,-0.5cm)(1.5cm,-0.5cm)
 \psline(\HTWbX,-0.5cm)(\wd\HTWbox,-0.5cm)(\wd\HTWbox,1cm)
 \psline(\wd\HTWbox,\HTWbY)(\wd\HTWbox,1)(\HTWbX,1)
\end{pspicture} 
\end{minipage}
\vskip1cm
}

%VBracketbox:
\newcommand{\HTWVBracketbox}[3]{
\begin{minipage}{#1\textwidth}
\createHTWbox{#1}{#2}
\psset{xunit=1\wd\HTWbox ,yunit=2\ht\HTWbox}
\begin{pspicture}[showgrid=false](0,0)(0,0)
 \psset{
 linewidth=1mm,
 linecolor=HTWGray25,
 opacity=0.25
 }
 \setlength{\HTWbY}{2\ht\HTWbox}
 \addtolength{\HTWbY}{-0.5cm}
 %\psframe*(0,-0.5cm)(1,1)
 \psset{opacity=1,linecolor=\type}
 \psline(0,\HTWbY)(0,1)(1,1)(1,\HTWbY)
 \psline(0,0)(0,-0.5cm)(1,-0.5cm)(1,0)
 \rput*[c](0.5,2\ht\HTWbox){\normalfont\large\bfseries\Catcolor #3}  
 \rput*[c](0.5,-0.5cm){\normalfont\large\bfseries\Catcolor #3}  
\end{pspicture} 
\end{minipage}
\vskip1cm
}

%SpeechBubble:
\newcommand{\HTWSpeechbubblebox}[4]{
\begin{minipage}{#1\textwidth}
\ifthenelse{\equal{#3}{}}
{\createHTWbox{#1}{\vskip0.2cm #2}}
{\createHTWbox{#1}{\vskip0.5cm #2}}
\psset{xunit=1\wd\HTWbox ,yunit=2\ht\HTWbox}
\begin{pspicture}[showgrid=false](0,0)(0,0)
 \psset{
 linewidth=1mm,
 linecolor=HTWGreen100  
 }
 \setlength{\HTWbX}{1\wd\HTWbox}
 \addtolength{\HTWbX}{-1cm}
 \setlength{\HTWbY}{2\ht\HTWbox}
 \addtolength{\HTWbY}{-1cm}
 
 \ifthenelse{\equal{#4}{l}}{
  \psline(0,1)(0,-1.5cm)(1cm,-0.5cm)(\wd\HTWbox,-0.5cm)(\wd\HTWbox,\HTWbY)(\HTWbX,1)(0,1)
  \psset{opacity=0.25, linecolor=HTWGreen25}
  \psline*(0,1)(0,-1.5cm)(1cm,-0.5cm)(\wd\HTWbox,-0.5cm)(\wd\HTWbox,\HTWbY)(\HTWbX,1)(0,1)
  \def\xOff{0.5cm}
 }{
  \psline(1,1)(1,-1.5cm)(\HTWbX,-0.5cm)(0,-0.5cm)(0,\HTWbY)(1cm,1)(1,1)
  \psset{opacity=0.25, linecolor=HTWGreen25}
  \psline*(1,1)(1,-1.5cm)(\HTWbX,-0.5cm)(0,-0.5cm)(0,\HTWbY)(1cm,1)(1,1) 
  \def\xOff{1cm}
 }
 \addtolength{\HTWbY}{0.4cm} 
 \psset{opacity=1}
 \rput[l](\xOff,\HTWbY){\normalfont\large\bfseries\color{HTWGreenDark} #3}   
  
\end{pspicture} 
\end{minipage}
\vskip1cm
}
}{}

%======================================================%
% Deckblatt und letzte Seite:                          %
%======================================================%

\newcommand{\setTitle}[1]{{
\HUGE
\bfseries
%\scshape
\boldmath
\color{#1}        
\docTitle 
\par 
}}
\newcommand{\setSubtitle}{
%Untertitel, falls definiert:
\ifx\docSubtitle\empty
%	pass
\else
	\vskip5mm
	{
	\Large
	\boldmath
	\color{black}        
	\docSubtitle 
	\par   	    
	}
\fi
}
\newcommand{\setJobName}{
%Untertitel, falls definiert:
\ifx\docSubtitle\empty
%	pass
\else
	\vskip5mm
	{
	\Large
	\boldmath
	\color{black}        
	\docJobname
	\par   	    
	}
\fi
}

%Deckblatt:
\newlength{\coverlength}
\newlength{\coverheight}
\newcommand{\HTWCover}{

% geometrie für das Cover:
\ifthenelse{\equal{\type}{cv}}{
\newgeometry{top=4cm, bottom=2cm, left=2cm, right=2cm}
\begin{titlepage}

	\ifthenelse{\equal{\@photo}{\empty}}{\vskip50mm}{
	\setTitle{cv}
	\vskip10mm
	\par
	}
	\hskip-2cm	
	\begin{minipage}[t]{1\paperwidth}
		\raggedright
		\color{blue!20!white}\rule{0.7\paperwidth}{1mm}
		\vskip2mm
		
		\setlength{\coverlength}{1\paperwidth}
		\setlength{\coverheight}{0.3\paperheight}
		\addtolength{\coverheight}{-1cm}
								
		\ifthenelse{\equal{\@photo}{\empty}}{
			\color{blue!50!white}\rule{\paperwidth}{0.3\paperheight}
			\vskip-0.3\paperheight
			\raggedleft
			\begin{minipage}[t][\coverheight][t]{0.4\paperwidth}
			\vskip20mm
			\setTitle{white}
			\end{minipage}
			\begin{minipage}[t][\coverheight][t]{0.4\paperwidth}
				\vspace*{\fill}%gleiche vertikalen abstand aus
			
				\setSubtitle
				\vskip5mm
				{
				\huge
				\bfseries
				\color{black}        
				\docJobname
				\par   	    
				}
			\end{minipage}
			\makebox[2cm]{}
		}{
			\addtolength{\coverlength}{-2cm}
			\color{blue!50!white}\rule{2cm}{0.3\paperheight}
			\savebox{\HTWbox}{
			\includegraphics[height=0.3\paperheight, keepaspectratio=true]{\@photo}
			}
			\usebox{\HTWbox}
			\addtolength{\coverlength}{-1\wd\HTWbox}
			\makebox[0.95\coverlength]{	
			\color{blue!50!white}\rule{1\coverlength}{0.3\paperheight}
			}		
	%		\vskip-10mm
			
			\addtolength{\coverlength}{-2cm}

			\vskip-0.3\paperheight
			\raggedleft		
			\begin{minipage}[t][\coverheight][t]{1\coverlength}
				\vspace*{\fill}%gleiche vertikalen abstand aus
			
				\setSubtitle
				\vskip5mm
				{
				\huge
				\bfseries
				\color{black}        
				\docJobname
				\par   	    
				}
			\end{minipage}
			\makebox[1cm]{}	
		}
		\vskip7mm
		\color{blue!20!white}\rule{0.7\paperwidth}{1mm}	

	\end{minipage}	
	\vskip2cm
	\makeatletter
	{
	\Huge
	\bfseries
	\color{black}  
	\@firstname \hspace{0em} \@lastname}
	\par

   	\ifx\@address\empty
		% pass
  	\else
   		\vskip5mm
   		\Large  
   		\@addressstreet\\
   		\@addresscity
   	\fi
	
	\vskip10mm	
	
   	\ifx\@mobile\empty
		% pass
  	\else
  		\Large
   		\textbf{Tel.: } \@mobile
   	\fi
	
   	\ifx\@email\empty
		% pass
  	\else
  		\Large
   		\textbf{Mail: }
   		\href{mailto:\@email}{\@email}
   	\fi
   	
	\vspace*{\fill}%gleiche vertikalen abstand aus
    \ifthenelse{\equal{\HTWAttachmentCount}{0}}{}
    {
    	\Large
        \textbf{Anlage\ifthenelse{\equal{\HTWAttachmentCount}{1}}{}{n}:}\\ 
        \multido{\nX=1+1}{\HTWAttachmentCount}{
        \csname attachmentname\nX\endcsname
        \ifx\nX\HTWAttachmentCount \else , \fi \\
        }
    }
	
}{
\newgeometry{top=2cm, bottom=3cm, left=3cm, right=3cm}    
\begin{titlepage}
	\createBG

	\hskip-0.5cm
    \begin{minipage}{0.25\textwidth}
    	\vskip0.5cm
    	\includegraphics[height=1.5cm, keepaspectratio=true]{pspictures/figures/logo/logo_long}	
    \end{minipage} 		
    \hskip2cm
    \begin{minipage}[t]{0.55\textwidth}
    	\raggedleft
    	\texttt{\bfseries\large Fachbereich 1\\
   		Computer Engineering \\(Master)}
	\end{minipage}
	\begin{minipage}[t]{0.2\textwidth}
		\vskip-10mm
    	\includegraphics[height=2.5cm, keepaspectratio=true]{pspictures/figures/logo/CE_logo} 
    \end{minipage}
	\vskip50mm

    	
    \begin{flushright}
    \begin{minipage}[t]{0.7\textwidth}
    	\begin{flushright}    	   	
    	\setTitle{exam}
		%Obere Teil des Deckblattes:
		\setSubtitle

		%Referenz, falls definiert:
        	\ifx\docReference\empty
        		% pass
        	\else
        \vskip8mm
    	        {
                \LARGE
                \boldmath            
                \docReference 
                \par   	    
    	        }
        \fi
    	\end{flushright}		
	\end{minipage}	        
	\end{flushright}
		
        \vfill%gleiche vertikalen abstand aus

	     %Unterer Teil des Deckblattes:
            {
	            \large
	            \sffamily
	            %\color{black}
	            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      	
				\ifx\docIssueDate\empty
					% pass
				\else
					\vskip5mm
					\textbf{Datum}\par
					\docIssueDate
				\fi
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%				
				\ifx\docCourse\empty
               		% pass
               	\else
               		\vskip5mm
               		\textbf{Kurs}\par
               		\docCourse
               	\fi     
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	            \ifthenelse{\isZero{\HTWStudentCount}}{}
		        {
		        	\vskip5mm
		            \textbf{Autor\ifthenelse{\isBigger{\HTWStudentCount}{1}}{en}}\\ 
					\begin{minipage}[t]{0.35\textwidth}
			            \multido{\nX=1+1}{\HTWStudentCount}{
			            \csname firstname\nX\endcsname \hspace{0em} \csname lastname\nX\endcsname \\
			            }					
					\end{minipage}
					\begin{minipage}[t]{0.1\textwidth}
			            \multido{\nX=1+1}{\HTWStudentCount}{
			            \ifthenelse{\equal{\csname matrikel\nX\endcsname}{\empty}}{\vskip3mm}{
			            \raggedright	            
			            \csname matrikel\nX\endcsname \\
			            }}					
					\end{minipage}	            
					\vskip-3mm
	            }
	            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               	\ifx\docReviewer\empty
               		% pass
               	\else
               		\vskip5mm
               		\textbf{Gutachter}\par
               		\docReviewer
               	\fi
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          	    \vskip5mm
                \textbf{Hochschule für Technik und Wirtschaft Berlin}\par
                Wilhelminenhofstr. 75A, 12459 Berlin, Germany
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            }
}
\end{titlepage}
\restoregeometry
}

%letzte Seite:
\newlength{\txtlength}
\newcommand{\HTWLastpage}{

% geometrie für das Cover:
\ifthenelse{\equal{\type}{cv}}{
\newgeometry{top=4cm, bottom=5cm, left=2cm, right=2cm}
\begin{titlepage}

\setTitle{white}%Füllschrift, damit die gleiche Höhe erzielt wird
\vskip11mm
\par

%\vskip0.3\paperwidth
\hskip-2cm
\color{blue!20!white}\rule{\paperwidth}{1mm}
\vskip2mm
\hskip-2cm
\color{blue!50!white}\rule{\paperwidth}{0.3\paperheight}
\vskip-1.5mm
\hskip-2cm
\color{blue!20!white}\rule{\paperwidth}{1mm}
}{
\newgeometry{top=9cm, bottom=2cm, left=3cm, right=3cm} 
\begin{titlepage}
\createBG
        
\vspace*{\fill}%gleiche vertikalen abstand aus

%Unterer Teil des Deckblattes:
\large
\sffamily
%\color{black}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\isZero{\HTWStudentCount}}{}
{
   	\vskip5mm
	\textbf{Kontakt}\\ 
	\begin{minipage}[t]{0.35\textwidth}
    	\multido{\nX=1+1}{\HTWStudentCount}{
		\settowidth{\txtlength}{{\csname mail\nX\endcsname}}%https://latex.org/forum/viewtopic.php?t=20385
	    \ifthenelse{\lengthtest{\txtlength > 2em}}{		            
	    	\csname firstname\nX\endcsname \hspace{0em} \csname lastname\nX\endcsname \\}{}
	    }					
	\end{minipage}
	\hskip0.05\textwidth
	\begin{minipage}[t]{0.5\textwidth}
		\multido{\nX=1+1}{\HTWStudentCount}{
		\settowidth{\txtlength}{{\csname mail\nX\endcsname}}
		\ifthenelse{\lengthtest{\txtlength > 2em}}{	
	    	\raggedright	            
	        \href{mailto:\csname mail\nX\endcsname}{\csname mail\nX\endcsname} \\}{}
	    }					
	\end{minipage}	            
	\vskip-3mm
}
        
\vskip15mm
\begin{center}
	\includegraphics[height=1.5cm, keepaspectratio=true]{pspictures/figures/logo/logo_long}       
\end{center}
}
            

\end{titlepage}
    
%Lade default-geometrie:
\restoregeometry
}
