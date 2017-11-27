#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_F.pdf"

gamma_M = 0.66
gamma_A = 0.97

load "Data/my.pal"

set key left Left width -2 

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}{/Symbol t}_M{/Symbol \361} (pN)"

set xzeroaxis
set yzeroaxis

plot [-150:150][-75:75] \
      "Data/tug_F.dat" u (-$1):(-0.5*($2-$4)*gamma_A-$1):(0.5*$3*gamma_A) w errorlines ls 8 lw 1.25 dashtype 1 title "Tug of war"  \
    , x w lines ls 7 lw 1.25 dashtype 1 title "- Small load" \
    , "Data/F_q_fil.dat" u (-$1):(0.5*gamma_M*gamma_A/(gamma_M+gamma_A)*(-$2-$1/gamma_A)):(0.5*gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 6 lw 1.25 dashtype 1 title "Load on the polymer" \
    , 0.5*gamma_M/(gamma_A+gamma_M)*x w lines ls 6 lw 1.25 dashtype 1 title "- Small load" \
    , "Data/tug_F_compare.dat" u 1:(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(gamma_A/(gamma_M+gamma_A)+1))):(0.5*gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 3 lw 1.25 dashtype 1 title "Load on the motor" \
    , 0.5*(1.+gamma_M/(gamma_A+gamma_M))*x w lines ls 4 lw 1.25 dashtype 1 title "- Small load" \
    , 0.5*x w lines ls 4 lw 1.25 dashtype 2 title "- Large load" \
