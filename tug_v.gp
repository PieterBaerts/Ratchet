#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_v.pdf"

load "Data/my.pal"

set key off

set xlabel "t (s)"
set ylabel "F_{fil} (pN)"

plot \
      "Data/tug_v_plot.dat" u ($1*1e-6):($3*0.1) w lines ls 8 lw 1.25 notitle \
    , "Data/tug_v_plot.dat" u ($1*1e-6):(($3+$4)*0.1) w lines ls 7 dashtype 3 lw 1.25 notitle \
    , "Data/tug_v_plot.dat" u ($1*1e-6):(($3-$4)*0.1) w lines ls 7 dashtype 3 lw 1.25 notitle 

