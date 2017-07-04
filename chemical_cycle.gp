#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "chemical_cycle.pdf"

load "Data/my.pal"

set xzeroaxis
set yzeroaxis

set key top left Left width -4

set ylabel "{/Symbol h}"
set xlabel "F_{load} (pN)"

plot [:][-0.25:0.45] \
      "Data/F_q_k=1.dat" u (-$1):(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 1 lw 1.25 dashtype 1 title "k_{bind}/k_{unbind} = 0.25" \
    , "Data/F_q_k=1.dat" u (-$1):(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 1 lw 1.25 dashtype 1 notitle \
    , "Data/F_q_k=1.dat" u (-$1):(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 1 lw 1.25 dashtype 1 notitle \
    , "Data/F_q_k=2.dat" u (-$1):(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 3 lw 1.25 pt 2 dashtype 2 title "k_{bind}/k_{unbind} = 0.5" \
    , "Data/F_q_k=2.dat" u (-$1):(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 3 lw 1.25 dashtype 2 notitle \
    , "Data/F_q_k=2.dat" u (-$1):(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 3 lw 1.25 dashtype 2 notitle \
    , "Data/F_q_k=4.dat" u (-$1):(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 6 lw 1.25 pt 4 dashtype 4 title "k_{bind}/k_{unbind} = 1" \
    , "Data/F_q_k=4.dat" u (-$1):(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 6 lw 1.25 dashtype 4 notitle \
    , "Data/F_q_k=4.dat" u (-$1):(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 6 lw 1.25 dashtype 4 notitle \
    , "Data/F_q_k=8.dat" u (-$1):(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 8 lw 1.25 pt 6 dashtype 5 title "k_{bind}/k_{unbind} = 2" \
    , "Data/F_q_k=8.dat" u (-$1):(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 8 lw 1.25 dashtype 5 notitle \
    , "Data/F_q_k=8.dat" u (-$1):(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 8 lw 1.25 dashtype 5 notitle \
    , "Data/F_q_k=16.dat" u (-$1):(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 10 lw 1.25 pt 8 dashtype 1 title "k_{bind}/k_{unbind} = 4" \
    , "Data/F_q_k=16.dat" u (-$1):(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 10 lw 1.25 dashtype 6 notitle \
    , "Data/F_q_k=16.dat" u (-$1):(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 10 lw 1.25 dashtype 6 notitle \
    , "Data/F_q_k=32.dat" u (-$1):(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 11 lw 1.25 pt 10 dashtype 7 title "k_{bind}/k_{unbind} = 8" \
    , "Data/F_q_k=32.dat" u (-$1):(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 11 lw 1.25 dashtype 7 notitle \
    , "Data/F_q_k=32.dat" u (-$1):(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 11 lw 1.25 dashtype 7 notitle 


