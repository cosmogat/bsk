#!/bin/bash
# 13-06-2010
# alex

if [ $# -ne 0 ] ; then
    data=$(date +%d-%m-%Y)
    dataT=$(date "+%d %b de %Y")
    jo=$(whoami)
    # if [ $jo = "alex" ] ; then
    # 	jo="billy"
    # fi
    for i in $* ; do
	if [ ! -f $i ] ; then
	    touch $i
	    case $i in 
		*.h)
		    echo "/* $data */" >> $i
		    echo "/* $jo */" >> $i
		    echo "/* $i */" >> $i
		    nom=$(basename $i .h)
		    def="_$(echo $nom | tr '[:lower:]' '[:upper:]')_H"
		    echo "#ifndef $def" >> $i
		    echo "#define $def" >> $i
		    echo "#include <stdio.h>" >> $i
		    echo "#include <stdlib.h>" >> $i
		    echo "" >> $i
		    echo "#endif" >> $i
		    ;;
		*.hh | *h++ | *.H)
		    echo "// $data" >> $i
		    echo "// $jo" >> $i
		    echo "// $i" >> $i
		    case $i in
			*.hh)
			    nom=$(basename $i .hh)
			    ;;
			*.h++)
			    nom=$(basename $i .h++)
			    ;;
			*.H)
			    nom=$(basename $i .H)
			    ;;
		    esac
		    def="_$(echo $nom | tr '[:lower:]' '[:upper:]')_HH"
		    echo "#ifndef $def" >> $i
		    echo "#define $def" >> $i
		    echo "#include <iostream>" >> $i
		    echo "#include <cstdlib>" >> $i
		    echo "using namespace std;" >> $i
		    echo "" >> $i
		    echo "#endif" >> $i		    
		    ;;
		*.c)
		    echo "/* $data */" >> $i
		    echo "/* $jo */" >> $i
		    echo "/* $i */" >> $i
		    echo "#include <stdio.h>" >> $i
		    echo "#include <stdlib.h>" >> $i
		    echo "" >> $i
		    echo "" >> $i
		    echo "int main (int num_arg, char * vec_arg[]) {" >> $i
		    echo "" >> $i
		    echo "  return 0;" >> $i
		    echo "}" >> $i
		    ;;
		*.cc | *.c++ | *.cpp | *.C | *.cxx)
		    echo "// $data" >> $i
		    echo "// $jo" >> $i
		    echo "// $i" >> $i
		    echo "#include <iostream>" >> $i
		    echo "#include <cstdlib>" >> $i
		    echo "using namespace std;" >> $i
		    echo "" >> $i
		    echo "" >> $i
		    echo "int main (int num_arg, char * vec_arg[]) {" >> $i
		    echo "" >> $i
		    echo "  return 0;" >> $i
		    echo "}" >> $i		    
		    ;;
		*.cs)
		    echo "// $data" >> $i
		    echo "// $jo" >> $i
		    echo "// $i" >> $i
		    echo "using System;" >> $i
		    ;;
		*.py)
		    echo "#!/usr/bin/env python" >> $i
		    echo "# -*- coding: utf-8 -*- " >> $i
		    echo "# $data" >> $i
		    echo "# $jo" >> $i
		    echo "# $i" >> $i
		    ;;
		*.php)
		    echo "<?php" >> $i
		    echo "// $data" >> $i
		    echo "// $jo" >> $i
		    echo "// $i" >> $i
		    ;;		
		*.sh)
		    echo "#!/bin/bash" >> $i
		    echo "# $data" >> $i
		    echo "# $jo" >> $i
		    echo "# $i" >> $i
		    #chmod u+x $i
		    ;;
		*.m)
		    echo "#!/usr/bin/octave --no-gui -q" >> $i
		    echo "# $data" >> $i
		    echo "# $jo" >> $i
		    echo "# $i" >> $i
		    echo "" >> $i
		    echo "pause()" >> $i
		    #chmod u+x $i
		    ;;
		*.plt)
		    nom=$(basename $i .plt)
		    echo "# $data" >> $i
		    echo "# $jo" >> $i
		    echo "# $i" >> $i
		    echo "reset" >> $i
		    echo "set term wxt persist" >> $i
		    echo "# set term png" >> $i
		    echo "# set output '$nom.png'" >> $i
		    echo "set palette defined (0 '#000090', 1 '#000FFF', 2 '#0090FF', 3 '#0FFFEE', 4 '#90FF70', 5 '#FFEE00', 6 '#FF7000', 7 '#EE0000', 8 '#7F0000')" >> $i
		    echo "# set grid" >> $i
		    echo "set style line 1  lt rgb '#0060AD'" >> $i
		    echo "set style line 2  lt rgb '#60AD00'" >> $i
		    echo "set style line 3  lt rgb '#AD0B00'" >> $i
		    echo "set style line 4  lt rgb '#E7E730'" >> $i
		    echo "set style line 5  lt rgb '#E730E7'" >> $i
		    echo "set style line 6  lt rgb '#30E7E7'" >> $i
		    echo "set style line 7  lt rgb '#707070'" >> $i
		    echo "set style line 8  lt rgb '#FF8E1E'" >> $i
		    echo "set style line 9  lt rgb '#202020'" >> $i
		    echo "set style line 10 lt rgb '#F000F0'" >> $i 
		    ;;
		*.tex)
		    nom=$(basename $i .tex)
		    echo "% $data" >> $i
		    echo "% $jo" >> $i
		    echo "% $i" >> $i
		    echo "\documentclass[10pt,a4paper,catalan,twoside]{article}" >> $i
		    echo "\usepackage[catalan]{babel}" >> $i
		    echo "\usepackage[utf8]{inputenc}" >> $i
		    echo "\usepackage{ifpdf}" >> $i
		    echo "\usepackage{anysize}" >> $i
		    echo "\usepackage[colorlinks=true,linkcolor=blue,urlcolor=black]{hyperref}" >> $i
		    echo "\usepackage{enumerate}" >> $i
		    echo "\usepackage{amssymb}" >> $i
		    echo "\usepackage{amsmath}" >> $i
		    echo "\usepackage{amsthm}" >> $i
		    echo "\usepackage{color, colortbl}" >> $i
		    echo "\usepackage[T1]{fontenc}" >> $i
		    echo "\usepackage{listings}" >> $i
		    echo "\usepackage{subfig}" >> $i
		    echo "\usepackage[margin=1cm]{caption}" >> $i
		    echo "\marginsize{2cm}{2cm}{2cm}{2cm}" >> $i
		    echo "\ifpdf" >> $i
		    echo "  \usepackage[pdftex]{graphicx}" >> $i
		    echo "  \DeclareGraphicsExtensions{.pdf,.png,.jpg}" >> $i
		    echo "\else" >> $i
		    echo "  \usepackage[dvips]{graphicx}" >> $i
		    echo "  \DeclareGraphicsExtensions{.eps}" >> $i
		    echo "\fi" >> $i
		    echo "\definecolor{verd}{rgb}{0.7, 1, 0.5}" >> $i
		    echo "\definecolor{groc}{rgb}{1, 1, 0.4}" >> $i
		    echo "\definecolor{blau}{rgb}{0.2, 0.5, 1}" >> $i
		    echo "\definecolor{cyan}{rgb}{0, 1, 1}" >> $i
		    echo "\definecolor{ombra}{rgb}{0.95, 0.95, 1}" >> $i
		    echo "\allowdisplaybreaks" >> $i
		    echo "\title{$nom}"
		    echo "\author{$jo}"
		    echo "\date{$dataT}"
		    echo "\makeindex" >> $i
		    echo "\begin{document}" >> $i
		    echo "\maketitle" >> $i
		    echo "" >> $i
		    echo "\end{document}" >> $i
		    ;;
		*)
		    ;;
	    esac
	else
	    touch $i
	fi
    done
fi
    
		
