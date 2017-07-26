#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tension_eta.pdf"

load "Data/my.pal"

set xzeroaxis
set yzeroaxis

set key top right Left width -1

set ylabel "{/Symbol h}"
set xlabel "Tension (pN)"

gamma_M = 0.66
gamma_A = 0.97

plot [-20:20] \
      "Data/F_q_k=8.dat" u ( ( (2.*gamma_A + gamma_M)*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 3 t "Simple setup 4 heads" \
    , "Data/F_q_8heads.dat" u ( ( (2.*gamma_A + gamma_M)*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 6 t "Simple setup 8 heads" \
    , "Data/tug_F_E.dat" u (-($2-$4)*gamma_A-2.*$1):(1+$9/$8):(sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w errorlines ls 8 t "Tug of war" \
    , "Data/tug_k_E.dat" u (-($2-$4)*$1):(1+$9/$8):(sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w errorlines ls 10 t "Elastic environment" 
