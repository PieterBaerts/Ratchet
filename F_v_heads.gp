#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_v_heads.pdf"

load "Data/my.pal"

set xlabel "F_{l} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (mm/s)"

set key top left Left

set xzeroaxis
set yzeroaxis

set multiplot

plot [-50:50] \
      "Data/F_q_zoom_1head.dat" u (-$1):2:3 w yerrorbars ls 8 lw 1.25 dashtype 1 title "1 head" \
    , "Data/F_q_zoom_4heads.dat" u (-$1):2:3 w yerrorbars ls 3 lw 1.25 dashtype 2 title "4 heads" \
    , "Data/F_q_zoom_16heads.dat" u (-$1):2:3 w yerrorbars ls 6 lw 1.25 dashtype 4 title "16 heads" \
    , x/0.66 lc rgb "black" lw 1.25 dashtype 8 title "F_{load} / {/Symbol g}_M"
    

set size 0.45, 0.45

set tmargin at screen 0.30
set bmargin at screen 0.52
set lmargin at screen 0.62
set rmargin at screen 0.9

unset key 
unset xlabel
unset ylabel

set xtics 0.05
set ytics 0.025

plot [-0.05:0.05][-0.025:0.025] \
      "Data/F_q_zoom_1head.dat" u (-$1):2:3 w errorlines ls 8 lw 1.25 dashtype 1 title "1 head" \
    , "Data/F_q_zoom_4heads.dat" u (-$1):2:3 w errorlines ls 3 lw 1.25 dashtype 2 title "4 heads" \
    , "Data/F_q_zoom_16heads.dat" u (-$1):2:3 w errorlines ls 6 lw 1.25 dashtype 4 title "16 heads"

unset multiplot
