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

#fit [0.2:] A*exp(-c/(1-x)) "Data/v_c.dat" u 1:(1e3*abs($2)):(1e3*$3) yerrors via A,c
#coth(x) = cosh(x) / sinh(x) 
#f(x) = 0.001 * ( ( 640. * (-0.0535 - 0.143452 * x - 0.0530918 * x**2 + 0.25 * x * coth(4.6729 * x)))/((-1. + x) * x) - (8.56 * (9.34743 * x**2 * (-1. + exp(9.34579 * x)) + (1. + coth(4.6729 * x)) * (2. - 4. * x + 89.3439 * x**2 - 87.3439 * x**3 - 2. * (-1. + x)**2 * cosh(9.34579  * x) - 9.34579 * x**2 * sinh(9.34579 *x))))/((-1. + x) * x* (-1. + exp( 9.34579 * x))))

f(x)=8e-3*40.*80./120.*1./((-1. + x)*(-1. + exp(9.34579*x))**2)*(-0.500452 + 0.500904 * exp(9.34579*x) + 4.6729*x**2*exp(9.34579*x) - 0.000451834*exp(18.6916*x) + x*(-0.499636 - 4.17363*exp(9.34579*x) + 0.000364495*exp(18.6916*x)))

plot [0:1][1e-4:8] \
    f(x) w lines ls 6 \
    , "Data/v_c.dat" u 1:(1e3*abs($2)):(1e3*$3) w yerrorbars ls 8 \
#     A*exp(-c/(1-x)) w lines ls 6 \
#   , "Data/v_c_extra.dat" u 1:(1e3*abs($2)):(1e3*$3) w yerrorbars ls 8 \

