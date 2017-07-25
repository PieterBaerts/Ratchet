#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "k_eta.pdf"

load "Data/my.pal"

set xzeroaxis
set yzeroaxis

set logscale x 

set key top left Left width -1

set ylabel "{/Symbol h}"
set xlabel "k (pN/nm)"

plot [:][:] \
    "Data/tug_k_E.dat" u 1:(1+$9/$8):(sqrt($11**2/$8**2+$9**2/$8**4*$10**2)) w errorlines ls 8 lw 1.25 pt 2 dashtype 1 notitle \

