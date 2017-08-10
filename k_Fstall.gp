#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "k_Fstall.pdf"

load "Data/my.pal"

set key off

set xlabel "k_{bind} (k_{unbind})"
set ylabel "F_{stall} (pN)"

set logscale x
set logscale y

set format y "10^{%L}"

set xtics 2 

fit [8:] B*x**(-a)  "Data/F_k.dat" u ($1/4.):6:7 yerrors via a,B

plot [0.25:32] "Data/F_k.dat" u ($1/4.):6:7 w yerrorlines ls 8 \
    , B/x**a ls 6 notitle 
