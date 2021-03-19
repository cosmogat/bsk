#!/bin/bash
# genmake.sh: generador de makefiles
# 01-05-2010
# alex

dir=$PWD # Desem el directori actual
bool=1   # Despres la gastarem per a vore si es latex
exe=$3   # Desem el tercer argument

# Comprovem que s'ha cridat correctament a l'script
if [ $# -lt 2 ] ; then
    nom=$(basename $0)
    echo "Utilitzeu: $nom directori extensio [executable]" >&2
    echo "On:" >&2
    echo -e "\tdirectori  -> es el directori on es troben el arxius de codi" >&2
    echo -e "\textensio   -> son les extensions que tenen el arxius de codi" >&2
    echo -e "\texecutable -> es l'executable que vols que cree el make. Sols per a C/C++" >&2 ; exit 1
fi

if [ ! -d $1 ] ; then
    echo "$1 no es cap directori" >&2 ; exit 1
fi

# Comprovem les extensions
if [ $2 = "c" ] ; then
    comp=gcc
elif [ $2 = "C" ] ; then
    comp=gcc
elif [ $2 = "cc" ] ; then
    comp=g++
elif [ $2 = "cpp" ] ; then
    comp=g++
elif [ $2 = "c++" ] ; then
    comp=g++
elif [ $2 = "cxx" ] ; then
    comp=g++
elif [ $2 = "tex" ] ; then
    bool=0
else
    echo "L'extensio $2 no esta permesa" >&2 ; exit 1
fi

# Comprovem que com a minim hi haga un arxiu dins de $1 que tinga extensio $2
cd $1
arxiu=$(ls *.$2 2> /dev/null | tail -n1)
if [ -z $arxiu ] ; then
    echo "No hi ha cap arxiu amb la extensio $2 dins de $1" >&2 ; exit 1
fi

# Comprovem si el tercer argument esta buit per a donar-li un valor per defecte
if [ -z $exe ] ; then
    exe=$(basename $PWD)
# Comprovem que el tercer argument siga un nom sense ruta
elif [ $exe != $(basename $exe) ] ; then
    echo "$exe no es un nom sense ruta" >&2 ; exit 1
fi

# Traem per l'eixida estandard la data i l'usuari
echo -n "# "
date +%d-%m-%Y
echo -n "# "
jo=$(whoami)
# if [ $jo = "alex" ] ; then
#     jo="billy"
# fi
echo "$jo"
echo ""

# Comprovem si es per a latex o C/C++
if [ $bool -ne 0 ] ; then
    # Es tracta de C/C++
    echo "EXE = $exe # Executable"
    
    echo -n "OBJ = "
    ext=o
    for i in *.$2 ; do
	nom=$(basename $i $2)
	echo -n "$nom$ext "
    done
    echo "# Objectes"
    echo "COM = $comp # Compilador"
    echo "LIB = # Llibreries (-l*, -L*, -I*)"
    if [ $comp = "gcc" ] ; then
	echo "MAC = -D_GNU_SOURCE # Macros (-D*)"
    else
	echo "MAC = # Macros (-D*)"
    fi
    echo "AVS = -W -Wall -Wextra -ansi -pedantic # Avisos"
    echo "OPT = -march=native -O2 -pipe # Optimitzacio"
    echo 'DEP = -g -DDEBUG # Depuracio, no recomanable junt amb $(OPT)'
    if [ $comp = "gcc" ] ; then
	echo 'OPC = $(DEP) $(AVS) $(MAC) -std=c11 # Opcions'
    else
	echo 'OPC = $(DEP) $(AVS) $(MAC) -std=c++14 # Opcions'
    fi
    echo 'DIR = /usr/local/bin # Directori per a instalar'
    echo ""
    echo 'all: $(EXE)'
    echo ""
    echo '$(EXE): $(OBJ)'
    echo -e '\t@echo Enllaçant $(OBJ) per a crear $(EXE)'
    echo -e '\t$(COM) $(LIB) $(OBJ) -o $@'
    echo ""
    for i in *.$2 ; do
	$comp -MM $i
	echo -e '\t@echo Compilant $<'
	echo -e '\t$(COM) $(OPC) -c $<'
	echo ""
    done
    echo "exe: all"
    echo -e '\t./$(EXE)'
    echo ""
    echo "install: all"
    echo -e '\tmkdir -p $(DIR)'
    echo -e '\tcp $(EXE) $(DIR)'
    echo -e '\tchown root:staff $(EXE)'
    echo ""
    echo "clean:"
    echo -e "\t@echo Netejant..."
    echo -e '\trm -rf $(EXE) $(OBJ) *~'
else
    # Es tracta de latex
    arxiu=$(basename $arxiu .$2)
    echo "define esborrar"
    echo -e '\trm -rf *~ *.aux *.auxlock *.log *.toc *.lof *.lot *.bbl *.blg *.idx *.ilg *.ind *.out tex/*~ tex/*.log 2> /dev/null'
    echo "endef"
    echo ""
    echo "define esborrar_tot"
    echo -e '\t$(call esborrar)'
    echo -e '\trm -rf *.dvi *.pdf *.txt 2> /dev/null'
    echo "endef"
    echo ""
    echo "FITXER = $arxiu"
    echo "LATEX = latex"
    echo "PLATEX = pdflatex"
    echo "BIBLTX = bibtex"
    echo "INDLTX = makeindex"
    echo "PDF = dvipdft"
    echo "TXT = pdftotext"
    echo "HTML = latex2html"
    echo ""
    echo "pdf:"
    echo -e '#\t$(PLATEX) $(FITXER).tex'
    echo -e '#\t$(BIBLTX) $(FITXER)'
    echo -e '#\t$(INDLTX) $(FITXER)'
    for i in $(seq 1 2) ; do
	echo -e '\t$(PLATEX) $(FITXER).tex'
    done
    echo -e "\t\$(call esborrar)"
    echo ""
    echo "pdf2: dvi"
    echo -e '\t$(PDF) $(FITXER).dvi'
    echo -e '\trm -f $(FITXER).dvi'
    echo ""
    echo "dvi:"
    echo -e '#\t$(LATEX) $(FITXER).tex'
    echo -e '#\t$(BIBLTX) $(FITXER)'
    echo -e '#\t$(INDLTX) $(FITXER)'
    for i in $(seq 1 2) ; do
	echo -e '\t$(LATEX) $(FITXER).tex'
    done
    echo -e '\t$(call esborrar)'
    echo ""
    echo "txt: pdf"
    echo -e '\t$(TXT) $(FITXER).pdf'
    echo ""
    echo "html:"
    echo -e '\t$(HTML) $(FITXER).tex'
    echo ""
    echo "all: txt html dvi"
    echo ""
    echo "clean:"
    echo -e '\t$(call esborrar_tot)'
fi
# Tornem al directori del principi
cd "$dir"
