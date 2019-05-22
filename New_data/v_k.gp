#!/usr/bin/gnuplot

set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "v_k.pdf"

load "../Data/my.pal"

unset tmargin
unset bmargin
unset lmargin
unset rmargin
set key off

set xlabel "{/Symbol l}_{b} ({/Symbol l}_{u})"
set ylabel "{/Symbol \341}v{/Symbol \361} (µm/s)"

set xzeroaxis
set logscale x

set xtics ("2^{-4}" 0.0625, "2^{-3}" 0.125, "2^{-2}" 0.25, "2^{-1}" 0.5, "2^0" 1, "2^1" 2, "2^2" 4, "2^3" 8, "2^4" 16, "2^5" 32 )
set format y "%g"

#plot [10.:1000.][-0.001:0.002] "v_k.dat" u (1e6*$1):2:3 w yerror
plot [:] "./v_k_4head_alt_par.dat" u 1:(1e3*$2):(1e3*$3) w yerrorbars ls 8 

