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

set format y "10^{%L}"

set xzeroaxis
set logscale y

fit [0.2:] A*exp(-c/(1-x)) "Data/v_c.dat" u 1:(1e3*abs($2)):(1e3*$3) yerrors via A,c

plot [0:1][1e-4:8] \
      A*exp(-c/(1-x)) w lines ls 6 \
    , "Data/v_c.dat" u 1:(1e3*abs($2)):(1e3*$3) w yerrorbars ls 8 \
#   , "Data/v_c_extra.dat" u 1:(1e3*abs($2)):(1e3*$3) w yerrorbars ls 8 \

