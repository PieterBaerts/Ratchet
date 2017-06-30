#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_F.pdf"

load "Data/my.pal"

set key left Left

set xlabel "F_{fil} (pN)"
set ylabel "F_{eff} (pN)"

plot \
      "Data/tug_F.dat" u (-$1):(($2)*1e-6+$1/0.97) w errorlines ls 8 lw 1.25 dashtype 1 title"Load on filaments"  \
    , "Data/F_v_k=8.dat" u (-$1):(0.66*$2+$1):(0.66*$3) w errorlines ls 3 lw 1.25 dashtype 1 title "Load on motor" \
