#!/usr/bin/gnuplot

set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_v_zoom.pdf"

unset tmargin
unset bmargin
unset lmargin
unset rmargin

set key top left

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (µm/s)"

plot [-0.1:0][0:1.2] "Data/F_v_k=4.dat" u (-$1):($2*1e3):($3*1e3) w errorlines dashtype 1 title "k_{d}/k_a = 1" \
    , "Data/F_v_k=8.dat" u (-$1):($2*1e3):($3*1e3) w errorlines dashtype 2 title "k_{d}/k_a = 2" \
    , "Data/F_v_k=16.dat" u (-$1):($2*1e3):($3*1e3) w errorlines dashtype 3 title "k_{d}/k_a = 4" \
    , "Data/F_v_k=32.dat" u (-$1):($2*1e3):($3*1e3) w errorlines dashtype 4 title "k_{d}/k_a = 8" \
    , "Data/F_v_k=64.dat" u (-$1):($2*1e3):($3*1e3) w errorlines dashtype 5 title "k_{d}/k_a = 16"

