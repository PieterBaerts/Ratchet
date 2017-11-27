#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tension_eta.pdf"

load "Data/my.pal"

set xzeroaxis
set yzeroaxis

set key top right Left width -3

set ylabel "{/Symbol h}_{chem}"
set xlabel "{/Symbol \341}{/Symbol t}_M{/Symbol \361} (pN)"

gamma_M = 0.66
gamma_A = 0.97

plot [-10:10] \
      "Data/F_q_k=8.dat" u (0.5* ( (2.*gamma_A + gamma_M)*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 3 lw 1.25 pt 2 dashtype 1 t "Load on motor" \
    , "Data/F_q_fil.dat" u (0.5* (-gamma_M/(gamma_A+gamma_M)*($2*gamma_A+$1))):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 6 lw 1.25 pt 4 dashtype 2 t "Load on polymer" \
    , "Data/tug_F.dat" u (0.5*(-($2-$4)*gamma_A-2.*$1)):(1+$9/$8):(sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w errorlines ls 8 lw 1.25 pt 6 dashtype 4 t "Tug of war" \
    , "Data/tug_k_E.dat" u (-0.5*($2-$4)*$1):(1+$9/$8):(sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w errorlines ls 10 lw 1.25 pt 8 dashtype 5 t "Elastic environment" \


#    , "Data/F_q_k=8.dat" u (0.5* ( (2.*gamma_A + gamma_M)*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4+sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w lines ls 3 dashtype 1 notitle \
#    , "Data/F_q_k=8.dat" u (0.5* ( (2.*gamma_A + gamma_M)*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4-sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w lines ls 3 dashtype 1 notitle \
#    , "Data/F_q_fil.dat" u (0.5* (-1./(gamma_A+gamma_M)*($2*gamma_A+$1))):(1+$5/$4+sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w lines ls 6 dashtype 2 notitle \
#    , "Data/F_q_fil.dat" u (0.5* (-1./(gamma_A+gamma_M)*($2*gamma_A+$1))):(1+$5/$4-sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w lines ls 6 dashtype 2 notitle \
#    , "Data/tug_F.dat" u (0.5*(-($2-$4)*gamma_A-2.*$1)):(1+$9/$8+sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w lines ls 8 dashtype 4 notitle \
#    , "Data/tug_F.dat" u (0.5*(-($2-$4)*gamma_A-2.*$1)):(1+$9/$8-sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w lines ls 8 dashtype 4 notitle \
#    , "Data/tug_k_E.dat" u (-0.5*($2-$4)*$1):(1+$9/$8+sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w lines ls 10 dashtype 5 notitle \
#    , "Data/tug_k_E.dat" u (-0.5*($2-$4)*$1):(1+$9/$8-sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w lines ls 10 dashtype 5 notitle \

#    , "Data/F_q_8heads.dat" u (0.5* ( (2.*gamma_A + gamma_M)*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 6 t "Simple setup 8 heads" \
