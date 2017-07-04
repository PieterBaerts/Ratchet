#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_v_zoom.pdf"

load "Data/my.pal"

unset tmargin
unset bmargin
unset lmargin
unset rmargin

set key top left Left width -2

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (µm/s)"

set xzeroaxis
set yzeroaxis

plot [-0.1:0][0:1.1] \
      "Data/F_stall_k=1.dat" u (-$1):($2*1e3):($3*1e3) w errorlines ls 1 lw 1.25 dashtype 1 title "k_{bind}/k_{unbind} = 0.25" \
    , "Data/F_stall_k=2.dat" u (-$1):($2*1e3):($3*1e3) w errorlines ls 3 lw 1.25 dashtype 2 title "k_{bind}/k_{unbind} = 0.5" \
    , "Data/F_stall_k=4.dat" u (-$1):($2*1e3):($3*1e3) w errorlines ls 6 lw 1.25 dashtype 4 title "k_{bind}/k_{unbind} = 1" \
    , "Data/F_stall_k=8.dat" u (-$1):($2*1e3):($3*1e3) w errorlines ls 8 lw 1.25 dashtype 5 title "k_{bind}/k_{unbind} = 2" \
    , "Data/F_stall_k=16.dat" u (-$1):($2*1e3):($3*1e3) w errorlines ls 10 lw 1.25 dashtype 6 title "k_{bind}/k_{unbind} = 4" \
    , "Data/F_stall_k=32.dat" u (-$1):($2*1e3):($3*1e3) w errorlines ls 11 lw 1.25 dashtype 7 title "k_{bind}/k_{unbind} = 8" \

