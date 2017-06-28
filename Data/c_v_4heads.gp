#!/usr/bin/gnuplot

set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "c_v_4heads.pdf"

load "Data/my.pal"

unset tmargin
unset bmargin
unset lmargin
unset rmargin

set key off

set xlabel "c"
set ylabel "{/Symbol \341}v{/Symbol \361} (µm/s)"

set xzeroaxis
#set logscale y

fit [:3] A*exp(-c/(1-x)) "Data/v_c_extra.dat" u 1:(1e3*abs($2)):(1e3*$3) yerrors via A,c

#plot [0:1][1e-4:] "Data/v_c_extra.dat" u 1:(1e3*abs($2)):(1e3*$3) w yerrorbars, 
plot [0:1] "Data/v_c_extra.dat" u 1:(1e3*abs($2)):(1e3*$3) w yerrorbars lc "#e31a1c", \
    A*exp(-c/(1-x)) w lines ls 6

