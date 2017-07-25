#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "energy_1head.pdf"

load "Data/my.pal"

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
set style arrow 1 head filled size screen 0.025,30,45 ls 2 lw 1.25 lc "black"

set xtic 0.1
set ytics nomirror 
set border 7

set arrow from 1.95,36.75 to 1.95,21 arrowstyle 1

plot [1.8:2.3][12.5:40] \
 "Data/Energy_1head_F=0_part2.dat" u 1:( c($3)*V($2)+s($3)*E ) w filledcurve x1=2 ls 3 \
, "Data/Energy_1head_F=0.dat" u 1:( c($3)*V($2)+s($3)*E ) w lines ls 8 lw 1.25 title "E(t)"\
, 36.75 ls 1 lw 1.25 lc "black" dashtype 2 \
, 21. ls 1 lw 1.25 lc "black" dashtype 2 \

unset ylabel
unset ytics
unset arrow

set y2tics nomirror
set format y2 ""
set border 13

set arrow from 4.05,16.05 to 4.05,35.3 arrowstyle 1

plot [3.8:4.3][12.5:40] \
 "Data/Energy_1head_F=0_part3.dat" u 1:( c($3)*V($2)+s($3)*E ) w filledcurve x1=4 ls 3 \
, "Data/Energy_1head_F=0.dat" u 1:( c($3)*V($2)+s($3)*E ) w lines ls 8 lw 1.25 title "E(t)"\
, 35.3 ls 1 lw 1.25 lc "black" dashtype 2 \
, 16.05 ls 1 lw 1.25 lc "black" dashtype 2 \

