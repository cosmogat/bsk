#!/bin/bash
# 13-06-2010
# billy

if [ $# -ne 0 ] ; then
    data=$(date +%d-%m-%Y)
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
		*.gnuplot | *.plt | *.gpi)
		    echo "# $data" >> $i
		    echo "# $jo" >> $i
		    echo "# $i" >> $i
		    echo "reset" >> $i
		    echo "set term qt persist" >> $i
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
		    echo "\usepackage{color}" >> $i
		    echo "\usepackage[T1]{fontenc}" >> $i
		    echo "\usepackage{listings}" >> $i
		    echo "\usepackage{subfig}" >> $i
		    echo "\marginsize{2cm}{2cm}{2cm}{2cm}" >> $i
		    echo "\ifpdf" >> $i
		    echo "  \usepackage[pdftex]{graphicx}" >> $i
		    echo "  \DeclareGraphicsExtensions{.pdf,.png,.jpg}" >> $i
		    echo "\else" >> $i
		    echo "  \usepackage[dvips]{graphicx}" >> $i
		    echo "  \DeclareGraphicsExtensions{.eps}" >> $i
		    echo "\fi" >> $i
		    echo "\definecolor{gray97}{gray}{.97}" >> $i
		    echo "\definecolor{gray75}{gray}{.75}" >> $i
		    echo "\definecolor{gray45}{gray}{.45}" >> $i
		    echo "\lstset{" >> $i
		    echo "  framerule=0pt," >> $i
		    echo "  aboveskip=0.5cm," >> $i
		    echo "  framextopmargin=3pt," >> $i
		    echo "  framexbottommargin=3pt," >> $i
		    echo "  framexleftmargin=0.2cm," >> $i
		    echo "  framesep=0pt," >> $i
		    echo "  rulesep=.4pt," >> $i
		    echo "  backgroundcolor=\color{gray97}," >> $i
		    echo "  rulesepcolor=\color{black}," >> $i
		    echo "  stringstyle=\ttfamily," >> $i
		    echo "  showstringspaces = false," >> $i
		    echo "  basicstyle=\scriptsize," >> $i
		    echo "  commentstyle=\color{gray45}," >> $i
		    echo "  keywordstyle=\bfseries," >> $i
		    echo "  numbers=left," >> $i
		    echo "  numbersep=15pt," >> $i
		    echo "  numberstyle=\tiny," >> $i
		    echo "  numberfirstline = false," >> $i
		    echo "  breaklines=true," >> $i
		    echo "}" >> $i
		    echo "\lstnewenvironment{listing}[1][]" >> $i
		    echo "{\lstset{#1}\pagebreak[0]}{\pagebreak[0]}" >> $i
		    echo "" >> $i
		    echo "" >> $i
		    echo "\begin{document}" >> $i
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
    
		
