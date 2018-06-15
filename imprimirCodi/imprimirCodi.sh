#!/bin/bash
# 03-12-2014
# billy
# imprimirCodi.sh

NOM="billy"

function ajuda {
    echo "Utilitzeu"
    echo -e "\t$(basename $0) directori nomDelPDF"
    echo -e "\t$(basename $0) serveix per a imprimir codi en un pdf." 
}

if [ $# -ne 2 ] ; then
    ajuda
    exit 1
fi

if [ -d $1 ] ; then
    DIR=$PWD
    LATEX="$2$$.tex"
    TITOL=$2
    TITOL="$(tr '[:lower:]' '[:upper:]' <<< ${TITOL:0:1})${TITOL:1}"
    touch "$LATEX"
    echo "\documentclass[10pt,a4paper,catalan,twoside]{book}" >> "$LATEX"
    echo "\usepackage[catalan]{babel}" >> "$LATEX"
    #echo "\usepackage[utf8]{inputenc}" >> "$LATEX"
    echo "\usepackage{anysize}" >> "$LATEX"
    echo "\usepackage[colorlinks=true,linkcolor=blue,urlcolor=black]{hyperref}" >> "$LATEX"
    echo "\usepackage{color}" >> "$LATEX"
    echo "\usepackage[T1]{fontenc}" >> "$LATEX"
    echo "\usepackage{listingsutf8}" >> "$LATEX"
    echo "\marginsize{2cm}{2cm}{2cm}{2cm}" >> "$LATEX"
    echo "\definecolor{gray97}{gray}{0.97}" >> "$LATEX"
    echo "\definecolor{gray75}{gray}{0.75}" >> "$LATEX"
    echo "\definecolor{gray45}{gray}{0.45}" >> "$LATEX"
    echo "\definecolor{verd}{rgb}{0.00,0.60,0.00}" >> "$LATEX"
    echo "\definecolor{gris}{rgb}{0.50,0.50,0.50}" >> "$LATEX"
    echo "\definecolor{morat}{rgb}{0.58,0.00,0.82}" >> "$LATEX"
    echo "\definecolor{marro}{rgb}{0.52,0.33,0.27}" >> "$LATEX"
    echo "\lstset{language=C,caption={Descriptive Caption Text},label=DescriptiveLabel}" >> "$LATEX"
    echo "\lstset{" >> "$LATEX"
    echo "  backgroundcolor=\color{gray97}, " >> "$LATEX"
    echo "  basicstyle=\tiny,       " >> "$LATEX"
    echo "  breakatwhitespace=false,        " >> "$LATEX"
    echo "  breaklines=true,                " >> "$LATEX"
    echo "  captionpos=b,                   " >> "$LATEX"
    echo "  commentstyle=\color{verd},    " >> "$LATEX"
    echo "  deletekeywords={...},         " >> "$LATEX"
    echo "  escapeinside={\%*}{*)},       " >> "$LATEX"
    echo "  extendedchars=true,           " >> "$LATEX"
    echo "  frame=single,                 " >> "$LATEX"
    echo "  keepspaces=true,              " >> "$LATEX"
    echo "  keywordstyle=\color{blue},    " >> "$LATEX"
    echo "  language=C,                " >> "$LATEX"
    echo "  morekeywords={*,...},      " >> "$LATEX"
    echo "  numbers=left,              " >> "$LATEX"
    echo "  numbersep=10pt,             " >> "$LATEX"
    echo "  numberstyle=\tiny\color{gris}," >> "$LATEX"
    echo "  rulecolor=\color{black},      " >> "$LATEX"
    echo "  showspaces=false,             " >> "$LATEX"
    echo "  showstringspaces=false,       " >> "$LATEX"
    echo "  showtabs=false,               " >> "$LATEX"
    echo "  stepnumber=1,                 " >> "$LATEX"
    echo "  stringstyle=\color{morat},    " >> "$LATEX"
    echo "  tabsize=2,                    " >> "$LATEX"
    echo "  title=\lstname                " >> "$LATEX"
    echo "}" >> "$LATEX"
    echo "\lstdefinestyle{customc}{" >> "$LATEX"
    echo "  belowcaptionskip=1\baselineskip," >> "$LATEX"
    echo "  breaklines=true," >> "$LATEX"
    echo "  frame=false," >> "$LATEX"
    echo "  xleftmargin=\parindent," >> "$LATEX"
    echo "  language=C," >> "$LATEX"
    echo "  showstringspaces=false," >> "$LATEX"
    echo "  basicstyle=\footnotesize\ttfamily\color{black}," >> "$LATEX"
    echo "  keywordstyle=\bfseries\color{verd}," >> "$LATEX"
    echo "  commentstyle=\color{red}," >> "$LATEX"
    echo "  identifierstyle=\color{blue}," >> "$LATEX"
    echo "  stringstyle=\color{marro}," >> "$LATEX"
    echo "}" >> "$LATEX"

    echo "\lstdefinestyle{customasm}{" >> "$LATEX"
    echo "  belowcaptionskip=1\baselineskip," >> "$LATEX"
    echo "  frame=L," >> "$LATEX"
    echo "  xleftmargin=\parindent," >> "$LATEX"
    echo "  language=[x86masm]Assembler," >> "$LATEX"
    echo "  basicstyle=\footnotesize\ttfamily," >> "$LATEX"
    echo "  commentstyle=\itshape\color{morat}," >> "$LATEX"
    echo "}" >> "$LATEX"

    echo "\lstset{escapechar=@,style=customc}" >> "$LATEX"
    echo "\lstnewenvironment{listing}[1][]" >> "$LATEX"
    echo "{\lstset{#1}\pagebreak[0]}{\pagebreak[0]}" >> "$LATEX"
    echo "\newcommand{\includecode}[2][c]{\lstinputlisting[caption=#2, escapechar=, style=custom#1]{#2}}" >> "$LATEX"

    echo "\begin{document}" >> "$LATEX"
    echo "\title{\Huge \bf $TITOL}" >> "$LATEX"
    echo "\author{$NOM}" >> "$LATEX"
    echo "\maketitle" >> "$LATEX"
    echo "\thispagestyle{empty}" >> "$LATEX" 
    echo "\cleardoublepage" >> "$LATEX"
    echo "\tableofcontents" >> "$LATEX"
    echo "\cleardoublepage" >> "$LATEX"
    echo -ne "Insertant arxius"
    cd "$1"
    for i in * ; do
	if [ -d "$i" ] ; then
	    cd "$i"
	    CHAPTER=$(echo $i | sed 's/_/ /g')
	    echo "\chapter{$CHAPTER}" >> "$DIR/$LATEX"
	    echo "\cleardoublepage" >> "$DIR/$LATEX"
	    echo -ne " "
	    for j in * ; do
		if [ -f "$j" ] ; then
		    SECTION=$(echo $j | sed 's/_/ /g')
		    echo "\section{$SECTION}" >> "$DIR/$LATEX"
		    echo -ne "."
		    case $j in
			*.h | *.c | *.cpp | *.hpp | *.c++ | *.h++ | *.py | *.php)
			    echo "\begin{lstlisting}" >> "$DIR/$LATEX"
			    cat "$j" >> "$DIR/$LATEX"
			    echo "\end{lstlisting}" >> "$DIR/$LATEX"
			    ;;
			*)
			    echo "\begin{verbatim}" >> "$DIR/$LATEX"
			    cat "$j" >> "$DIR/$LATEX"
			    echo "\end{verbatim}" >> "$DIR/$LATEX"
			    ;;
		    esac
		    echo "\cleardoublepage" >> "$DIR/$LATEX"
		fi
	    done
	    echo "\cleardoublepage" >> "$DIR/$LATEX"
	    cd - > /dev/null
	fi
    done
    cd "$DIR"
    echo "\end{document}" >> "$LATEX"
    echo -ne "\nPreparant el pdf ..."
    pdflatex "$LATEX" >> /dev/null
    echo -ne "...\n"
    pdflatex "$LATEX" >> /dev/null
    mv "$2$$.pdf" "$2.pdf"
    rm "$2$$.aux" "$2$$.log" "$2$$.out" "$2$$.tex" "$2$$.toc"
else
    ajuda
    exit 2
fi
