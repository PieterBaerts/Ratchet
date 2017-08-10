#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "individual_velocities.pdf"

load "Data/my.pal"

set multiplot

set key top right width -2 

set xzeroaxis
set yzeroaxis

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (mm/s)"

plot [-50:50] \
      "Data/F_v_k=8.dat" u 1:(($2-$1/0.97)*0.97/(0.66+0.97)):($3*0.97/(0.66+0.97)) w errorlines ls 3 lw 1.25 dashtype 2 title "{/Symbol \341}v_{M}{/Symbol \361}" \
    , "Data/F_v_k=8.dat" u 1:(-($2+$1/0.66)*0.66/(0.66+0.97)):($3*0.66/(0.66+0.97)) w errorlines ls 8 lw 1.25 dashtype 4 title "{/Symbol \341}v_{A}{/Symbol \361}" \
    , -x/(0.66+0.97) title "-F_{load} / ({/Symbol g}_M + {/Symbol g}_A)" lt rgb "black"

set tmargin at screen 0.30
set bmargin at screen 0.52
set lmargin at screen 0.23
set rmargin at screen 0.49

set key off

set ytic 0.002
set xtic 0.002

unset xlabel
unset ylabel 

plot [-0.002:0.002] \
      "Data/F_v_k=8.dat" u 1:(($2-$1/0.97)*0.97/(0.66+0.97)) w lines ls 3 lw 1.25 dashtype 2 notitle \
    , "Data/F_v_k=8.dat" u 1:(-($2+$1/0.66)*0.66/(0.66+0.97)) w lines ls 8 lw 1.25 dashtype 4 notitle \
    , -x/(0.66+0.97) title "-F_{l} / ({/Symbol g}_M + {/Symbol g}_A)" lt rgb "black"

unset multiplot
