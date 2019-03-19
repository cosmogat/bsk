#!/bin/bash
# 15-06-2018
# alex
# install.sh

DESTI="/usr/local/bin"
DIR=$PWD

if [ $UID -ne 0 ] ; then  
    echo "Has de ser root" >&2
    exit 1
fi

cd anuaris
cp anuari.sh "$DESTI/anuari"
cp anuari_escolar.sh "$DESTI/anuari_escolar"
cd $DESTI
chown root:staff anuari anuari_escolar
chmod 755 anuari anuari_escolar
cd $DIR

cd genmake
cp genmake.sh "$DESTI/genmake"
cd $DESTI
chown root:staff genmake
chmod 755 genmake
cd $DIR

cd imprimirCodi
cp imprimirCodi.sh "$DESTI/imprimirCodi"
cd $DESTI
chown root:staff imprimirCodi
chmod 755 imprimirCodi
cd $DIR

cd informacio
cp informacio.sh "$DESTI/informacio"
cd $DESTI
chown root:staff informacio
chmod 755 informacio
cd $DIR

cd orgMusica
cp orgMusica.sh "$DESTI/orgMusica"
cd $DESTI
chown root:staff orgMusica
chmod 755 orgMusica
cd $DIR

cd reanomenarJPG
cp reanomenarJPG.sh "$DESTI/reanomenarJPG"
cd $DESTI
chown root:staff reanomenarJPG
chmod 755 reanomenarJPG
cd $DIR

cd crear
cp crear.sh "$DESTI/crear"
cd $DESTI
chown root:staff crear
chmod 755 crear
cd $DIR

cd latex_print
cp latex_print.sh "$DESTI/latex_print"
cd $DESTI
chown root:staff latex_print
chmod 755 latex_print
cd $DIR

cd canvi_nom
cp canvi_nom.sh "$DESTI/canvi_nom"
cd $DESTI
chown root:staff canvi_nom
chmod 755 canvi_nom
cd $DIR

cd filmaffinity
cp filmaffinity.py "$DESTI/filmaffinity"
cd $DESTI
chown root:staff filmaffinity
chmod 755 filmaffinity
cd $DIR

cd c_fitxers
gcc hont.c -o "$DESTI/hont"
gcc mcd.c -o "$DESTI/mcd"
gcc mitjana.c -o "$DESTI/mitjana"
gcc str_replace.c -o "$DESTI/str_replace"
cd $DESTI
chown root:staff hont mcd mitjana str_replace
chmod 755 hont mcd mitjana str_replace
cd $DIR
