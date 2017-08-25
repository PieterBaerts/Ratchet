#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_k_c.pdf"

load "Data/my.pal"

set multiplot

set key off

set ylabel "{/Symbol \341}{/Symbol t}_M{/Symbol \361} (pN)"
set xlabel "k_{sp} (pN/nm)"

set logscale y 
set logscale x 

set format x "10^{%L}"
set format y "10^{%L}"

plot [:][0.025:10] \
    "Data/tug_k.dat" u 1:($1*(-$2+$4)):($1*sqrt($3**2+$5**2)) w errorlines ls 8 lw 1.25 title "c=0.3" \
  , "Data/tug_k_c=0.dat" u 1:($1*(-$2+$4)):($1*sqrt($3**2+$5**2)) w errorlines ls 6 lw 1.25 title "c=0"

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
set format y "%g"

plot [:][0:] \
    "Data/tug_k.dat" u 1:($1*(-$2+$4)):($1*sqrt($3**2+$5**2)) w lines ls 8 lw 1.25 title "c=0.3" \
  , "Data/tug_k_c=0.dat" u 1:($1*(-$2+$4)):($1*sqrt($3**2+$5**2)) w lines ls 6 lw 1.25 title "c=0" 

unset multiplot
