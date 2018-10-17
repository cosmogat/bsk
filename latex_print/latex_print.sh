#!/bin/bash
# 15-11-2015
# billy
# latex_print.sh

NOM="latex_print"

function ajuda {
    echo "Exemples d'utilització:"
    echo -ne "\t$NOM -t 2 3  -> Taula 2x3\n"
    echo -ne "\t$NOM -f 4 5  -> Subfigures 4x5\n"
    echo -ne "\t$NOM -m 3 3  -> Matriu 3x3\n"
    echo -ne "\t$NOM -pm 3 3 -> Matriu ( ) 3x3\n"
    echo -ne "\t$NOM -bm 3 3 -> Matriu [ ] 3x3\n"
    echo -ne "\t$NOM -Bm 3 3 -> Matriu { } 3x3\n"
    echo -ne "\t$NOM -vm 3 3 -> Matriu | | 3x3\n"
    echo -ne "\t$NOM -Vm 3 3 -> Matriu || || 3x3\n"
}

function matriu {
    for i in $(seq 1 $FIL) ; do
	echo -ne "  $i-1 "
	for j in $(seq 2 $COL) ; do
	    echo -ne "&$i-$j "
	done
	if [ $i -ne $FIL ] ; then
	    echo -ne "\\\\\ "
	fi
	echo -ne "\n"

    done
}

if [ $# -gt 3 ] ; then
    ajuda
    exit 1
fi

if [ $# -lt 1 ] ; then
    ajuda
    exit 2
fi

if [ $1 == "-t" ] ; then
    if [ $# -eq 3 ] ; then
	FIL=$2
	COL=$3
    else
	FIL=2
	COL=2
    fi
    echo "\begin{table}[!h]"
    echo "  \begin{center}"
    echo -ne "    \\\begin{tabular}{|"
    for j in $(seq 1 $COL) ; do
	echo -ne "c|"
    done   
    echo -ne "}\n"
    echo "      \hline"
    echo -ne "      col1 "
    for j in $(seq 2 $COL) ; do
	echo -ne "&col$j "
    done
    echo -ne "\\\\\ \n"
    echo "      \hline"
    echo "      \hline"
    for i in $(seq 1 $FIL) ; do
	echo -ne "      elem$i-1 "
	for j in $(seq 2 $COL) ; do
	    echo -ne "&elem$i-$j "
	done
	echo -ne "\\\\\ \n"
	echo "      \hline"
    done
    echo "    \end{tabular}"
    echo "    \caption{Títol taula 1.}"
    echo "    \label{tau:tau1}"
    echo "  \end{center}"
    echo "\end{table}"
elif [ $1 == "-f" ] ; then
    if [ $# -eq 3 ] ; then
	let FIL=$2-1
	COL=$3
	echo "\begin{figure}[!h]"
	echo "  \begin{center}"
	for i in $(seq 1 $FIL) ; do
	    for j in $(seq 1 $COL) ; do
		echo "    \subfloat[]{"
		echo "      \label{fig:subfig$i-$j}"
		echo "      \includegraphics[width=8cm]{./img/nom_arxiu$i-$j.pdf}}"
	    done
	    echo -ne "    \\\\\ \n"
	done
	for j in $(seq 1 $COL) ; do
	    echo "    \subfloat[]{"
	    echo "      \label{fig:subfig$i-$j}"
	    echo "      \includegraphics[width=8cm]{./img/nom_arxiu$i-$j.pdf}}"
	done	
	echo "    \caption{Títol de les figures.}"
	echo "    \label{fig:fig1}"
	echo "  \end{center}"
	echo "\end{figure}"	
    else
	echo "\begin{figure}[!h]"
	echo "  \begin{center}"
	echo "    \includegraphics[width=10cm]{./img/nom_arxiu.pdf}"
	echo "    \caption{Títol de la figura.}"
	echo "    \label{fig:fig1}"
	echo "  \end{center}"
	echo "\end{figure}"	
    fi
elif [ $1 == "-m" ] ; then
    if [ $# -eq 3 ] ; then
	FIL=$2
	COL=$3
    else
	FIL=2
	COL=2
    fi
    echo "\begin{matrix}"
    matriu
    echo "\end{matrix}"
elif [ $1 == "-pm" ] ; then
    if [ $# -eq 3 ] ; then
	FIL=$2
	COL=$3
    else
	FIL=2
	COL=2
    fi
    echo "\begin{pmatrix}"
    matriu
    echo "\end{pmatrix}"
elif [ $1 == "-bm" ] ; then
    if [ $# -eq 3 ] ; then
	FIL=$2
	COL=$3
    else
	FIL=2
	COL=2
    fi
    echo "\begin{bmatrix}"
    matriu
    echo "\end{bmatrix}"
elif [ $1 == "-Bm" ] ; then
    if [ $# -eq 3 ] ; then
	FIL=$2
	COL=$3
    else
	FIL=2
	COL=2
    fi
    echo "\begin{Bmatrix}"
    matriu
    echo "\end{Bmatrix}"
elif [ $1 == "-vm" ] ; then
    if [ $# -eq 3 ] ; then
	FIL=$2
	COL=$3
    else
	FIL=2
	COL=2
    fi
    echo "\begin{vmatrix}"
    matriu
    echo "\end{vmatrix}"
elif [ $1 == "-Vm" ] ; then
    if [ $# -eq 3 ] ; then
	FIL=$2
	COL=$3
    else
	FIL=2
	COL=2
    fi
    echo "\begin{Vmatrix}"
    matriu
    echo "\end{Vmatrix}" 
fi
