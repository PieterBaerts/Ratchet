#!/usr/bin/gnuplot

set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "v_k.pdf"

unset tmargin
unset bmargin
unset lmargin
unset rmargin
set key off

set xlabel "k_a/k_d"
set ylabel "{/Symbol \341}v{/Symbol \361} (µm/s)"

set xzeroaxis
set logscale x

set xtic 2
set format y "%g"

#plot [10.:1000.][-0.001:0.002] "v_k.dat" u (1e6*$1):2:3 w yerror
plot [2**-4:2**4] "Data/v_k.dat" u (1e6*$1/80.):(1e3*$2):(1e3*$3) w yerrorbars

