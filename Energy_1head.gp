#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
 

set key bottom left
set ylabel "Energy (pN nm)"
set xlabel "time (µs)"

V(x) = x<2. ? 40.*x/2. : 40.*(8.-x)/6.
E = 30.4
c(x) = x<0.5 ? 0.3 : 1
s(x) = x<0.5 ? 1 : 0

set output "Energie_1head_attach.pdf" 
set key top right

plot [1.95:2.15] \
  "Energie_1head.dat" u 1:( c($3)*V($2)+s($3)*E ) w linespoints title "F=0"\
, "Energie_1head_F=20.dat" u 1:( c($3)*V($2)+s($3)*E ) w linespoints title "F=20"\
, "Energie_1head_F=50.dat" u 1:( c($3)*V($2)+s($3)*E ) w linespoints title "F=50"\


set output "Energie_1head_detach.pdf" 
set key bottom right

plot [3.95:4.15] \
  "Energie_1head.dat" u 1:( c($3)*V($2)+s($3)*E ) w linespoints title "F=0"\
, "Energie_1head_F=20.dat" u 1:( c($3)*V($2)+s($3)*E ) w linespoints title "F=20"\
, "Energie_1head_F=50.dat" u 1:( c($3)*V($2)+s($3)*E ) w linespoints title "F=50"\

