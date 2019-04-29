#!/usr/bin/gnuplot

set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "c_v_4heads.pdf"

load "../Data/my.pal"

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

#fit [0.2:] A*exp(-c/(1-x)) "./v_c_4head_alt_par.dat" u 1:(1e3*abs($2)):(1e3*$3) yerrors via A,c

j(c) = 1./((-1. + c)*(-1. + exp(9.34579*c))**2)*(-0.500452 + 0.500904*exp(9.34579*c) + 4.6729*c**2 *exp(9.34579*c) - 0.000451834*exp(18.6916*c) + c*(-0.499636 - 4.17363*exp(9.34579*c) + 0.000364495*exp(18.6916*c)))

v0 = 8e-3 * 400.* 800. / ( 400. + 800. ) 

plot [0:1][1e-4:8] \
      v0 * j(x) w lines ls 6 \
    , "./v_c_4head_alt_par.dat" u 1:(1e3*abs($2)):(1e3*$3) w yerrorbars ls 8 \
#     A*exp(-c/(1-x)) w lines ls 6 \
#   , "Data/v_c_extra.dat" u 1:(1e3*abs($2)):(1e3*$3) w yerrorbars ls 8 \

