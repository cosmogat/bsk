#!/bin/bash
# 19-03-2019
# alex
# canvi_nom.sh

if [ $# -ne 3 ] ; then
    echo "Canvi de nom multiple"  >&2
    echo "" >&2
    echo "Utilitzeu: $(basename $0) patro_fitxers cadena_original cadena_nova" >&2
    echo "Tots el fitxers que contingen 'patro_fitxers' en el seu nom se'ls canviara 'cadena_original' per 'cadena_nova'"
    exit 1
fi

ARXIUS=$1
ORIG=$2
NOVA=$3

ANTIC_IFS=$IFS
IFS=$(echo -en "\n\b")
for i in $(ls -d *"$ARXIUS"*) ; do
    ARX_ORIG="$i"
    ARX_NOU=$(echo "${ARX_ORIG/$ORIG/$NOVA}")
    if [ $ARX_ORIG != $ARX_NOU ] ; then
	echo "$ARX_ORIG -> $ARX_NOU"
	mv "$ARX_ORIG" "$ARX_NOU"
    fi
done
IFS=$ANTIC_IFS
exit 0
