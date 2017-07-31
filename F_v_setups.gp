#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_v_setups.pdf"

load "Data/my.pal"

unset tmargin
unset bmargin
unset lmargin
unset rmargin

set multiplot

set key top left Left width -2 font ",13" 

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (mm/s)"

set xzeroaxis
set yzeroaxis

plot [-150:150][] \
    "Data/F_q_k=8.dat" u (-$1):2:3 w errorlines ls 1 lw 1.25 dashtype 1 title "Load on motor" \
    , x/0.66 ls 1 lw 1.25 dashtype 1 title "F_{load} / {/Symbol g}_M"
    , "Data/F_q_fil.dat" u 1:(-$2):3 w errorlines ls 3 lw 1.25 dashtype 2 title "Load on polymer" \
    , "Data/tug_F.dat" u (-$1):2:3 w errorlines ls 6 lw 1.25 dashtype 4 title "Tug of war" \
    , x/0.97 ls 3 dashtype 2 title "F_{load} / {/Symbol g}_A"


set tmargin at screen 0.30
set bmargin at screen 0.52
set lmargin at screen 0.62
set rmargin at screen 0.9

set key off

set ytic 0.002
set xtic 0.002

unset xlabel
unset ylabel 

plot [-150:150][] \
    "Data/F_q_k=8.dat" u (-$1/0.66):2:3 w errorlines ls 1 lw 1.25 dashtype 1 title "Load on motor" \
    , "Data/F_q_fil.dat" u ($1/0.97):(-$2):3 w errorlines ls 3 lw 1.25 dashtype 2 title "Load on polymer" \
    , "Data/tug_F.dat" u (-$1/0.97):2:3 w errorlines ls 6 lw 1.25 dashtype 4 title "Tug of war" \


unset multiplot
