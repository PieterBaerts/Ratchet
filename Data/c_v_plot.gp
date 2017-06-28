
clear
reset

set key off
set term pdf enhanced
set xlabel "c"
set ylabel "<v> (nm/µs)"
set output "c_v_4heads.pdf"
set ytic 0.001
set xtic 0.1
set yrange[-0.:0.005]
set xrange[-0.:1.]
plot 'c_v_4heads.dat' u 1:2 with lines linetype 1 lw 2, '' u 1:2:3 with errorbars linetype 1 lw 2
