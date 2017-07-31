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
      "Data/tug_F.dat" u ($1):(-($2-$4)*0.97-2*$1):($3*0.97) w errorlines ls 8 lw 1.25 dashtype 1 title "Tug of war"  \
    , -2*x w lines ls 7 lw 1.25 dashtype 1 title "- Small load" \
    , "Data/tug_F_compare.dat" u (-$1):(0.66*0.97/(0.66+0.97)*$2+$1*(0.97/(0.66+0.97)+1)):(0.66*0.97/(0.66+0.97)*$3) w errorlines ls 3 lw 1.25 dashtype 1 title "Load on the motor" \
    , -(1.+0.66/(0.97+0.66))*x w lines ls 4 lw 1.25 dashtype 1 title "- Small load" \
    , -x w lines ls 4 lw 1.25 dashtype 2 title "- Large load" \
    , "Data/F_q_fil.dat" u ($1):(0.66*0.97/(0.66+0.97)*(-$2-$1/0.97)):(0.66*0.97/(0.66+0.97)*$3) w errorlines ls 1 lw 1.25 dashtype 1 title "Load on the polymer" \
    , -0.66/(0.97+0.66)*x w lines ls 1 lw 1.25 dashtype 2 title "- Small load" \
