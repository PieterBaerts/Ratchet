#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "k_Fstall.pdf"

load "Data/my.pal"

set key off

set xlabel "k_{d}/k_a"
set ylabel "F_{stall} (pN)"

set logscale x
set logscale y

set xtics 2 

fit B*x**(-a)  "Data/k_F.dat" u ($1/4.):(-$2) via a,B

plot [:32] "Data/k_F.dat" u ($1/4.):(-$2) w linespoints ls 8 \
    , B/x**a ls 6 notitle 
