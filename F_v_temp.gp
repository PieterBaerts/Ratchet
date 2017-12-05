#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_v_temp.pdf"

load "Data/my.pal"

unset tmargin
unset bmargin
unset lmargin
unset rmargin

set key top right Right width -2 font ",13" 

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (mm/s)"

set xzeroaxis
set yzeroaxis

plot [-50:50][-60:60] \
      "Data/F_v_kBT=0.dat" u 1:2:3 w errorlines ls 2 lc rgb "black" lw 1.25 dashtype 2 title "T = 0 K" \
    , "Data/F_v_kBT=1.dat" u 1:2:3 w errorlines ls 1 lw 1.25 dashtype 1 title "T = -200 {/Symbol \260}C" \
    , "Data/F_v_kBT=2.39.dat" u 1:2:3 w errorlines ls 3 lw 1.25 dashtype 2 title "T = -100 {/Symbol \260}C" \
    , "Data/F_v_kBT=3.77.dat" u 1:2:3 w errorlines ls 6 lw 1.25 dashtype 4 title "T = 0 {/Symbol \260}C" \
    , "Data/F_v_kBT=4.28.dat" u 1:2:3 w errorlines ls 8 lw 1.25 dashtype 5 title "T = 37 {/Symbol \260}C" \
    , "Data/F_v_kBT=5.1.dat" u 1:2:3 w errorlines ls 10 lw 1.25 dashtype 6 title "T = 100 {/Symbol \260}C" \
