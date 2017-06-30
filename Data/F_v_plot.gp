

reset
set output "tug_v.pdf"
set key off
set ylabel "F (pN)"
set xlabel "time (s)"
plot "tug_v_plot.dat" u ($1*1e-6):($3*0.1)


set output "tug_F_motor.pdf"
set xlabel "F (pN)"
set ylabel "<v> (nm/µs)"
plot "tug_F.dat" u ($1):(($2+$3)*0.97/0.66/1e6)



