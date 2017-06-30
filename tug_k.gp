#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_k.pdf"

load "Data/my.pal"

set key off

set ylabel "F_{fil} (pN)"
set xlabel "k_{sp} (pN/nm)"
plot "Data/tug_k.dat" u 1:($1*$3) w errorlines ls 8 lw 1.25 notitle 

