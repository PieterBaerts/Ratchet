#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_v_heads.pdf"

load "Data/my.pal"

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (mm/s)"

set key top right Right

set xzeroaxis
set yzeroaxis


plot [-50:50] \
      "Data/F_q_zoom_1head.dat" u 1:2:3 w yerrorbars ls 8 lw 1.25 dashtype 1 title "1 head" \
    , "Data/F_q_zoom_4heads.dat" u 1:2:3 w yerrorbars ls 6 lw 1.25 dashtype 2 title "4 heads" \
    , "Data/F_q_zoom_16heads.dat" u 1:2:3 w yerrorbars ls 3 lw 1.25 dashtype 3 title "16 heads" \
    , -x/0.66 lc rgb "black" lw 1.25 dashtype 8 title "-F_{load} / {/Symbol g}_M"
    
#    , "Data/F_q_2heads.dat" u (-$1):2:3 w yerrorbars ls 3 lw 1.25 dashtype 2 title "2 heads" \
#    , "Data/F_q_8heads.dat" u (-$1):2:3 w yerrorbars ls 8 lw 1.25 dashtype 5 title "8 heads" \
