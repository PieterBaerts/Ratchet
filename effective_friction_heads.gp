#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "effective_friction_heads.pdf"

load "Data/my.pal"

set xlabel "F_{l} (pN)"
set ylabel "F_{eff} (pN)"

set key bottom left Left

set xzeroaxis
set yzeroaxis

set multiplot

plot [-50:50] \
      "Data/F_q_zoom_1head.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w yerrorbars ls 8 lw 1.25 dashtype 1 title "1 head" \
    , "Data/F_q_zoom_4heads.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w yerrorbars ls 3 lw 1.25 dashtype 2 title "4 heads" \
    , "Data/F_q_zoom_16heads.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w yerrorbars ls 6 lw 1.25 dashtype 4 title "16 heads"

set size 0.45, 0.45

set tmargin at screen 0.65
set bmargin at screen 0.9
set lmargin at screen 0.62
set rmargin at screen 0.9

unset key 
unset xlabel
unset ylabel

set xtics 0.02
set ytics 0.02

plot [-0.02:0.02][-0.02:0.02] \
      "Data/F_q_zoom_1head.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w errorlines ls 8 lw 1.25 dashtype 1 title "1 head" \
    , "Data/F_q_zoom_4heads.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w errorlines ls 3 lw 1.25 dashtype 2 title "4 heads" \
    , "Data/F_q_zoom_16heads.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w errorlines ls 6 lw 1.25 dashtype 4 title "16 heads"

unset multiplot
