#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "eff_frict_decay.pdf"

load "Data/my.pal"

f(x) = a/x**b
a=100
b=1

fit [50:] f(x) "Data/F_v.dat" u ($1):(0.66*$2+$1):($3*0.66) yerrors via a,b

set logscale x
set logscale y

set xlabel "F_{load}"
set ylabel "F_{eff}"

plot [10.:500][1.:20.] \
      "Data/F_v.dat" u ($1):(0.66*$2+$1):($3*0.66) w yerrorbars ls 8 title "Simulation" \
    , f(x) ls 6 title "Fit"


