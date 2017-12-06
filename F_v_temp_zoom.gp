#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_v_temp_zoom.pdf"

load "Data/my.pal"

unset tmargin
unset bmargin
unset lmargin
unset rmargin

set key top right Right width -2

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (µm/s)"

set xzeroaxis
set yzeroaxis

plot [0:0.1][0:0.5] \
      "Data/short_F_v_kBT=0.dat" u 1:($2*1e3):($3*1e3) w errorlines ls 1 lw 1.25 dashtype 1 title "T = 0 K" \
    , "Data/short_F_v_kBT=1.dat" u 1:($2*1e3):($3*1e3) w errorlines ls 3 lw 1.25 dashtype 2 title "T = -200 {/Symbol \260}C" \
    , "Data/short_F_v_kBT=2.39.dat" u 1:($2*1e3):($3*1e3) w errorlines ls 6 lw 1.25 dashtype 4 title "T = -100 {/Symbol \260}C" \
    , "Data/short_F_v_kBT=3.77.dat" u 1:($2*1e3):($3*1e3) w errorlines ls 8 lw 1.25 dashtype 5 title "T = 0 {/Symbol \260}C" \
    , "Data/F_stall_k=2.dat" u 1:($2*1e3):($3*1e3) w errorlines ls 10 lw 1.25 dashtype 6 title "T = 37 {/Symbol \260}C" \
    , "Data/short_F_v_kBT=5.1.dat" u 1:($2*1e3):($3*1e3) w errorlines ls 11 lw 1.25 dashtype 7 title "T = 100 {/Symbol \260}C" \

