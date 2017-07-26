#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tension_heads.pdf"

load "Data/my.pal"

set key bottom left Left width -2 

set xzeroaxis
set yzeroaxis

set xlabel "F_{load} (pN)"
set ylabel "Tension (pN)"

gamma_M = 0.66
gamma_A = 0.97

plot [-50:50][:] \
      "Data/F_q_zoom_1head.dat" u (-$1):(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A))):(gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 8 lw 1.25 dashtype 1 title "1 head" \
    , "Data/F_q_zoom_4heads.dat" u (-$1):(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A))):(gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 6 lw 1.25 dashtype 2 title "4 heads" \
    , "Data/F_q_zoom_16heads.dat" u (-$1):(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A))):(gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 3 lw 1.25 dashtype 3 title "16 heads" \
    , -(1+gamma_A/(gamma_A+gamma_M))*x w lines lc rgb "black" lw 1.25 dashtype 1 title "Small load" \
    , -x w lines ls 4 lw 1.25 dashtype 1 title "Large load" \
    
    #    , "Data/F_q_2heads.dat" u (-$1):(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A))):(gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 3 lw 1.25 dashtype 2 title "2 heads" \
#    , "Data/F_q_8heads.dat" u (-$1):(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A))):(gamma_M*gamma_A/(gamma_M+gamma_A)*$3) w errorlines ls 8 lw 1.25 dashtype 5 title "8 heads" \

