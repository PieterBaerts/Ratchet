#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "k_Fstall.pdf"

load "Data/my.pal"

set key off

set xlabel "k_{d}/k_a"
set ylabel "F_{stall} (pN)"

set logscale x
set xtics 2 

plot [:32] "Data/k_F.dat" u ($1/4.):(-$2) w linespoints ls 8  

