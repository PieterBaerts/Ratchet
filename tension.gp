#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tension.pdf"

load "Data/my.pal"

set key top left Left width -2 

set xzeroaxis
set yzeroaxis

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}{/Symbol t}_M{/Symbol \361} (pN)"

gamma_M = 0.66
gamma_A = 0.97

plot [-50:50][:] \
      "Data/F_q_k=1.dat" u 1:(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A)))):(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$3)) w errorlines ls 1 lw 1.25 dashtype 1 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 0.25" \
    , "Data/F_q_k=2.dat" u 1:(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A)))):(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$3)) w errorlines ls 3 lw 1.25 dashtype 2 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 0.5" \
    , "Data/F_v_k=4.dat" u 1:(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A)))):(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$3)) w errorlines ls 6 lw 1.25 dashtype 4 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 1" \
    , "Data/F_v_k=8.dat" u 1:(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A)))):(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$3)) w errorlines ls 8 lw 1.25 dashtype 5 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 2" \
    , "Data/F_v_k=16.dat" u 1:(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$2+$1*(1+gamma_A/(gamma_M+gamma_A)))):(0.5*(gamma_M*gamma_A/(gamma_M+gamma_A)*$3)) w errorlines ls 10 lw 1.25 dashtype 6 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 4" \
    , 0.5*(1+gamma_A/(gamma_A+gamma_M))*x w lines ls 4 lc rgb "black" lw 1.25 dashtype 1 title "- Small load" \
    , 0.5*x w lines ls 4 lc rgb "black" dashtype 2 title "- Large load" \
