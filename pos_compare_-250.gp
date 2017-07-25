#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14" #size 10in,4.5in
set output "pos_compare_-250.pdf" 

load "Data/my.pal"

set xlabel "x (nm)"
set ylabel "{/Symbol r}"

set key left Left

unset x2tics 
unset y2tics

#set arrow 1 from 6.,graph(0,0) to 6.,graph(1,1) lt 0 lw 1.25 lc rgb "black" nohead 

sign(x) = x==0 ? 0 : x/abs(x)

V(x) = x<6. ? 40.*(6.-x)/6. : 40.*(x-6.)/2.
F(x) = x<6. ? 40./6. : -40./2.
rho(x,y) = 1/8. - 1/(8.*y)*F(x) + 1/(8.*y**2)*(F(x)**2-40.**2/(2.*6.))
rho_det(x,y) = 1/8. - 0.3/(8.*y)*F(x) + 0.3**2/(8.*y**2)*(F(x)**2-40.**2/(2.*6.))  

shift(x) = x<0 ? shift(x+8) : (x>8 ? shift(x-8) : x)



plot [0:8][0.:0.2] \
      "Data/pos_distr_F=-250_attached.dat" u (shift($1+6)):($2*10) title "Empirical" w points ls 8\
      , rho(x,-250) title "Theory" ls 6

