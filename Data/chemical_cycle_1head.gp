#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "chemical_cycle_1head.pdf"

load "Data/my.pal"

set xlabel "F_{l} (pN)"
set ylabel "{/Symbol h}"

set key top left Left

set xzeroaxis
set yzeroaxis

plot [-50:50][-0.25:0.5] \
      "Data/F_q_zoom_1head.dat" u (-$1):(($4+$5)/$4):(sqrt($6**2/$4**4*$5**2+$7**2/$4**2)) w yerrorbars ls 8 lw 1.25 dashtype 1 title "1 head" \
    , "Data/F_q_zoom_4heads.dat" u (-$1):(($4+$5)/$4):(sqrt($6**2/$4**4*$5**2+$7**2/$4**2)) w yerrorbars ls 3 lw 1.25 dashtype 1 title "4 heads" \
    , "Data/F_q_zoom_16heads.dat" u (-$1):(($4+$5)/$4):(sqrt($6**2/$4**4*$5**2+$7**2/$4**2)) w yerrorbars ls 6 lw 1.25 dashtype 1 title "16 heads"

