#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_k.pdf"

load "Data/my.pal"

set key off

set ylabel "Tension (pN)"
set xlabel "k_{sp} (pN/nm)"

set logscale y 
set logscale x 

plot [:][0.05:10] \
    "Data/tug_k.dat" u 1:($1*(-$2+$4)):($1*sqrt($3**2+$5**2)) w errorlines ls 8 lw 1.25 notitle 

