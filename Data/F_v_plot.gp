
set output "eff_frict_decay.pdf"
f(x) = a/x
a=1
set xlabel "F_{l}"
set ylabel "F_{eff}"
set logscale
fit [50:] f(x) "F_v.dat" u ($1):(0.66*$2+$1) via a
plot [10.:][1.:20.] "F_v.dat" u ($1):(0.66*$2+$1) title "Simulation", f(x) title "Fit"


unset tmargin
unset bmargin
unset lmargin
unset rmargin

reset
set output "chemical_cycle.pdf"
set xzeroaxis
set yzeroaxis
set key top left
set ylabel "Chemical efficiency {/Symbol h}"
set xlabel "F_{l} (pN)"
plot "F_q_k=4.dat" u (-$1):(($4+$5)/$4) w lines title "k_{d} = 40 s^{-1}",  "F_q_k=8.dat" u (-$1):(($4+$5)/$4) w lines title "k_{d} = 80 s^{-1}", "F_q_k=16.dat" u (-$1):(($4+$5)/$4) w lines title "k_{d} = 160 s^{-1}", "F_q_k=32.dat" u (-$1):(($4+$5)/$4) w lines title "k_{d} = 320 s^{-1}", "F_q_k=64.dat" u (-$1):(($4+$5)/$4) w lines title "k_{d} = 640 s^{-1}"



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



