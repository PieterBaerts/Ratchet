#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "chem_efficiency_distr_all_F.pdf" 

load "Data/my.pal"

set xlabel "x (nm)"
set ylabel "V(x) [ ~{/Symbol r}\342\200\276 (x|{/Symbol z}=c) - ~{/Symbol r}\342\200\276 (x|{/Symbol z}=1) ]"

set key top center Left width -4    

unset x2tics 
unset y2tics

#set arrow 1 from 6.,graph(0,0) to 6.,graph(1,1) lt 0 lw 1.25 lc rgb "black" nohead 

sign(x) = x==0 ? 0 : x/abs(x)

V(x) = x<2. ? 40.*x/2. : 40.*(8.-x)/6.
shift(x) = x<0 ? shift(x+8) : (x>8 ? shift(x-8) : x)

f = "-100 -25 0 25 100"
color = "1 3 6 10 8"

c = 0.3
dE = 30.4
kbind = 40.
kunbind = 80.

s = 0.
cum(x) = ( s=s+x )

plot [0:8][:] \
     for [i=1:5] sprintf("< paste Data/pos_distr_F=%s_attached.dat Data/pos_distr_F=%s_detached.dat", word(f,i), word(f,i)) u (shift($1+6)):(V($1)*(($5/kbind-$2/kunbind)*(kbind+kunbind))) title sprintf("F_{load} = %s pN", word(f,i)) w points ls word(color,i) \
    , V(shift(x-6)) axis x1y2 lt rgb "#666666" dashtype "-" notitle \
    , 0 lt rgb "black" lw 1.25 notitle 

