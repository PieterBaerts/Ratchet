#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14" size 10in,4.5in
set output "pos_multiplot.pdf" 

set style line 1 lt 1 pt 1 lc rgb "#081d58"
set style line 2 lt 1 pt 2 lc rgb "#253494"
set style line 3 lt 1 pt 3 lc rgb "#225ea8"
set style line 4 lt 1 pt 4 lc rgb "#1d91c0"
set style line 5 lt 1 pt 5 lc rgb "#41b6c4"
set style line 6 lt 1 pt 6 lc rgb "#7fcdbb"
set style line 7 lt 1 pt 7 lc rgb "#c7e9b4"
set style line 8 lt 1 pt 8 lc rgb "#edf8b1"
set style line 9 lt 1 pt 9 lc rgb "#ffffd9"
set style line 10 lt 1 pt 1 lc rgb "#662506"
set style line 11 lt 1 pt 2 lc rgb "#993404"
set style line 12 lt 1 pt 3 lc rgb "#cc4c02"
set style line 13 lt 1 pt 4 lc rgb "#ec7014"
set style line 14 lt 1 pt 5 lc rgb "#fe9929"
set style line 15 lt 1 pt 6 lc rgb "#fec44f"
set style line 16 lt 1 pt 7 lc rgb "#fee391"
set style line 17 lt 1 pt 8 lc rgb "#fff7bc"
set style line 18 lt 1 pt 9 lc rgb "#ffffe5"

set xlabel "x (nm)"
set ylabel "{/Symbol r}"

set key outside Left

unset x2tics 
unset y2tics

#set arrow 1 from 6.,graph(0,0) to 6.,graph(1,1) lt 0 lw 1.25 lc rgb "black" nohead 

sign(x) = x==0 ? 0 : x/abs(x)

V(x) = x<2. ? 40.*x/2. : 40.*(8.-x)/6.
shift(x) = x<0 ? shift(x+8) : (x>8 ? shift(x-8) : x)

f = "0_attached 0_detached -25_attached -25_detached 25_attached 25_detached -100_attached -100_detached 100_attached 100_detached -250_attached -250_detached 250_attached 250_detached"
val = "0 0 -25 -25 25 25 -100 -100 100 100 -250 -250 250 250"
state = "a d a d a d a d a d a d a d"
color = "1 10 2 11 3 12 4 13 5 14 6 15 7 16"

plot [0:8][0:0.4] \
      for [i=1:14] sprintf("Data/pos_distr_F=%s.dat", word(f,i)) u (shift($1+6)):($2*10) title sprintf("F_{load}(%s) = %s pN", word(state,i), word(val,i)) w points ls word(color,i) \
    , V(shift(x-6)) axis x1y2 lt rgb "#666666" dashtype "-" notitle



