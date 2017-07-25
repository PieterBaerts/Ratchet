#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_eta_setup.pdf"

load "Data/my.pal"

set xzeroaxis
set yzeroaxis

set key top left Left width -1

set ylabel "{/Symbol h}"
set xlabel "F_{load} (pN)"

plot [:][-0.2:0.35] \
      "Data/F_q_k=8.dat" u (-$1):(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w errorlines ls 8 lw 1.25 pt 2 dashtype 1 title "Simple setup" \
    , "Data/tug_F_E.dat" u 1:(1+$9/$8):(sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w errorlines ls 3 lw 1.25 pt 4 dashtype 1 title "Tug of war" \
