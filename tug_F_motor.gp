#!/usr/bin/gnuplot
set term pdfcairo enhanced linewidth 1.75 font ",14"
set output "tug_F_motor.pdf"

load "Data/my.pal"

set key off

set xlabel "F_{load} (pN)"
set ylabel "{/Symbol \341}v{/Symbol \361} (mm/s)"

plot "Data/tug_F.dat" u (-$1):(($6)*1e-6):(($7)*1e-6) w errorlines ls 8 lw 1.25 notitle 

