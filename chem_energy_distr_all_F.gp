#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "chem_energy_distr_all_F.pdf" 

load "Data/my.pal"

set xlabel "x (nm)"
set ylabel "q_{in}(x) + q_{out}(x)"

set key top left Left width -4    

unset x2tics 
unset y2tics

#set arrow 1 from 6.,graph(0,0) to 6.,graph(1,1) lt 0 lw 1.25 lc rgb "black" nohead 

sign(x) = x==0 ? 0 : x/abs(x)

V(x) = x<2. ? 40.*x/2. : 40.*(8.-x)/6.
shift(x) = x<0 ? shift(x+8) : (x>8 ? shift(x-8) : x)

f = "-100 -25 0 25 100"
frev = "100 25 0 -25 -100"
color = "1 3 6 10 8"

c = 0.3
dE = 30.4
kbind = 40.
kunbind = 80.
N = 4.

plot [0:8][:] \
     for [i=1:5] sprintf("< paste Data/pos_distr_F=%s_attached.dat Data/pos_distr_F=%s_detached.dat", word(frev,i), word(frev,i)) u (shift($1+6)):(N*(dE - (1.-c) * V($1))*(kbind*$2-kunbind*$5)) title sprintf("F_{load} = %s pN", word(f,i)) w points ls word(color,i) \
    , V(shift(x-6)) axis x1y2 lt rgb "#666666" dashtype "-" notitle \
    , 0 lt rgb "black" lw 1.25 notitle 

