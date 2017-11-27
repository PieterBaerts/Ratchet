#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "lambda_eta.pdf"

load "Data/my.pal"

set xzeroaxis
set yzeroaxis

set key top right Right width -4

set ylabel "{/Symbol h}_{chem}"
set xlabel "{/Symbol \341}F_r{/Symbol \361} (pN)"

gamma_M = 0.66
gamma_A = 0.97

plot [-20:20][-0.1:0.3] \
      "Data/F_q_k=1.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w lines ls 1 lw 1.25 dashtype 1 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 0.25" \
    , "Data/F_q_k=2.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w lines ls 3 lw 1.25 dashtype 2 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 0.5" \
    , "Data/F_q_k=4.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w lines ls 6 lw 1.25 dashtype 4 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 1" \
    , "Data/F_q_k=8.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w lines ls 8 lw 1.25 dashtype 5 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 2" \
    , "Data/F_q_k=16.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w lines ls 10 lw 1.25 dashtype 1 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 4" \
    , "Data/F_q_k=32.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w lines ls 11 lw 1.25 dashtype 7 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 8"
#      "Data/F_q_k=1.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 1 lw 1.25 dashtype 1 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 0.25" \
#    , "Data/F_q_k=2.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 3 lw 1.25 pt 2 dashtype 2 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 0.5" \
#    , "Data/F_q_k=4.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 6 lw 1.25 pt 4 dashtype 4 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 1" \
#    , "Data/F_q_k=8.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 8 lw 1.25 pt 6 dashtype 5 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 2" \
#    , "Data/F_q_k=16.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 10 lw 1.25 pt 8 dashtype 1 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 4" \
#    , "Data/F_q_k=32.dat" u ( ( gamma_A*$1 + gamma_A*gamma_M*$2)/(gamma_A + gamma_M)):(1+$5/$4):(sqrt($6**2/$4**2+$5**2/$4**4*$7**2)) w errorlines ls 11 lw 1.25 pt 10 dashtype 7 title "{/Symbol l}_{b}/{/Symbol l}_{u} = 8"
