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

plot [-100:100][-150:150] \
       "Data/kBT=0.dat" u 1:2:3 w errorlines ls 2 lc rgb "black" lw 1.25 dashtype 3 title "kBT 0" \
    , "Data/kBT=1.dat" u 1:2:3 w errorlines ls 1 lw 1.25 dashtype 1 title "kBT = 1.00" \
    , "Data/kBT=2.39.dat" u 1:2:3 w errorlines ls 3 lw 1.25 dashtype 2 title "kBT = 2.39" \
    , "Data/kBT=3.77.dat" u 1:2:3 w errorlines ls 6 lw 1.25 dashtype 4 title "kBT = 3.77" \
    , "Data/kBT=4.28.dat" u 1:2:3 w errorlines ls 8 lw 1.25 dashtype 5 title "kBT = 4.28" \
    , "Data/kBT=5.1.dat" u 1:2:3 w errorlines ls 10 lw 1.25 dashtype 6 title "kBT = 5.10" \
