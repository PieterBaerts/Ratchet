#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "effective_friction_heads.pdf"

load "Data/my.pal"

set xlabel "F_{load} (pN)"
set ylabel "F_{r} (pN)"

set key bottom left Left

set xzeroaxis
set yzeroaxis

gamma_M = 0.66


plot [-50:50] \
      "Data/F_q_zoom_1head.dat" u (-$1):(gamma_M*$2+$1):(gamma_M*$3) w yerrorbars ls 1 lw 1.25 dashtype 1 title "1 head" \
    , "Data/F_q_2heads.dat" u (-$1):(gamma_M*$2+$1):(gamma_M*$3) w yerrorbars ls 3 lw 1.25 dashtype 2 title "2 heads" \
    , "Data/F_q_zoom_4heads.dat" u (-$1):(gamma_M*$2+$1):(gamma_M*$3) w yerrorbars ls 6 lw 1.25 dashtype 4 title "4 heads" \
    , "Data/F_q_8heads.dat" u (-$1):(gamma_M*$2+$1):(gamma_M*$3) w yerrorbars ls 8 lw 1.25 dashtype 5 title "8 heads" \
    , "Data/F_q_zoom_16heads.dat" u (-$1):(gamma_M*$2+$1):(gamma_M*$3) w yerrorbars ls 10 lw 1.25 dashtype 6 title "16 heads"


