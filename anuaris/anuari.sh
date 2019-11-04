#!/bin/bash
# 24-01-2012
# alex
# anuari.sh

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

function pasqua {
    A=$1
    let a=$A%19
    let b=$A%4
    let c=$A%7
    let k=$A/100
    let p1=8*$k
    let p=(13+$p1)/25
    let q=$k/4
    let M=(15-$p+$k-$q)%30
    let N=(4+$k-$q)%7
    let d1=19*$a
    let d=($d1+$M)%30
    let e1=2*$b
    let e2=4*$c
    let e3=6*$d
    let e=($e1+$e2+$e3+$N)%7
    let sum=$d+$e
    if [ $sum -lt 10 ] ; then
	let dia=$sum+22
	let mes=3
    else
	let dia=$sum-9
	let mes=4
	if [ $dia -eq 26 ] ; then
	    dia=19
	elif [ $dia -eq 25 ] && [ $d -eq 28 ] && [ $e -eq 6 ] && [ $a -gt 10 ] ; then
	    dia=18
	fi
    fi
    echo "$dia-$mes"
}

function magpas_rang {
    dia_p=$1
    mes_p=$2
    let dia_pi=dia_p-2
    let dia_pf=dia_p+7
    mes_pi=$mes_p
    mes_pf=$mes_p
    dies_febrer=28
    let bisA=$1%4
    let bisB=$1%100
    let bisC=$1%400
    if [ $bisC -eq 0 ] ; then
	dies_febrer=29
    elif [ $bisA -eq 0 ] && [ $bisB -ne 0 ] ; then
	dies_febrer=29
    fi
    if [ $dia_pi -lt 1 ] ; then
	let dia_pi=$dia_pi+31
	let mes_pi=$mes_pi-1
    fi
    if [ $mes_pf -eq 3 ] && [ $dia_pf -gt 31 ] ; then
	let dia_pf=$dia_pf-31
	let mes_pf=$mes_pf+1
    fi
    if [ $mes_pf -eq 4 ] && [ $dia_pf -gt 30 ] ; then
	let dia_pf=$dia_pf-30
	let mes_pf=$mes_pf+1
    fi
    let dia_mi=$dia_pi-27
    mes_mi=$mes_pi
    if [ $dia_mi -lt 1 ] ; then
	if [ $mes_mi -eq 3 ] ; then
	    let dia_mi=$dia_mi+$dies_febrer
	elif [ $mes_mi -eq 4 ] ; then
	    let dia_mi=$dia_mi+31
	fi
	let mes_mi=$mes_mi-1
    fi
    let dia_mf=$dia_mi+8
    mes_mf=$mes_mi
    if [ $mes_mf -eq 2 ] ; then
	if [ $dia_mf -gt $dies_febrer ] ; then
	    let dia_mf=$dia_mf-$dies_febrer
	    let mes_mf=$mes_mf+1
	fi
    elif [ $mes_mf -eq 3 ] ; then
	if [ $dia_mf -gt 31 ] ; then
	    let dia_mf=$dia_mf-31
	    let mes_mf=$mes_mf+1
	fi
    elif [ $mes_mf -eq 4 ] ; then
	if [ $dia_mf -gt 30 ] ; then
	    let dia_mf=$dia_mf-30
	    let mes_mf=$mes_mf+1
	fi    
    fi
    echo "$dia_mi-$mes_mi-$dia_mf-$mes_mf-$dia_pi-$mes_pi-$dia_pf-$mes_pf"
    }

function color_festa {
    ret=""
    dia_sem=$1
    mm=$2
    dd=$3
    dmi=$4
    mmi=$5
    dmf=$6
    mmf=$7
    dpi=$8
    mpi=$9
    dpf=${10}
    mpf=${11}
    if [ $dia_sem -eq 0 ] ; then
	ret=" \cellcolor{fes1} "
    elif [ $mm -eq 1 ] && [ $dd -eq 1 ] ; then
	ret=" \cellcolor{fes1} "
    elif [ $mm -eq 1 ] && [ $dd -eq 6 ] ; then
	ret=" \cellcolor{fes1} "
    elif [ $mm -eq 5 ] && [ $dd -eq 1 ] ; then
	ret=" \cellcolor{fes1} "  
    elif [ $mm -eq 8 ] && [ $dd -eq 15 ] ; then
	ret=" \cellcolor{fes1} "
    elif [ $mm -eq 10 ] && [ $dd -eq 9 ] ; then
	ret=" \cellcolor{fes1} "
    elif [ $mm -eq 10 ] && [ $dd -eq 12 ] ; then
	ret=" \cellcolor{fes1} "
    elif [ $mm -eq 11 ] && [ $dd -eq 1 ] ; then
	ret=" \cellcolor{fes1} "
    elif [ $mm -eq 12 ] && [ $dd -eq 6 ] ; then
	ret=" \cellcolor{fes1} "
    elif [ $mm -eq 12 ] && [ $dd -eq 8 ] ; then
	ret=" \cellcolor{fes1} "
    elif [ $mm -eq 12 ] && [ $dd -eq 25 ] ; then
	ret=" \cellcolor{fes1} "
    elif [ $mm -eq 12 ] && [ $dd -gt 25 ] ; then
	ret=" \cellcolor{fes2} "
    elif [ $mm -eq 1 ] && [ $dd -gt 1 ] && [ $dd -le 5 ] ; then
	ret=" \cellcolor{fes2} "
    elif [ $mm -eq 8 ] ; then
	ret=" \cellcolor{fes3} "	   
    elif [ $mm -eq $mmi ] && [ $mmi -eq $mmf ] && [ $dd -ge $dmi ] && [ $dd -le $dmf ] ; then
	ret=" \cellcolor{fes2} "
    elif [ $mm -eq $mmi ] && [ $mmi -ne $mmf ] && [ $dd -ge $dmi ] ; then
	ret=" \cellcolor{fes2} "
    elif [ $mm -eq $mmf ] && [ $mmi -ne $mmf ] && [ $dd -le $dmf ] ; then
	ret=" \cellcolor{fes2} "
    elif [ $mm -eq $mpi ] && [ $mpi -eq $mpf ] && [ $dd -ge $dpi ] && [ $dd -le $dpf ] ; then
	ret=" \cellcolor{fes2} "
    elif [ $mm -eq $mpi ] && [ $mpi -ne $mpf ] && [ $dd -ge $dpi ] ; then
	ret=" \cellcolor{fes2} "
    elif [ $mm -eq $mpf ] && [ $mpi -ne $mpf ] && [ $dd -le $dpf ] ; then
	ret=" \cellcolor{fes2} "
    else
	ret=" \cellcolor{blanc} "
    fi
    echo $ret
}

function comprovacions {
    EIXIDA=0
    PARAMS=""
    ANY=0
    es_num="^[0-9]+$"
    if [ $# -eq 2 ] ; then
	ANY=$2
	PARAMS=$1
    elif [ $# -eq 1 ] ; then
	ANY=$1
    else
	EIXIDA=1
    fi
    COLOR=$(echo $PARAMS | grep "-" | grep "c" | wc -l)
    ESCOL=$(echo $PARAMS | grep "-" | grep "s" | wc -l)
    BACKG=$(echo $PARAMS | grep "-" | grep "b" | wc -l)
    if ! [[ $ANY =~ $es_num ]] || [ $ANY -le 0 ] || [ $ANY -ge 9999 ] ; then
	ANY=0
	EIXIDA=1
    fi
    echo "$EIXIDA-$COLOR-$ESCOL-$BACKG-$ANY"
    }

cadena=$(comprovacions $@)
EIXIDA=$(echo $cadena | cut -d'-' -f 1)
CCOLOR=$(echo $cadena | cut -d'-' -f 2)
CESCOL=$(echo $cadena | cut -d'-' -f 3)
CBACKG=$(echo $cadena | cut -d'-' -f 4)
ANY=$(echo $cadena | cut -d'-' -f 5)
if [ $EIXIDA -eq 1 ] ; then
    nom=$(basename $0)
    echo "Utilitzeu: $nom [-cs] ANY" >&2
    echo "On l'opció -c és per pintar els festius" >&2
    echo "On l'opció -s és per fer anuari escolar" >&2
    echo "On l'opció -b és per pintar colors de fons" >&2
    echo "On ANY és un any comprès entre 1 i 9999" >&2
    echo "És necessari tindre pdflatex i les llibreries bàsiques de latex" >&2
    exit 1    
fi

ANY_P=$ANY
if [ $CESCOL -eq 1 ] ; then
    let ANY_P=$ANY+1
fi
pas=$(pasqua $ANY_P)
dia_p=$(echo $pas | cut -d'-' -f 1)
mes_p=$(echo $pas | cut -d'-' -f 2)
rang=$(magpas_rang $dia_p $mes_p)
dia_mi=$(echo $rang | cut -d'-' -f 1)
mes_mi=$(echo $rang | cut -d'-' -f 2)
dia_mf=$(echo $rang | cut -d'-' -f 3)
mes_mf=$(echo $rang | cut -d'-' -f 4)
dia_pi=$(echo $rang | cut -d'-' -f 5)
mes_pi=$(echo $rang | cut -d'-' -f 6)
dia_pf=$(echo $rang | cut -d'-' -f 7)
mes_pf=$(echo $rang | cut -d'-' -f 8)
SEQ=$(seq 1 12)
if [ $CESCOL -eq 1 ] ; then
    SEQ=$(seq 9 12; seq 1 8)
fi
FB=" \cellcolor{blanc} "
MESOS=("" "Gener" "Febrer" "Març" "Abril" "Maig" "Juny" "Juliol" "Agost" "Setembre" "Octubre" "Novembre" "Desembre")
echo -ne "Preparant el calendari"
LATEX="anuari$$.tex"
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
echo "\usepackage{xcolor,colortbl}" >> $LATEX
echo "\usepackage[T1]{fontenc}" >> $LATEX
echo "\usepackage{times}" >> $LATEX
echo "\usepackage{listings}" >> $LATEX
echo "\usepackage{wasysym}" >> $LATEX
echo "\marginsize{0.0cm}{0.0cm}{0.0cm}{0.0cm}" >> $LATEX
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
if [ $CBACKG -eq 1 ] ; then
    echo "\pagecolor{col00}" >> $LATEX  
fi
echo "\begin{center}" >> $LATEX
if [ $CESCOL -eq 0 ] ; then
    echo "{\Huge \bf ANUARI $ANY}" >> $LATEX
else
    echo "{\Huge \bf ANUARI ESCOLAR $ANY-$ANY_P}" >> $LATEX
fi
echo "\end{center}" >> $LATEX
echo "\begin{center}" >> $LATEX
echo "\begin{tabular}{c@{\hspace{1cm}}c@{\hspace{1cm}}c@{\hspace{1cm}}c}" >> $LATEX

for j in $SEQ ; do
    let VAR=$j-1
    MOD=$(expr $VAR % 4)
    if [ $MOD -eq 0 ] ; then
	echo "\\\ " >> $LATEX
	echo "& & & \\\ " >> $LATEX
    else 
	echo "& " >> $LATEX
    fi
    NUM=0
    ANY_P=$ANY
    if [ $CESCOL -eq 1 ] && [ $j -le 8 ] ; then
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
    echo "\begin{tabular}{|c|c|c|c|c|c|c|}" >> $LATEX
    echo "\multicolumn{7}{c}{$MES}\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    echo "$FB dl&$FB dt&$FB dc&$FB dj&$FB dv&$FB ds&$FB dg\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    echo "\hline" >> $LATEX
    if [ $INI_NUM -gt 0 ] ; then
	echo -n "$FB" >> $LATEX
    fi   
    for i in $(seq 2 $INI_NUM) ; do
	echo -n "&$FB " >> $LATEX
    done
    for i in $($CAL_CMD $j $ANY_P  | tail -n 6) ; do 
	let AUX=$NUM+1
	let AUX=$AUX+$INI_NUM
	CONT=$(expr $AUX % 7)
	if [ $CONT -ne 1 ] ; then
	    echo -ne "&" >> $LATEX
	fi
	color=""
	if [ $CCOLOR -eq 1 ] ; then
	    color=$(color_festa $CONT $j $i $dia_mi $mes_mi $dia_mf $mes_mf $dia_pi $mes_pi $dia_pf $mes_pf)
	else
	    color="$FB"
	fi
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
	    echo -n "&$FB " >> $LATEX
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
for j in $SEQ ; do 
    NUM=0
    ANY_P=$ANY
    if [ $CESCOL -eq 1 ] && [ $j -le 8 ] ; then
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
    if [ $CBACKG -eq 1 ] ; then
	colbg=$(printf "%.2d" $j)
	echo "\pagecolor{col$colbg}" >> $LATEX
    fi
    echo "\begin{center}" >> $LATEX
    echo "{\huge \textbf{$MES $ANY_P}}" >> $LATEX
    echo "\end{center}" >> $LATEX
    echo "\\" >> $LATEX
    echo "\begin{center}" >> $LATEX
    echo "\begin{tabular}{|*{7}{p{3.5cm}|}}" >> $LATEX
    echo "\hline" >> $LATEX
    echo "$FB\textbf{Dilluns}&$FB\textbf{Dimarts}&$FB\textbf{Dimecres}&$FB\textbf{Dijous}&$FB\textbf{Divendres}&$FB\textbf{Dissabte}&$FB\textbf{Diumenge}\\\ " >> $LATEX
    echo "\hline" >> $LATEX
    echo "\hline" >> $LATEX
    if [ $INI_NUM -gt 0 ] ; then
	echo -n "$FB" >> $LATEX
    fi
    for i in $(seq 2 $INI_NUM) ; do
	echo -n "&$FB" >> $LATEX
    done
    COLORS=("$FB" "$FB" "$FB" "$FB" "$FB" "$FB" "$FB")
    for i in $($CAL_CMD $j $ANY_P | tail -n 6) ; do 
	let AUX=$NUM+1
	let AUX=$AUX+$INI_NUM
	CONT=$(expr $AUX % 7)
	if [ $CONT -ne 1 ] ; then
	    echo -n "&$FB" >> $LATEX
	fi
	color=""
	if [ $CCOLOR -eq 1 ] ; then
	    color=$(color_festa $CONT $j $i $dia_mi $mes_mi $dia_mf $mes_mf $dia_pi $mes_pi $dia_pf $mes_pf)
	else
	    color=$FB
	fi
	COLORS[$CONT]=$color
	echo -n "$color" >> $LATEX
	echo -n "\textbf{$i}" >> $LATEX
	if [ $CONT -eq 0 ] ; then
	    echo "\\\ " >> $LATEX
	    for k in $(seq 1 5) ; do
		echo "${COLORS[1]}&${COLORS[2]} &${COLORS[3]} &${COLORS[4]} &${COLORS[5]} &${COLORS[6]} &${COLORS[0]}\\\ " >> $LATEX
	    done
	    echo "\hline" >> $LATEX
	fi
	let NUM=$NUM+1
    done
    echo -ne "."
    if [ $CONT -ne 0 ] ; then
	for i in $(seq $CONT 6) ; do
	    echo -n "&$FB" >> $LATEX
	    let ind=$i+1
	    COLORS[$ind]="$FB"
	done
	COLORS[0]="$FB"
	echo "\\\ " >> $LATEX
	for k in $(seq 1 5) ; do
	    echo "${COLORS[1]}&${COLORS[2]} &${COLORS[3]} &${COLORS[4]} &${COLORS[5]} &${COLORS[6]} &${COLORS[0]}\\\ " >> $LATEX
	done
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
mv anuari$$.pdf anuari$ANY.pdf
echo -ne ".\n"
echo "Creat l'arxiu anuari$ANY.pdf"
