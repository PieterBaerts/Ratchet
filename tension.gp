#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tension.pdf"

load "Data/my.pal"

set key bottom left Left width -2 

set xzeroaxis
set yzeroaxis

set xlabel "F_{load} (pN)"
set ylabel "Tension (pN)"

gamma_M = 0.66
gamma_A = 0.97

plot [-50:50][-60:60] \
      "Data/F_q_k=1.dat" u (-$1):(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A))):(gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 1 lw 1.25 dashtype 1 title "k_{bind}/k_{unbind} = 0.25" \
    , "Data/F_q_k=2.dat" u (-$1):(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A))):(gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 3 lw 1.25 dashtype 2 title "k_{bind}/k_{unbind} = 0.5" \
    , "Data/F_v_k=4.dat" u (-$1):(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A))):(gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 6 lw 1.25 dashtype 4 title "k_{bind}/k_{unbind} = 1" \
    , "Data/F_v_k=8.dat" u (-$1):(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A))):(gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 8 lw 1.25 dashtype 5 title "k_{bind}/k_{unbind} = 2" \
    , "Data/F_v_k=16.dat" u (-$1):(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A))):(gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 10 lw 1.25 dashtype 6 title "k_{bind}/k_{unbind} = 4" \
    , -(1+gamma_A/(gamma_A+gamma_M))*x w lines lc rgb "black" lw 1.25 dashtype 1 title "Initial tension" \
    , -x w lines ls 4 lw 1.25 dashtype 1 title "Asymptotic tension" \
