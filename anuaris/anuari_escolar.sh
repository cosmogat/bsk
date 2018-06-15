#!/bin/bash
# 10-10-2015
# billy
# anuari_escolar.sh

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

es_num="^[0-9]+$"
if [ $# -ne 1 ] || ! [[ $1 =~ $es_num ]] || [ $1 -le 0 ] || [ $1 -ge 9999 ] ; then
    nom=$(basename $0)
    echo "Utilitzeu: $nom ANY" >&2
    echo "On ANY és un nombre comprès entre 1 i 9998" >&2
    echo "És necessari tindre pdflatex i les llibreries bàsiques de latex" >&2
    exit 1
fi

echo -ne "Preparant el calendari"
LATEX="anuari$$.tex"
ANY_ANT=$1
let ANY_SEG=$ANY_ANT+1
touch $LATEX
echo "\documentclass[10pt,a4paper,landscape,catalan,fleqn]{article}" >> $LATEX
echo "\pagestyle{empty}" >> $LATEX
echo "\usepackage[catalan]{babel}" >> $LATEX
echo "\usepackage[utf8]{inputenc}" >> $LATEX
echo "\usepackage{anysize}" >> $LATEX
echo "\usepackage{hyperref}" >> $LATEX
echo "\usepackage{enumerate}" >> $LATEX
echo "\usepackage{amssymb}" >> $LATEX
echo "\usepackage{amsmath}" >> $LATEX
echo "\usepackage{amsthm}" >> $LATEX
echo "\usepackage{color}" >> $LATEX
echo "\usepackage[T1]{fontenc}" >> $LATEX
echo "\usepackage{times}" >> $LATEX
echo "\usepackage{listings}" >> $LATEX
echo "\marginsize{0.5cm}{0.5cm}{0.5cm}{0.5cm}" >> $LATEX
echo "\begin{document}" >> $LATEX
echo "\begin{center}" >> $LATEX
echo "{\Huge \bf ANUARI ESCOLAR $ANY_ANT-$ANY_SEG}" >> $LATEX
echo "\end{center}" >> $LATEX


echo "\begin{center}" >> $LATEX
echo "\begin{tabular}{c@{\hspace{1cm}}c@{\hspace{1cm}}c@{\hspace{1cm}}c}" >> $LATEX
for j in $(seq 9 12 ; seq 1 8) ; do
    if [ $j -le 8 ] ; then
	ANY=$ANY_SEG
    else
	ANY=$ANY_ANT
    fi
    let VAR=$j-1
    MOD=$(expr $VAR % 4)
    if [ $MOD -eq 0 ] ; then
	echo "\\\ " >> $LATEX
	echo "& & & \\\ " >> $LATEX
    else 
	echo "& " >> $LATEX
    fi
    NUM=0
    INI=$(date -d "$ANY-$j-01" | cut -f 1 -d' ')
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
    case $j in
	1)
	    MES="Gener"
	    ;;
	2)
	    MES="Febrer"
	    ;;
	3)
	    MES="Març"
	    ;;
	4)
	    MES="Abril"
	    ;;
	5)
	    MES="Maig"
	    ;;
	6)
	    MES="Juny"
	    ;;
	7)
	    MES="Juliol"
	    ;;
	8)
	    MES="Agost"
	    ;;
	9)
	    MES="Setembre"
	    ;;
	10)
	    MES="Octubre"
	    ;;
	11)
	    MES="Novembre"
	    ;;
	12)
	    MES="Desembre"
	    ;;
    esac

    echo "\begin{tabular}{|c|c|c|c|c|c|c|}" >> $LATEX
    echo "\multicolumn{7}{c}{$MES}\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    echo "dl&dt&dc&dj&dv&ds&dg\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    echo "\hline" >> $LATEX
    for i in $(seq 2 $INI_NUM) ; do
	echo -ne "& " >> $LATEX
    done
    for i in $($CAL_CMD $j $ANY) ; do 
	if [ $NUM -ge 9 ] ; then 
	    let AUX=$NUM-8
	    let AUX=$AUX+$INI_NUM
	    CONT=$(expr $AUX % 7)
	    if [ $CONT -ne 1 ] ; then
		echo -ne "&" >> $LATEX
	    fi
	    echo -ne "$i" >> $LATEX
	    if [ $CONT -eq 0 ] ; then
		echo "\\\ " >> $LATEX
		echo "\hline" >> $LATEX
	    fi
	fi
	    let NUM=$NUM+1
    done
    echo -ne "."
    if [ $CONT -ne 0 ] ; then
	for i in $(seq $CONT 6) ; do
	    echo -ne "& " >> $LATEX
	done
    echo "\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    fi
    echo "\end{tabular}" >> $LATEX
done
echo "\end{tabular}" >> $LATEX
echo "\end{center}" >> $LATEX
echo "\clearpage" >> $LATEX
echo ""
echo -ne "Preparant l'anuari"
for j in $(seq 9 12; seq 1 8) ; do
    if [ $j -le 8 ] ; then
	ANY=$ANY_SEG
    else
	ANY=$ANY_ANT
    fi
    NUM=0
    INI=$(date -d "$ANY-$j-01" | cut -f 1 -d' ')
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
    case $j in
	1)
	    MES="Gener"
	    ;;
	2)
	    MES="Febrer"
	    ;;
	3)
	    MES="Març"
	    ;;
	4)
	    MES="Abril"
	    ;;
	5)
	    MES="Maig"
	    ;;
	6)
	    MES="Juny"
	    ;;
	7)
	    MES="Juliol"
	    ;;
	8)
	    MES="Agost"
	    ;;
	9)
	    MES="Setembre"
	    ;;
	10)
	    MES="Octubre"
	    ;;
	11)
	    MES="Novembre"
	    ;;
	12)
	    MES="Desembre"
	    ;;
    esac
    MES="$MES $ANY"
    echo "\begin{center}" >> $LATEX
    echo "{\huge $MES}" >> $LATEX
    echo "\end{center}" >> $LATEX
    echo "\\" >> $LATEX
    echo "\begin{center}" >> $LATEX
    echo "\begin{tabular}{|@{\hspace{1.3cm}}c@{\hspace{1.3cm}}|@{\hspace{1.3cm}}c@{\hspace{1.3cm}}|@{\hspace{1.3cm}}c@{\hspace{1.3cm}}|@{\hspace{1.3cm}}c@{\hspace{1.3cm}}|@{\hspace{1.3cm}}c@{\hspace{1.3cm}}|@{\hspace{1.3cm}}c@{\hspace{1.3cm}}|@{\hspace{1.3cm}}c@{\hspace{1.3cm}}|}" >> $LATEX
    echo "\hline" >> $LATEX
    echo "Dilluns&Dimarts&Dimecres&Dijous&Divendres&Dissabte&Diumenge\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    echo "\hline" >> $LATEX
    for i in $(seq 2 $INI_NUM) ; do
	echo -ne "& " >> $LATEX
    done
    for i in $($CAL_CMD $j $ANY) ; do 
	if [ $NUM -ge 9 ] ; then 
	    let AUX=$NUM-8
	    let AUX=$AUX+$INI_NUM
	    CONT=$(expr $AUX % 7)
	    if [ $CONT -ne 1 ] ; then
		echo -ne "&" >> $LATEX
	    fi
	    echo -ne "$i" >> $LATEX
	    if [ $CONT -eq 0 ] ; then
		echo "\\\ " >> $LATEX
		echo "& & & & & &\\\ " >> $LATEX
		echo "& & & & & &\\\ " >> $LATEX
		echo "& & & & & &\\\ " >> $LATEX
		echo "& & & & & &\\\ " >> $LATEX
		echo "& & & & & &\\\ " >> $LATEX
		echo "\hline" >> $LATEX
	    fi
	fi
	    let NUM=$NUM+1
    done
    echo -ne "."
    if [ $CONT -ne 0 ] ; then
	for i in $(seq $CONT 6) ; do
	    echo -ne "& " >> $LATEX
	done
    echo "\\\ " >> $LATEX
    echo "& & & & & &\\\ " >> $LATEX
    echo "& & & & & &\\\ " >> $LATEX
    echo "& & & & & &\\\ " >> $LATEX
    echo "& & & & & &\\\ " >> $LATEX
    echo "& & & & & &\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    fi
    echo "\end{tabular}" >> $LATEX
    echo "\end{center}" >> $LATEX
    echo "\clearpage" >> $LATEX
done

echo "\end{document}" >> $LATEX
echo ""
echo -ne "Preparant el pdf."
pdflatex anuari$$.tex >> /dev/null
echo -ne "."
rm anuari$$.tex anuari$$.aux anuari$$.log anuari$$.out
mv anuari$$.pdf anuari$ANY_ANT-$ANY_SEG.pdf
echo -ne ".\n"
echo "Creat l'arxiu anuari$ANY_ANT-$ANY_SEG.pdf"
