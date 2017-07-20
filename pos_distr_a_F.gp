#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "pos_distr_a_F.pdf" 

load "Data/my.pal"

set xlabel "x (nm)"
set ylabel "~{/Symbol r}\342\200\276 (x,{/Symbol z}=1)"

set key left Left width -4

unset x2tics 
unset y2tics

#set arrow 1 from 6.,graph(0,0) to 6.,graph(1,1) lt 0 lw 1.25 lc rgb "black" nohead 

sign(x) = x==0 ? 0 : x/abs(x)

V(x) = x<2. ? 40.*x/2. : 40.*(8.-x)/6.
shift(x) = x<0 ? shift(x+8) : (x>8 ? shift(x-8) : x)

f = "-100 -25 0 25 100"
color = "1 3 6 10 8"

plot [0:8][0:0.4] \
      for [i=1:5] sprintf("Data/pos_distr_F=%s_attached.dat", word(f,i)) u (shift($1+6)):($2*10) title sprintf("F_{load} = %s pN", word(f,i)) w points ls word(color,i) \
    , V(shift(x-6)) axis x1y2 lt rgb "#666666" dashtype "-" notitle


