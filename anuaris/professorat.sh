#!/bin/bash
# 06-08-2020
# alex
# professorat.sh

#CAL_CMD="cal -mh"
#CAL_CMD="cal -h"
CAL_CMD="ncal -bh"
# Comandament per a que el calendari comence per dilluns i no remarque el dia d'avui, per exemple per a 05-07-2017
#     Juliol 2017       
# dl dt dc dj dv ds dg  
#                 1  2  
#  3  4  5  6  7  8  9  
# 10 11 12 13 14 15 16  
# 17 18 19 20 21 22 23  
# 24 25 26 27 28 29 30  
# 31

function comprovacions {
    EIXIDA=0
    PARAMS=""
    ANY=0
    es_num="^[0-9]+$"
    if [ $# -lt 2 ] ; then
	EIXIDA=1
    fi
    ANY=$1
    if ! [[ $ANY =~ $es_num ]] || [ $ANY -le 0 ] || [ $ANY -ge 9999 ] ; then
	ANY=0
	EIXIDA=1
    fi
    echo "$EIXIDA-$ANY"
}
cadena=$(comprovacions $@)
EIXIDA=$(echo $cadena | cut -d'-' -f 1)
ANY=$(echo $cadena | cut -d'-' -f 2)
if [ $EIXIDA -eq 1 ] ; then
    nom=$(basename $0)
    echo "Utilitzeu: $nom ANY a_1 a_2 a_3 ... a_n" >&2
    echo "On ANY és un any comprès entre 1 i 9999" >&2
    echo "On a_i és el nombre d'alumnes del curs i" >&2
    echo "És necessari tindre pdflatex i les llibreries bàsiques de latex" >&2
    exit 1    
fi

let ANY_P=$ANY+1
SEQ=$(seq 9 12; seq 1 8)
FB=" \cellcolor{blanc} "
MESOS=("" "Gener" "Febrer" "Març" "Abril" "Maig" "Juny" "Juliol" "Agost" "Setembre" "Octubre" "Novembre" "Desembre")
echo -ne "Preparant el calendari"
LATEX="anuari$$.tex"
touch $LATEX
echo "\documentclass[10pt,a4paper,catalan,fleqn,twoside]{article}" >> $LATEX
echo "\pagestyle{empty}" >> $LATEX
echo "\usepackage[catalan]{babel}" >> $LATEX
echo "\usepackage[utf8]{inputenc}" >> $LATEX
echo "\usepackage{anysize}" >> $LATEX
echo "\usepackage{hyperref}" >> $LATEX
echo "\usepackage{enumerate}" >> $LATEX
echo "\usepackage{amssymb}" >> $LATEX
echo "\usepackage{amsmath}" >> $LATEX
echo "\usepackage{amsthm}" >> $LATEX
echo "\usepackage{xcolor,colortbl}" >> $LATEX
echo "\usepackage[T1]{fontenc}" >> $LATEX
echo "\usepackage{times}" >> $LATEX
echo "\usepackage{listings}" >> $LATEX
echo "\usepackage{framed}" >> $LATEX
echo "\usepackage{wasysym}" >> $LATEX
echo "\marginsize{1.0cm}{1.0cm}{1.0cm}{1.0cm}" >> $LATEX
echo "\definecolor{gris01}{rgb}{0.9,0.9,0.9}" >> $LATEX
echo "\definecolor{roig}{rgb}{0.94,0.66,0.66}" >> $LATEX
echo "\definecolor{verd}{rgb}{0.66,0.94,0.66}" >> $LATEX
echo "\definecolor{lila}{rgb}{0.66,0.66,0.94}" >> $LATEX
echo "\definecolor{groc}{rgb}{0.94,0.94,0.66}" >> $LATEX
echo "\definecolor{rosa}{rgb}{0.94,0.66,0.94}" >> $LATEX
echo "\definecolor{blau}{rgb}{0.65,0.86,0.96}" >> $LATEX
echo "\definecolor{blanc}{rgb}{1.00,1.00,1.00}" >> $LATEX
echo "\definecolor{col00}{rgb}{0.88,0.88,0.88}" >> $LATEX
echo "\definecolor{col01}{rgb}{0.58,0.82,0.98}" >> $LATEX
echo "\definecolor{col02}{rgb}{0.59,0.86,0.98}" >> $LATEX
echo "\definecolor{col03}{rgb}{0.65,0.91,0.90}" >> $LATEX
echo "\definecolor{col04}{rgb}{0.72,0.88,0.69}" >> $LATEX
echo "\definecolor{col05}{rgb}{0.82,0.91,0.66}" >> $LATEX
echo "\definecolor{col06}{rgb}{0.99,0.96,0.58}" >> $LATEX
echo "\definecolor{col07}{rgb}{0.99,0.89,0.57}" >> $LATEX
echo "\definecolor{col08}{rgb}{0.98,0.78,0.58}" >> $LATEX
echo "\definecolor{col09}{rgb}{0.97,0.60,0.61}" >> $LATEX
echo "\definecolor{col10}{rgb}{0.93,0.64,0.81}" >> $LATEX
echo "\definecolor{col11}{rgb}{0.75,0.70,0.87}" >> $LATEX
echo "\definecolor{col12}{rgb}{0.66,0.75,0.91}" >> $LATEX
echo "\colorlet{fes1}{roig}" >> $LATEX
echo "\colorlet{fes2}{groc}" >> $LATEX
echo "\colorlet{fes3}{blau}" >> $LATEX
echo "\begin{document}" >> $LATEX
echo "\begin{center}" >> $LATEX
echo "{\Huge \bf Horari escolar $ANY-$ANY_P}" >> $LATEX
echo "\end{center}" >> $LATEX
echo "\begin{center}" >> $LATEX
echo "\begin{tabular}{|*{8}{p{1.95cm}|}}" >> $LATEX
echo "\hline" >> $LATEX
echo "Hores&\textbf{Dilluns}&\textbf{Dimarts}&\textbf{Dimecres}&\textbf{Dijous}&\textbf{Divendres}&\textbf{Dissabte}&\textbf{Diumenge}\\\ " >> $LATEX
echo "\hline" >> $LATEX
for HORA1 in $(seq 8 16) ; do
    let HORA2=$HORA1+1
    HORAP1=$(printf "%02d" $HORA1)
    HORAP2=$(printf "%02d" $HORA2)
    echo "$HORAP1:00 - $HORAP2:00 & & & & & & & \\\ " >> $LATEX
    for k in $(seq 0 4) ; do
	echo "& & & & & & & \\\ " >> $LATEX
    done
    echo "\hline" >> $LATEX
done
echo "\end{tabular}" >> $LATEX
echo "\end{center}" >> $LATEX
echo "\clearpage" >> $LATEX
echo "\begin{center}" >> $LATEX
echo "{\Huge \bf Calendari escolar $ANY-$ANY_P}" >> $LATEX
echo "\end{center}" >> $LATEX
echo "\\ \\ \\" >> $LATEX
echo "\begin{center}" >> $LATEX
echo "\begin{tabular}{c@{\hspace{0.5cm}}c@{\hspace{0.5cm}}c}" >> $LATEX

for j in $SEQ ; do
    let VAR=$j-1
    MOD=$(expr $j % 3)
    if [ $MOD -eq 0 ] ; then
	echo "\\\ " >> $LATEX
	echo "& & \\\ " >> $LATEX
    else 
	echo "& " >> $LATEX
    fi
    NUM=0
    ANY_P=$ANY
    if [ $j -le 8 ] ; then
	let ANY_P=$ANY+1
    fi
    INI=$(date -d "$ANY_P-$j-01" | cut -f 1 -d' ' | cut -f 1 -d'.')
    case $INI in
	dl)
	    INI_NUM=0
	    ;;
	dt)
	    INI_NUM=1
	    ;;
	dc)
	    INI_NUM=2
	    ;;
	dj)
	    INI_NUM=3
	    ;;
	dv)
	    INI_NUM=4
	    ;;
	ds)
	    INI_NUM=5
	    ;;
	dg)
	    INI_NUM=6
	    ;;
    esac
    MES=${MESOS[$j]}
    echo "\begin{tabular}{|p{0.3cm}|p{0.3cm}|p{0.3cm}|p{0.3cm}|p{0.3cm}|p{0.3cm}|p{0.3cm}|}" >> $LATEX
    echo "\multicolumn{7}{c}{$MES}\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    echo " dl& dt& dc& dj& dv& ds& dg\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    echo "\hline" >> $LATEX
    if [ $INI_NUM -gt 0 ] ; then
	echo -n "" >> $LATEX
    fi   
    for i in $(seq 2 $INI_NUM) ; do
	echo -n "& " >> $LATEX
    done
    for i in $($CAL_CMD $j $ANY_P  | tail -n 6) ; do 
	let AUX=$NUM+1
	let AUX=$AUX+$INI_NUM
	CONT=$(expr $AUX % 7)
	if [ $CONT -ne 1 ] ; then
	    echo -ne "&" >> $LATEX
	fi
	color=""
	echo -n "$color" >> $LATEX
	echo -ne "$i" >> $LATEX
	if [ $CONT -eq 0 ] ; then
	    echo "\\\ " >> $LATEX
	    echo "\hline" >> $LATEX
	fi
	let NUM=$NUM+1
    done
    echo -ne "."
    if [ $CONT -ne 0 ] ; then
	for i in $(seq $CONT 6) ; do
	    echo -n "& " >> $LATEX
	done
    echo "\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    fi
    echo "\end{tabular}" >> $LATEX
done
echo "\end{tabular}" >> $LATEX
echo "\\\[1.0cm]" >> $LATEX
for i in $(seq 0 5) ; do
    echo "\hrule \ \\\[1.0cm]" >> $LATEX
done
echo "\end{center}" >> $LATEX
echo "\clearpage" >> $LATEX
echo ""
echo -ne "Preparant l'anuari"
for j in $SEQ ; do 
    NUM=0
    ANY_P=$ANY
    if [ $j -le 8 ] ; then
	let ANY_P=$ANY+1
    fi
    INI=$(date -d "$ANY_P-$j-01" | cut -f 1 -d' ' | cut -f 1 -d'.')
    case $INI  in
	dl)
	    INI_NUM=0
	    ;;
	dt)
	    INI_NUM=1
	    ;;
	dc)
	    INI_NUM=2
	    ;;
	dj)
	    INI_NUM=3
	    ;;
	dv)
	    INI_NUM=4
	    ;;
	ds)
	    INI_NUM=5
	    ;;
	dg)
	    INI_NUM=6
	    ;;
    esac
    MES=${MESOS[$j]}
    echo "\begin{center}" >> $LATEX
    echo "{\huge \textbf{$MES $ANY_P}}" >> $LATEX
    echo "\end{center}" >> $LATEX
    echo "\\" >> $LATEX
    echo "\begin{center}" >> $LATEX
    echo "\begin{tabular}{|*{7}{p{2.25cm}|}}" >> $LATEX
    echo "\hline" >> $LATEX
    echo "\textbf{Dilluns}&\textbf{Dimarts}&\textbf{Dimecres}&\textbf{Dijous}&\textbf{Divendres}&\textbf{Dissabte}&\textbf{Diumenge}\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    echo "\hline" >> $LATEX
    if [ $INI_NUM -gt 0 ] ; then
	echo -n "" >> $LATEX
    fi
    for i in $(seq 2 $INI_NUM) ; do
	echo -n "&" >> $LATEX
    done
    COLORS=("" "" "" "" "" "" "")
    NUM_SEM=$($CAL_CMD $j $ANY_P |  sed -r '/^\s*$/d' | wc -l)
    for i in $($CAL_CMD $j $ANY_P | tail -n 6) ; do
	let AUX=$NUM+1
	let AUX=$AUX+$INI_NUM
	CONT=$(expr $AUX % 7)
	if [ $CONT -ne 1 ] ; then
	    echo -n "&" >> $LATEX
	fi
	color=
	COLORS[$CONT]=$color
	echo -n "$color" >> $LATEX
	echo -n "\textbf{$i}" >> $LATEX
	if [ $CONT -eq 0 ] ; then
	    echo "\\\ " >> $LATEX
	    for k in $(seq 1 7) ; do
		echo "${COLORS[1]}&${COLORS[2]} &${COLORS[3]} &${COLORS[4]} &${COLORS[5]} &${COLORS[6]} &${COLORS[0]}\\\ " >> $LATEX
	    done
	    echo "\hline" >> $LATEX
	fi
	let NUM=$NUM+1
    done
    echo -ne "."
    if [ $CONT -ne 0 ] ; then
	for i in $(seq $CONT 6) ; do
	    echo -n "&" >> $LATEX
	    let ind=$i+1
	    COLORS[$ind]=""
	done
	COLORS[0]=""
	echo "\\\ " >> $LATEX
	for k in $(seq 1 7) ; do
	    echo "${COLORS[1]}&${COLORS[2]} &${COLORS[3]} &${COLORS[4]} &${COLORS[5]} &${COLORS[6]} &${COLORS[0]}\\\ " >> $LATEX
	done
	echo "\hline" >> $LATEX
    fi
    echo "\end{tabular}" >> $LATEX
    echo "\\\[1.0cm]" >> $LATEX
    LIN_LIM=5
    case $NUM_SEM in
	6)
	    LIN_LIM=8
	;;
	7)
	    LIN_LIM=5
	;;
	8)
	    LIN_LIM=2
	;;
    esac
    for i in $(seq 0 $LIN_LIM) ; do
	echo "\hrule \ \\\[1.0cm]" >> $LATEX
    done
    echo "\end{center}" >> $LATEX
    echo "\clearpage" >> $LATEX
done
echo "\cleardoublepage" >> $LATEX
echo ""
echo -ne "Preparant cursos."
ARRAY=("$@")
let NN=$#-1
for ind in $(seq 1 $NN) ; do
    NAL=${ARRAY[$ind]}
    echo "\noindent\\\ " >> $LATEX
    echo "{\huge \textbf{Grup:}}\\\[0.4cm]" >> $LATEX
    echo "Total: \\\[0.2cm]" >> $LATEX
    echo "Tutoritzat per: \\\[-3.0cm] " >> $LATEX
    echo "\begin{center}" >> $LATEX
    echo "\newcolumntype{g}{>{\columncolor{gris01}}p}" >> $LATEX
    echo "\newcolumntype{d}{>{\columncolor{gris01}}c}" >> $LATEX
    echo "\begin{tabular}{p{6.0cm}|p{0.3cm}|p{0.3cm}|p{0.3cm}|g{0.3cm}||p{0.3cm}|p{0.3cm}|p{0.3cm}|g{0.3cm}||p{0.3cm}|p{0.3cm}|p{0.3cm}|g{0.3cm}||p{0.3cm}||d|}" >> $LATEX
    for k in $(seq 1 9) ; do
	echo "& & & & & & & & & & & & & &\\\ " >> $LATEX
    done
    echo "Nom i cognoms& & & &1 & & & &2 & & & &3 &AE &Final\\\ " >> $LATEX
    echo "& & & & & & & & & & & & & &\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    echo "\hline" >> $LATEX
    NSPC=""
    if [ $NAL -le 22 ] ; then
	NSPC="[0.45cm]"
    elif [ $NAL -le 28 ] ; then
	NSPC="[0.3cm]"
    elif [ $NAL -le 35 ] ; then
	NSPC="[0.15cm]"
    elif [ $NAL -gt 45 ] ; then
	NAL=45
    fi
    for al in $(seq 1 $NAL) ; do
	echo "$al. & & & & & & & & & & & & & &\\\ $NSPC " >> $LATEX
	echo "\hline" >> $LATEX
    done
    echo "\end{tabular}" >> $LATEX
    echo "\end{center}" >> $LATEX
    echo "\clearpage" >> $LATEX
    for al_i in $(seq 1 $NAL) ; do
	echo "\noindent\\\ " >> $LATEX
	echo "Curs:\ \ \ \ \ \ \ \ \ \ \ \ Número: $al_i\\\[0.2cm]" >> $LATEX
	echo "Nom: \\\[0.2cm]" >> $LATEX
	echo "Cognoms: \\\[0.2cm]" >> $LATEX
	echo "Correu: \\\[0.2cm]" >> $LATEX
	echo "Pendents: \\\[0.2cm]" >> $LATEX
	echo "\begin{center}" >> $LATEX
	TAMCOL="1.25cm"
	echo "\newcolumntype{g}{>{\columncolor{gris01}}p}" >> $LATEX
	echo "\begin{tabular}{p{0.3cm}|p{$TAMCOL}|p{$TAMCOL}|p{$TAMCOL}|p{$TAMCOL}|p{$TAMCOL}|p{$TAMCOL}|p{$TAMCOL}|p{$TAMCOL}|p{$TAMCOL}|p{$TAMCOL}||g{0.5cm}|}" >> $LATEX
	for k in $(seq 1 10) ; do
	    echo "& & & & & & & & & & & \\\ " >> $LATEX
	done
	echo "\hline" >> $LATEX
	echo "\hline" >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "1& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "\hline" >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "2& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "\hline" >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "3& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "\hline" >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "AE\ & & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "& & & & & & & & & & & \\\ " >> $LATEX
	echo "\hline" >> $LATEX
	echo "\end{tabular}" >> $LATEX
	echo "\end{center}" >> $LATEX
	echo "\begin{center}" >> $LATEX
	echo "\newcolumntype{g}{>{\columncolor{gris01}}p}" >> $LATEX
	echo -n "\begin{tabular}{|" >> $LATEX
	for dia in $(seq 0 31) ; do
	    if [ $(expr $dia % 5) -eq 0 ] && [ $dia -ne 0 ] ; then
		echo -n "g{0.15cm}|" >> $LATEX
	    else
		echo -n "p{0.15cm}|" >> $LATEX
	    fi	    
	done
	echo "}" >> $LATEX
	echo "\hline" >> $LATEX
	for dia in $(seq 1 31) ; do
	    echo -n "& $dia" >> $LATEX
	done
	echo "\\\ " >> $LATEX
	echo "\hline" >> $LATEX
	echo "\hline" >> $LATEX
	MESOS_L=("S" "O" "N" "D" "G" "F" "M" "A" "M" "J")
	MESOS_I=1
	for MESINI in "${MESOS_L[@]}"; do
	    if [ $(expr $MESOS_I % 2) -eq 0 ] ; then
		echo "\rowcolor{gris01}" >> $LATEX
	    fi
	    let MESOS_I=$MESOS_I+1
	    echo -n "$MESINI" >> $LATEX
	    for dia in $(seq 1 31) ; do
		echo -n "&" >> $LATEX
	    done
	    echo "\\\ " >> $LATEX
	    echo "\hline" >> $LATEX
	done
	echo "\end{tabular}" >> $LATEX
	echo "\end{center}" >> $LATEX	
	echo "Observacions:\\\ " >> $LATEX
	echo "\clearpage" >> $LATEX
    done
    echo "\cleardoublepage" >> $LATEX
    echo -ne "."
done
echo "\noindent\\\ " >> $LATEX
echo "{\huge Anotacions}" >> $LATEX
for k in $(seq 1 16) ; do
    echo "\begin{framed}" >> $LATEX
    echo "\noindent\\\ " >> $LATEX
    echo "Data:\\\[0.5cm] " >> $LATEX
    echo "Tema:\\\ " >> $LATEX
    for i in $(seq 0 4) ; do
	echo "\hrule \ \\\[0.3cm]" >> $LATEX
    done
    echo "\\\[-1.0cm]" >> $LATEX
    echo "\end{framed}" >> $LATEX
    if [ $(($k%4)) -eq 0 ] ; then
	echo "\clearpage" >> $LATEX
    fi
done
echo "\end{document}" >> $LATEX
echo ""
echo -ne "Preparant el pdf."
pdflatex anuari$$.tex >> /dev/null
echo -ne "."
rm anuari$$.tex anuari$$.aux anuari$$.log anuari$$.out
mv anuari$$.pdf anuari$ANY.pdf
echo -ne ".\n"
echo "Creat l'arxiu anuari$ANY.pdf"
