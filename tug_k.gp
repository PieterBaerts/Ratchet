#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_k.pdf"

load "Data/my.pal"

set multiplot

set key off

set ylabel "Tension (pN)"
set xlabel "k_{sp} (pN/nm)"

set logscale y 
set logscale x 

plot [:][0.025:10] \
    "Data/tug_k.dat" u 1:($1*(-$2+$4)):($1*sqrt($3**2+$5**2)) w errorlines ls 8 lw 1.25 notitle 

set tmargin at screen 0.9
set bmargin at screen 0.66
set lmargin at screen 0.20
set rmargin at screen 0.55

set key off

unset xlabel
unset ylabel

set xtics 1e-4,100,1
set ytics 0.1

unset logscale y 

plot [:][0:] \
    "Data/tug_k.dat" u 1:($1*(-$2+$4)):($1*sqrt($3**2+$5**2)) w lines ls 8 lw 1.25 notitle 

unset multiplot
