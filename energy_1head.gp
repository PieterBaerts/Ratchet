#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "energy_1head.pdf"
 

set key bottom left
set ylabel "Energy (pN nm)"
set xlabel "time (µs)"

V(x) = x<2. ? 40.*x/2. : 40.*(8.-x)/6.
E = 30.4
c(x) = x<0.5 ? 0.3 : 1
s(x) = x<0.5 ? 1 : 0

set key top right


set multiplot layout 1,2 

set key bottom left
set style arrow 1 heads filled size screen 0.025,30,45 lc "black"

set xtic 0.1
set ytics nomirror 
set arrow from 1.95,21 to 1.95,36.75 arrowstyle 1
set border 7
plot [1.8:2.3][12.5:40] \
 "Data/Energy_1head_F=0_part2.dat" u 1:( c($3)*V($2)+s($3)*E ) w filledcurve x1=2 lc 2 \
, "Data/Energy_1head_F=0.dat" u 1:( c($3)*V($2)+s($3)*E ) w lines ls 1 lw 1.25 title "E(t)"\
, 36.75 lc "black" \
, 21. lc "black" \

unset ylabel
unset ytics
unset arrow
set y2tics nomirror
set format y2 ""
set arrow from 4.05,16.05 to 4.05,35.3 arrowstyle 1
set border 13
plot [3.8:4.3][12.5:40] \
 "Data/Energy_1head_F=0_part3.dat" u 1:( c($3)*V($2)+s($3)*E ) w filledcurve x1=4 lc 2 \
, "Data/Energy_1head_F=0.dat" u 1:( c($3)*V($2)+s($3)*E ) w lines ls 1 lw 1.25 title "E(t)"\
, 35.3 lc "black" \
, 16.05 lc "black" \
