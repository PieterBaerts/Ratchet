#!/usr/bin/gnuplot

set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "v_c_1head_analytic.pdf"

load "Data/my.pal"

unset tmargin
unset bmargin
unset lmargin
unset rmargin
set key off

set xlabel "c" 
set ylabel "{/Symbol \341}v{/Symbol \361} ({/Symbol m}m/s)"

set logscale y 

j(c) = 1./((-1. + c)*(-1. + exp(9.34579*c))**2)*(-0.500452 + 0.500904*exp(9.34579*c) + 4.6729*c**2 *exp(9.34579*c) - 0.000451834*exp(18.6916*c) + c*(-0.499636 - 4.17363*exp(9.34579*c) + 0.000364495*exp(18.6916*c)))

v0 = 8e-3 * 40.* 80. / ( 40. + 80. ) 

plot [0:1] v0 * j(x) w lines lc 7, "Data/c_v_1head.dat" u 1:($2*1e3):($3*1e3) w errorlines lc 1

