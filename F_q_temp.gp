#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "F_q_temp.pdf"

load "Data/my.pal"

set xzeroaxis
set yzeroaxis

set key top right Right width -4

set ylabel "{/Symbol h}_{chem}"
set xlabel "F_{load} (pN)"

plot [:][-0.25:0.45] \
      "Data/F_v_kBT=0.dat" u 1:(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 1 lw 1.25 dashtype 1 title "T = 0 K" \
    , "Data/F_v_kBT=1.dat" u 1:(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 3 lw 1.25 pt 2 dashtype 2 title "T = -200 {/Symbol \260}C" \
    , "Data/F_v_kBT=2.39.dat" u 1:(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 6 lw 1.25 pt 4 dashtype 4 title "T = -100 {/Symbol \260}C" \
    , "Data/F_v_kBT=3.77.dat" u 1:(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 8 lw 1.25 pt 6 dashtype 5 title "T = 0 {/Symbol \260}C" \
    , "Data/F_v_kBT=4.28.dat" u 1:(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 10 lw 1.25 pt 8 dashtype 1 title "T = 37 {/Symbol \260}C" \
    , "Data/F_v_kBT=5.1.dat" u 1:(($4+$5)/$4):(sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w points ls 11 lw 1.25 pt 10 dashtype 7 title "T = 100 {/Symbol \260}C" \
    , "Data/F_v_kBT=0.dat" u 1:(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 1 lw 1.25 dashtype 1 notitle \
    , "Data/F_v_kBT=1.dat" u 1:(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 3 lw 1.25 dashtype 2 notitle \
    , "Data/F_v_kBT=2.39.dat" u 1:(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 6 lw 1.25 dashtype 4 notitle \
    , "Data/F_v_kBT=3.77.dat" u 1:(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 8 lw 1.25 dashtype 5 notitle \
    , "Data/F_v_kBT=4.28.dat" u 1:(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 10 lw 1.25 dashtype 1 notitle \
    , "Data/F_v_kBT=5.1.dat" u 1:(($4+$5)/$4+sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 11 lw 1.25 dashtype 7 notitle \
    , "Data/F_v_kBT=0.dat" u 1:(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 1 lw 1.25 dashtype 1 notitle \
    , "Data/F_v_kBT=1.dat" u 1:(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 3 lw 1.25 dashtype 2 notitle \
    , "Data/F_v_kBT=2.39.dat" u 1:(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 6 lw 1.25 dashtype 4 notitle \
    , "Data/F_v_kBT=3.77.dat" u 1:(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 8 lw 1.25 dashtype 5 notitle \
    , "Data/F_v_kBT=4.28.dat" u 1:(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 10 lw 1.25 dashtype 1 notitle \
    , "Data/F_v_kBT=5.1.dat" u 1:(($4+$5)/$4-sqrt($7**2/$4**2+$5**2/$4**4*$6**2)) w lines ls 11 lw 1.25 dashtype 7 notitle \
    

