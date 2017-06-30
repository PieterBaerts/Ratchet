
clear
reset

# Add a vertical dotted line at x=0 to show centre (mean) of distribution.
#set yzeroaxis

# Each bar is half the (visual) width of its x-range.
set boxwidth 0.5 absolute
set style fill solid .5 noborder


set key top left
set term pdfcairo enhanced
set xlabel "position (nm)"
set ylabel "Relative frequency"
#set title "Probability distribution"

V(x) = x<2. ? 40.*x/2. : 40.*(8.-x)/6.
shift(x) = x<0 ? shift(x+8) : (x>8 ? shift(x-8) : x)

do for [f in "-1000 -500 -250 -100 -25 0 25 100 250 500 1000"] {
    set output sprintf("pos_distr_F=%s_attached.dat", f)
    set table
    plot [0:8] sprintf("< paste pos_distr_F=%s_head[1234]_attached.dat",f) u 1:($2+$4+$6+$8)/4.
    unset table   
    
    set output sprintf("pos_distr_F=%s_detached.dat", f)
    set table
    plot [0:8] sprintf("< paste pos_distr_F=%s_head[1234]_detached.dat",f) u 1:($2+$4+$6+$8)/4.
    unset table
   
    set key bottom left
    set ylabel "Relative frequency"
    set output sprintf("pos_distr_F=%s.pdf", f)
    plot [0:8][0:] sprintf("< paste pos_distr_F=%s_head[1234]_attached.dat",f) u (shift($1+6)):($2+$4+$6+$8)/4. title "Attached", sprintf("< paste pos_distr_F=%s_head[1234]_detached.dat", f) u (shift($1+6)):($2+$4+$6+$8)/4. title "Detached", V(shift(x-6)) axes x1y2  lt rgb "black" title "V(x)"
    
    set ylabel "V(x)[{/Symbol r}_d(x)-{/Symbol r}_a(x)]"
    set xzeroaxis    
    set output sprintf("chem_energy_distr_F=%s.pdf", f)
    plot [0:8] sprintf("< paste pos_distr_F=%s_attached.dat pos_distr_F=%s_detached.dat", f, f) u (shift($1+6)):((30.4-0.7*V($1))*($2-$5)), V(shift(x-6)) axes x1y2  lt rgb "black" title "V(x)"
    
    stats sprintf("pos_distr_F=%s_attached.dat", f) u (V($1)*$2*10) prefix "A"
    stats sprintf("pos_distr_F=%s_detached.dat", f) u (V($1)*$2*10) prefix "D"
    print (D_mean-A_mean)/(30,4/0.7 - A_mean)
}

set term pdfcairo enhanced size 10,13
set output "pos_multiplot.pdf"
set multiplot
set ylabel "Empirical density {/Symbol r}(x)" 
set key center left
set title "F = 0 pN" font ",15" offset -30,-4
set bmargin at screen 0.96
set tmargin at screen 0.76
set rmargin at screen 0.75
set lmargin at screen 0.25
plot [0:8][0:] "< paste pos_distr_F=0_head[1234]_attached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Attached", "< paste pos_distr_F=0_head[1234]_detached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Detached"
#, V(shift(x-6)) axes x1y2  lt rgb "black" title "V(x)"

unset key
unset xlabel
unset ylabel
set title "F = 25 pN" font ",15" offset -22,-4
set bmargin at screen 0.72
set tmargin at screen 0.52
set rmargin at screen 0.95
set lmargin at screen 0.55
plot [0:8][0:0.4] "< paste pos_distr_F=25_head[1234]_attached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Attached", "< paste pos_distr_F=25_head[1234]_detached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Detached"
#, V(shift(x-6)) axes x1y2  lt rgb "black" title "V(x)"


set title "F = -25 pN" 
set bmargin at screen 0.72
set tmargin at screen 0.52
set rmargin at screen 0.45
set lmargin at screen 0.05
plot [0:8][0:0.4] "< paste pos_distr_F=-25_head[1234]_attached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Attached", "< paste pos_distr_F=-25_head[1234]_detached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Detached"
#, V(shift(x-6)) axes x1y2  lt rgb "black" title "V(x)"


set title "F = 100 pN"
set bmargin at screen 0.48
set tmargin at screen 0.28
set rmargin at screen 0.95
set lmargin at screen 0.55
plot [0:8][0:0.25] "< paste pos_distr_F=100_head[1234]_attached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Attached", "< paste pos_distr_F=100_head[1234]_detached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Detached"
#, V(shift(x-6)) axes x1y2  lt rgb "black" title "V(x)"


set title "F = -100 pN"
set bmargin at screen 0.48
set tmargin at screen 0.28
set rmargin at screen 0.45
set lmargin at screen 0.05
plot [0:8][0:0.25] "< paste pos_distr_F=-100_head[1234]_attached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Attached", "< paste pos_distr_F=-100_head[1234]_detached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Detached"
#, V(shift(x-6)) axes x1y2  lt rgb "black" title "V(x)"


set title "F = 250 pN"
set bmargin at screen 0.24
set tmargin at screen 0.04
set rmargin at screen 0.95
set lmargin at screen 0.55
plot [0:8][0:0.2] "< paste pos_distr_F=250_head[1234]_attached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Attached", "< paste pos_distr_F=250_head[1234]_detached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Detached"
#, V(shift(x-6)) axes x1y2  lt rgb "black" title "V(x)"


set title "F = -250 pN"
set bmargin at screen 0.24
set tmargin at screen 0.04
set rmargin at screen 0.45
set lmargin at screen 0.05
plot [0:8][0:0.2] "< paste pos_distr_F=-250_head[1234]_attached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Attached", "< paste pos_distr_F=-250_head[1234]_detached.dat" u (shift($1+6)):($2+$4+$6+$8)*10/4. title "Detached"
#, V(shift(x-6)) axes x1y2  lt rgb "black" title "V(x)"

unset multiplot




