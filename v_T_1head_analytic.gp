#!/usr/bin/gnuplot

set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "v_T_1head_analytic.pdf"

load "Data/my.pal"

unset tmargin
unset bmargin
unset lmargin
unset rmargin
set key off

set xlabel "T ({/Symbol \260}C)" 
set ylabel "{/Symbol \341}v{/Symbol \361} (nm/s)"

set xtics ("0 K" 0, "-200" 73.15, "-100" 173.15, "0" 273.15, "37" 310.15, "100" 373.15, "200" 473.15, "300" 573.15 ) 

j(B) = (exp(12.*B)*(13. - 13. * exp(12.*B) + 13.*exp(68.*B) + 84.*B - 728.*exp(40.*B)*B + exp(80.*B)*(-13. + 84.*B) + exp(28*B)*(-13. + 280.*B) + exp(52.*B)*(13. + 280.*B)))/(14.*(-1. + exp(12.*B))**2 *(-1. + exp(40.*B))**2)

v0 = 8. * 40.* 80. / ( 40. + 80. ) 
k = 0.013806488

plot [0:600] v0 * j(1./(k*x)) w lines lc 7
  
