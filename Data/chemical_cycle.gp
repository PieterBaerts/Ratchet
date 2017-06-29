#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "chemical_cycle.pdf"

load "Data/my.pal"

set xzeroaxis
set yzeroaxis

set key top left Left

set ylabel "{/Symbol h}"
set xlabel "F_{load} (pN)"

plot [:][-0.1:0.5] \
      "Data/F_q_k=1.dat" u (-$1):(($4+$5)/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 1 lw 1.25 dashtype 1 title "k_{d}/k_a = 0.25" \
    , "Data/F_q_k=2.dat" u (-$1):(($4+$5)/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 3 lw 1.25 dashtype 2 title "k_{d}/k_a = 0.5" \
    , "Data/F_q_k=4.dat" u (-$1):(($4+$5)/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 6 lw 1.25 dashtype 4 title "k_{d}/k_a = 1" \
    , "Data/F_q_k=8.dat" u (-$1):(($4+$5)/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 8 lw 1.25 dashtype 5 title "k_{d}/k_a = 2" \
    , "Data/F_q_k=16.dat" u (-$1):(($4+$5)/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 10 lw 1.25 dashtype 6 title "k_{d}/k_a = 4" \
    , "Data/F_q_k=32.dat" u (-$1):(($4+$5)/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 11 lw 1.25 dashtype 7 title "k_{d}/k_a = 8"


