#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_v.pdf"

load "Data/my.pal"

unset tmargin
unset bmargin
unset lmargin
unset rmargin

set key top left Left width -2 font ",13" 

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (mm/s)"

set xzeroaxis
set yzeroaxis

plot [-50:50][-80:80] \
       "Data/F_v_attached.dat" u (-$1):2:3 w errorlines ls 2 lc rgb "black" lw 1.25 dashtype 3 title "k_{bind}/k_{unbind} = 0" \
    , "Data/F_q_k=1.dat" u (-$1):2:3 w errorlines ls 1 lw 1.25 dashtype 1 title "k_{bind}/k_{unbind} = 0.25" \
    , "Data/F_q_k=2.dat" u (-$1):2:3 w errorlines ls 3 lw 1.25 dashtype 2 title "k_{bind}/k_{unbind} = 0.5" \
    , "Data/F_v_k=4.dat" u (-$1):2:3 w errorlines ls 6 lw 1.25 dashtype 4 title "k_{bind}/k_{unbind} = 1" \
    , "Data/F_v_k=8.dat" u (-$1):2:3 w errorlines ls 8 lw 1.25 dashtype 5 title "k_{bind}/k_{unbind} = 2" \
    , "Data/F_v_k=16.dat" u (-$1):2:3 w errorlines ls 10 lw 1.25 dashtype 6 title "k_{bind}/k_{unbind} = 4" \
    , "Data/F_v_detached.dat" u (-$1):2:3 w errorlines ls 12 lc rgb "black" lw 1.25 dashtype 8 title "k_{bind}/k_{unbind} = {/Symbol \245}" \
    , x/0.66 lc rgb "black" lw 1.25 dashtype 8 title "F_{load} / {/Symbol g}_M"
#    , "Data/F_v_k=32.dat" u (-$1):2:3 w errorlines ls 11 lw 1.25 dashtype 7 title "k_{bind}/k_{unbind} = 8" \
