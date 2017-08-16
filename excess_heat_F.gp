#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "excess_heat_F.pdf"

gamma_M = 0.66
gamma_A = 0.97

load "Data/my.pal"

set key left Left width -2 

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}Q_{in} + Q_{out}{/Symbol \361} (pN nm)"

set xzeroaxis
set yzeroaxis

set y2zeroaxis




plot [-150:150][:] \
    "Data/F_q_k=8.dat" u ($1/0.66):(-$2*0.66*0.97/(0.66+0.97)*($2+$1/0.66)) w errorlines title "Load on motor"\
  , "Data/F_q_fil.dat" u (-$1/0.97):($2*0.66*0.97/(0.66+0.97)*(-$2-$1/0.97)) w errorlines title "Load on polymer"\
  , "Data/tug_F.dat" u (-$1/0.97):($2*(-$2*0.97-$1)) w errorlines title "Tug-of-war"\
  , "Data/F_q_k=8.dat" u ($1/0.66):(1+$5/$4)*2500 w errorlines title "Load on motor"\
  , "Data/F_q_fil.dat" u (-$1/0.97):(1+$5/$4)*2500 w errorlines title "Load on polymer"\
  , "Data/tug_F.dat" u (-$1/0.97):(1+$9/$8)*2500 w errorlines title "Tug-of-war"\

