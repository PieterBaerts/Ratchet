#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_v_zoom.pdf"

load "Data/my.pal"

unset tmargin
unset bmargin
unset lmargin
unset rmargin

set key top left Left

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (µm/s)"

set xzeroaxis
set yzeroaxis

plot [-0.15:0][0:1.1] \
    "Data/F_q_k=1.dat" u (-$1):($2*1e3):($3*1e3) w lines ls 1 lw 1.25 dashtype 1 title "k_{d}/k_a = 0.25" \
    , "Data/F_q_k=2.dat" u (-$1):($2*1e3):($3*1e3) w lines ls 3 lw 1.25 dashtype 2 title "k_{d}/k_a = 0.5" \
    , "Data/F_stall_k=4.dat" u (-$1):($2*1e3):($3*1e3) w lines ls 6 lw 1.25 dashtype 4 title "k_{d}/k_a = 1" \
    , "Data/F_stall_k=8.dat" u (-$1):($2*1e3):($3*1e3) w lines ls 8 lw 1.25 dashtype 5 title "k_{d}/k_a = 2" \
    , "Data/F_stall_k=16.dat" u (-$1):($2*1e3):($3*1e3) w lines ls 10 lw 1.25 dashtype 6 title "k_{d}/k_a = 4" \
    , "Data/F_stall_k=32.dat" u (-$1):($2*1e3):($3*1e3) w lines ls 11 lw 1.25 dashtype 7 title "k_{d}/k_a = 8" \

