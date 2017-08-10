#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_eta_setup.pdf"

load "Data/my.pal"

set xzeroaxis
set yzeroaxis

set key top right Right width -1

set ylabel "{/Symbol h}_{chem}"
set xlabel "F_{load} (pN)"

plot [:][-0.2:0.35] \
      "Data/F_q_k=8.dat" u 1:(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w linespoint ls 3 lw 1.25 pt 2 dashtype 1 title "Load on motor" \
    , "Data/F_q_k=8.dat" u 1:(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 3 lw 1.25 dashtype 1 notitle \
    , "Data/F_q_k=8.dat" u 1:(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 3 lw 1.25 dashtype 1 notitle \
    , "Data/F_q_fil.dat" u (-$1):(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w linespoint ls 6 lw 1.25 pt 4444 dashtype 2 title "Load on polymer" \
    , "Data/F_q_fil.dat" u (-$1):(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 6 lw 1.25 dashtype 2 notitle \
    , "Data/F_q_fil.dat" u (-$1):(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 6 lw 1.25 dashtype 2 notitle \
    , "Data/tug_F.dat" u (-$1):(1+$9/$8):(sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w linespoint ls 8 lw 1.25 pt 6 dashtype 4 title "Tug of war" \
    , "Data/tug_F.dat" u (-$1):(1+$9/$8+sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w lines ls 8 lw 1.25 dashtype 4 notitle \
    , "Data/tug_F.dat" u (-$1):(1+$9/$8-sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w lines ls 8 lw 1.25 dashtype 4 notitle \

#    , "Data/F_q_8heads.dat" u 1:(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w linespoint ls 6 lw 1.25 pt 4 dashtype 2 title "Simple setup 8 heads" \
#    , "Data/F_q_8heads.dat" u 1:(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 6 lw 1.25 dashtype 2 notitle \
#    , "Data/F_q_8heads.dat" u 1:(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 6 lw 1.25 dashtype 2 notitle \
