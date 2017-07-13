#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_F.pdf"

load "Data/my.pal"

set key right Left width -2 

set xlabel "F_{load} (pN)"
set ylabel "F_{eff} (pN)"

set xzeroaxis
set yzeroaxis

plot [-150:150] \
      "Data/tug_F.dat" u ($1):(-($2-$4)*0.97-2*$1):($3*0.97) w errorlines ls 8 lw 1.25 dashtype 1 title"Load on filaments"  \
    , "Data/tug_F_compare.dat" u (-$1):(0.66*0.97/(0.66+0.97)*$2+$1*(0.97/(0.66+0.97)+1)):($3) w errorlines ls 3 lw 1.25 dashtype 1 title "Load on motor" \
    , -2x lt 2 lc rgb "black" lw 1.25 title "-2F_{load}" \
    , -x lt 4 lc rgb "black" lw 1.25 title "-F_{load}"
