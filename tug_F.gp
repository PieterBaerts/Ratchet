#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_F.pdf"

load "Data/my.pal"

set key right Left width -2 

set xlabel "F_{load} (pN)"
set ylabel "Tension (pN)"

set xzeroaxis
set yzeroaxis

plot [-150:150][-75:75] \
      "Data/tug_F.dat" u ($1):(-($2-$4)*0.97-2*$1):($3*0.97) w errorlines ls 8 lw 1.25 dashtype 1 title"Load on filaments"  \
    , "Data/tug_F_compare.dat" u (-$1):(0.66*0.97/(0.66+0.97)*$2+$1*(0.97/(0.66+0.97)+1)):($3) w errorlines ls 3 lw 1.25 dashtype 1 title "Load on motor" \
    , -2*x w lines lc rgb "black" lw 1.25 dashtype 1 title "Initial tension" \
    , -x w lines ls 4 lw 1.25 dashtype 1 title "Asymptotic tension for load on motor" \
    , 0 w lines ls 7 lw 1.25 dashtype 1 title "Asymptotic tension for load on filaments" 
