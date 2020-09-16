import numpy as np


for f in [-100, -25, 0, 25, 100]:
    data = np.loadtxt('pos_F=%d_alt_par.dat' % f)
    
    for h in [1,2,3,4]:        
        head_a=[ x[2*h-1] for x in data if x[2*h] == 1 ]
        head_d=[ x[2*h-1] for x in data if x[2*h] == 0 ]

        b=[]
        for i in range(81):
            b.append(i/10.)
                   
        hist_head_a = np.histogram(head_a,bins=b)          
        hist_head_d = np.histogram(head_d,bins=b)

        b = .5 * ( hist_head_a[1][:-1] + hist_head_a[1][1:] )
        
        revf = -f
               
        np.savetxt('pos_distr_F=%d_head%d_attached.dat' % (revf,h), np.asarray((b,hist_head_a[0]/float(len(head_a)))).T, delimiter='\t')
        np.savetxt('pos_distr_F=%d_head%d_detached.dat' % (revf,h), np.asarray((b,hist_head_d[0]/float(len(head_d)))).T, delimiter='\t')

