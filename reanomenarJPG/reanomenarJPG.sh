#!/bin/bash
# 21-06-2010
# billy
# reanomenarJPG.sh

#ini=$(ls {,.}* | wc -l)

for i in "$@" ; do
    if [ -f "$i" ] ; then
	direc=$(dirname "$i")
	case "$i" in
	    *.JPG | *.JPEG | *.jpg | *.jpeg)
		nounom=$(jhead "$i" 2> /dev/null | grep Date/Time | cut -d":" -f2- | cut -d" " -f2- | tr '[=:=]' '_' | tr '[= =]' '-')
		if [ -z "$nounom" ] ; then
		    nounom="sense_data"
		fi
		if [ -f "$direc"/"$nounom.jpg" ] ; then
		    let num=0
		    while [ -f "$direc"/"$nounom"__"$num".jpg ] ; do
			let num++
		    done
		    nounom="$nounom"__"$num"
		fi
		echo -e "\033[32m$i\033[0m -> \033[32m$nounom.jpg\033[0m"
		mv "$i" "$direc"/"$nounom.jpg"
		;;
	    *)
		echo -e "\033[32m$i\033[0m \033[33mno es un arxiu valid.\033[0m" >&2
		;;
	esac
    else
	echo -e "\033[32m$i\033[0m \033[33mno es un arxiu.\033[0m" >&2
    fi
done

#fin=$(ls {,.}* | wc -l)

#if [ $ini -ne $fin ] ; then
#    echo -e "\033[31mS'han perdut fotos.\033[0m" >&2
#    exit 2
#fi

if [ $# -eq 0 ] ; then
    echo "Utilitzeu:"  >&2
    echo -e "\t\033[32m$(basename $0) fotos\033[0m" >&2
    echo -e "\t\033[32m$(basename $0)\033[0m serveix per a renombrar \033[32mfotos\033[0m utilitzant la data de quan es van fer." >&2
    #echo -e "\033[33mLes fotos no deuen tindre espais.\033[0m" >&2
    exit 1
fi
exit 0
