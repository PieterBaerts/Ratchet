#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_F.pdf"

load "Data/my.pal"

set key right Left width -2 

set xlabel "F_{fil} (pN)"
set ylabel "F_{eff} (pN)"

set xzeroaxis
set yzeroaxis

plot [-100:100] \
      "Data/tug_F.dat" u ($1):(-($2-$4)-2*$1/0.97):($3) w errorlines ls 8 lw 1.25 dashtype 1 title"Load on filaments"  \
    , "Data/tug_F_compare.dat" u (-$1):(($2+$1/0.66)):($3) w errorlines ls 3 lw 1.25 dashtype 1 title "Load on motor" \
