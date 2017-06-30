#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "effective_friction.pdf"

load "Data/my.pal"

set key top right Left

set xzeroaxis
set yzeroaxis

set xlabel "F_{load} (pN)"
set ylabel "F_{eff} (pN)"

plot [-50:50] \
      "Data/F_q_k=1.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w errorlines ls 1 lw 1.25 dashtype 1 title "k_{d}/k_a = 0.25" \
    , "Data/F_q_k=2.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w errorlines ls 3 lw 1.25 dashtype 2 title "k_{d}/k_a = 0.5" \
    , "Data/F_v_k=4.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w errorlines ls 6 lw 1.25 dashtype 4 title "k_{d}/k_a = 1" \
    , "Data/F_v_k=8.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w errorlines ls 8 lw 1.25 dashtype 5 title "k_{d}/k_a = 2" \
    , "Data/F_v_k=16.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w errorlines ls 10 lw 1.25 dashtype 6 title "k_{d}/k_a = 4" \
    , "Data/F_v_k=32.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w errorlines ls 11 lw 1.25 dashtype 7 title "k_{d}/k_a = 8"



