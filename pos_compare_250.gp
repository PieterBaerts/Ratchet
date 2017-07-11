#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14" #size 10in,4.5in
set output "pos_compare_250.pdf" 

set style line 1 lt 1 pt 1 lc rgb "#081d58"
set style line 2 lt 1 pt 1 lc rgb "#253494"
set style line 3 lt 1 pt 4 lc rgb "#225ea8"
set style line 4 lt 1 pt 4 lc rgb "#1d91c0"
set style line 5 lt 1 pt 6 lc rgb "#41b6c4"
set style line 6 lt 1 pt 6 lc rgb "#7fcdbb"
set style line 7 lt 1 pt 8 lc rgb "#c7e9b4"
set style line 8 lt 1 pt 8 lc rgb "#edf8b1"
set style line 9 lt 1 pt 3 lc rgb "#ffffd9"
set style line 10 lt 1 pt 1 lc rgb "#662506"
set style line 11 lt 1 pt 1 lc rgb "#993404"
set style line 12 lt 1 pt 4 lc rgb "#cc4c02"
set style line 13 lt 1 pt 4 lc rgb "#ec7014"
set style line 14 lt 1 pt 6 lc rgb "#fe9929"
set style line 15 lt 1 pt 6 lc rgb "#fec44f"
set style line 16 lt 1 pt 8 lc rgb "#fee391"
set style line 17 lt 1 pt 8 lc rgb "#fff7bc"
set style line 18 lt 1 pt 3 lc rgb "#ffffe5"

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
      "Data/pos_distr_F=250_attached.dat" u (shift($1+6)):($2*10) title "Empirical" w points ls 10 \
      , rho(x,250) title "Theory" ls 15

