#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_v.pdf"

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
       "Data/F_v_attached.dat" u 1:2:3 w errorlines ls 2 lc rgb "black" lw 1.25 dashtype 3 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 0" \
    , "Data/F_q_k=1.dat" u 1:2:3 w errorlines ls 1 lw 1.25 dashtype 1 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 0.25" \
    , "Data/F_q_k=2.dat" u 1:2:3 w errorlines ls 3 lw 1.25 dashtype 2 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 0.5" \
    , "Data/F_q_k=4.dat" u 1:2:3 w errorlines ls 6 lw 1.25 dashtype 4 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 1" \
    , "Data/F_q_k=8.dat" u 1:2:3 w errorlines ls 8 lw 1.25 dashtype 5 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 2" \
    , "Data/F_q_k=16.dat" u 1:2:3 w errorlines ls 10 lw 1.25 dashtype 6 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 4" \
    , "Data/F_v_detached.dat" u 1:2:3 w errorlines ls 12 lc rgb "black" lw 1.25 dashtype 8 title "{/Symbol l}_{b}/{/Symbol l}_{u} = {/Symbol \245}" \
    , -x/0.66 ls 1 lc rgb "black" lw 1.25 dashtype 1 notitle \

#    , "Data/F_v_k=32.dat" u 1:2:3 w errorlines ls 11 lw 1.25 dashtype 7 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 8" \
