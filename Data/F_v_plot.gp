
set output "chemical_cycle_1head.pdf"
set xzeroaxis
set yzeroaxis
set key top left
set ylabel "Chemical efficiency {/Symbol h}"
set xlabel "F_{l} (pN)"
plot [][-0.1:0.3] "F_q_1head.dat" u (-$1):(($4+$5)/$4) w lines title "1 head",  "F_q_k=8.dat" u (-$1):(($4+$5)/$4) w lines title "4 heads"


set output "tug_k.pdf"
set key off
set ylabel "F (pN)"
set xlabel "k (pN/nm)"
plot "tug_k.dat" u 1:($1*$3), "" u 1:($1*$3) w lines lt 1

reset
set output "tug_v.pdf"
set key off
set ylabel "F (pN)"
set xlabel "time (s)"
plot "tug_v_plot.dat" u ($1*1e-6):($3*0.1)



set output "tug_F.pdf"
set key off
set xlabel "F (pN)"
set ylabel "<v> (nm/µs)"
plot "tug_F.dat" u ($1):(($2)*1e-6+$1/0.97)



set output "tug_F_motor.pdf"
set xlabel "F (pN)"
set ylabel "<v> (nm/µs)"
plot "tug_F.dat" u ($1):(($2+$3)*0.97/0.66/1e6)



