import numpy as np
import scipy.integrate as integrate

from matplotlib import pyplot as plt

#---------------------------------------------------------------------------------------
# Primitive functions
#---------------------------------------------------------------------------------------

def heaviside(x):
    return np.piecewise(x,[x<=0,x>0],[0,1])

def delta(x,L,N):
    dx = L / N 
    return ( heaviside(x+dx) - heaviside(x) ) / dx

def g(x,y,L):
    return heaviside(x-y) + (y-x)/L

def exp_g(x,y,L,gamma):
    E = np.exp( np.tensordot( gamma, (y-x)/L, axes=0 ) ) 
    H = ( 1 + np.tensordot( np.exp(gamma) - 1, heaviside(x-y), axes=0 ) )
    return E * H 

def V(x,V0,a,L):
    return np.piecewise(x,[x<a*L,x>=a*L],[lambda x: V0*(1-x/(a*L)), lambda x: V0*(x-a*L)/((1-a)*L) ])

def Fpot(x,V0,a,L):
    return np.piecewise(x,[x<a*L,x>=a*L],[lambda x: V0/(a*L), lambda x: -V0/((1-a)*L) ])

def exp_dV(x,y,beta,V0,a,L,F):
    A = np.exp(beta*(V(y,V0,a,L)-V(x,V0,a,L)))
    B = exp_g(x,y,L,-beta*F*L)
    return  A * B  

#---------------------------------------------------------------------------------------
# Kernel generation
#---------------------------------------------------------------------------------------

def get_kernel(f,L,N,M=None):
    if not M:
        M = N 
    x = np.linspace(0.,L,N,endpoint=False)
    y = np.linspace(0.,L,M,endpoint=False)
    xx = np.tile(x,M).reshape(M,N)
    yy = np.tile(y,N).reshape(N,M)
    return f(xx.T,yy)

def get_function(f,L,N):
    x = np.linspace(0.,L,N,endpoint=False)
    return np.diagflat( f(x) ) 

def der(N,L):
    D =np.tri(N,k=1)-np.tri(N,k=0)
    D -= D.T 
    D[-1,0]=1
    D[0,-1]=-1
    return D*N/(2*L)

def G(L,N,M=None):
    return get_kernel(lambda x,y:g(x,y,L),L,N,M)
def exp_G(gamma,L,N,M=None):
    return get_kernel(lambda x,y:exp_g(x,y,L,gamma),L,N,M)
def exp_DV(beta,V0,a,L,F,N,M=None):
    return get_kernel(lambda x,y:exp_dV(x,y,beta,V0,a,L,F),L,N,M)
    

np.dtype("float128")

K=256
N=768
M=768
O=2

L = 8 
beta = 1/4.28
gamma = 0.97*0.66/(0.97+0.66)
V0 = 40
a = 0.25
c = 0.3
Fmax = 10
scale =0.9 
F = np.linspace(0,K//2-1, K//2 )
F = Fmax * scale ** F 
F = np.append( -F , np.flip( F, axis = 0 ) )

lambda1 = 4e-5 * 4e1 
lambdac = 8e-5 * 4e1 
w1 = lambdac / ( lambda1 + lambdac )
wc = lambda1 / ( lambda1 + lambdac )

#prepare the integration kernel
print("Kernel 1 preparation ...")
exp1 = exp_DV(beta,V0,a,L,F,N,M)
print("Kernel 2 preparation ...")
expc = exp_DV(beta,c*V0,a,L,F,N,M)

print("Kernel G preparation ...")
gv = G(L,M,N)

print("Final kernels preparation ...")
ker1 = exp1.dot(gv) * L/M 
kerc = expc.dot(gv) * L/M

print("Regularization ...")
exp1 = exp_DV(beta,V0,a,L,F,N)
expc = exp_DV(beta,c*V0,a,L,F,N)

gv = G(L,N)

print("g(L/2,y): ", gv[N//2]) 

print("Partition functions ...")
ones = np.ones(N)

Z1 = np.tile( exp1.dot( L/N * ones ).dot( L/N * ones ), N).reshape(N,K).T 
Zc = np.tile( expc.dot( L/N * ones ).dot( L/N * ones ), N).reshape(N,K).T 

print("Force: ", F[K//2] ) 
print("Partition function: ", Z1[K//2] )
print("Theoretical partition function: ", L**2 * np.sinh( 0.5 * beta * V0 )**2 / ( 0.5 * beta * V0 )**2 )

print("Kernels for currents ...")
 
J1 = lambda1 * lambdac / (lambda1 + lambdac ) * ( - gv + np.einsum("ij, ik -> ijk", 1/Z1, np.sum( ker1, axis=1 ) * L/N ) )
Jc = lambda1 * lambdac / (lambda1 + lambdac ) * ( - gv + np.einsum("ij, ik -> ijk", 1/Zc, np.sum( kerc, axis=1 ) * L/N ) )

#First correction 
print("Full kernels for iterations order ...")
inv_exp_F = 1/ ( 1 - np.exp( - beta * F * L ) )

full_ker1 = lambda1 * beta * gamma * np.einsum("i, ijk -> ijk", inv_exp_F, ker1 - np.einsum("ij, ik -> ijk", exp1.dot(L/N * ones ) / Z1 , np.sum( ker1, axis=1 ) * L/N ) ) 
full_kerc = lambdac * beta * gamma * np.einsum("i, ijk -> ijk", inv_exp_F, kerc - np.einsum("ij, ik -> ijk", expc.dot(L/N * ones ) / Zc , np.sum( kerc, axis=1 ) * L/N ) ) 

#plt.title("Kernel for c = 1 and F = %s." % F[0] )
#plt.imshow( full_ker1[0] )
#plt.show()
#
#plt.title("Kernel for c = %s and F = %s." % (c, F[0] ) )
#plt.imshow( full_kerc[0] )
#plt.show()
#
#plt.title("Kernel for c = 1 and F = %s." % F[K//2] )
#plt.imshow( full_ker1[K//2] )
#plt.show()
#
#plt.title("Kernel for c = %s and F = %s." % (c, F[K//2] ) )
#plt.imshow( full_kerc[K//2] )
#plt.show()
#
#plt.title("Kernel for c = 1 and F = %s." % F[-1] )
#plt.imshow( full_ker1[-1] )
#plt.show()
#
#plt.title("Kernel for c = %s and F = %s." % (c, F[-1] ) )
#plt.imshow( full_kerc[-1] )
#plt.show()
#
#Prepare the zeroth order solution
print("Zeroth order ...")
rho1 = exp1.dot( L / N * ones ) 
rho1 /= Z1

rhoc = expc.dot( L / N * ones ) 
rhoc /= Zc

rho = np.array( [ [ rho1, rhoc ] ] ) 

print("Probability distribution: ", rho1[K//2] )
x = np.linspace(0,L,N,endpoint=False)
rho0 = np.exp( - beta * V(x,V0,a,L) ) 
rho0 /= np.sum(rho0) * L/N 
print("Theoretical probability distribution: ", rho0 ) 

print("Probability distribution: ", rhoc[K//2] )
rho0c = np.exp( - beta * V(x,c*V0,a,L) ) 
rho0c /= np.sum(rho0c) * L/N 
print("Theoretical probability distribution: ", rho0c ) 

#Currents 
print("Zeroth order currents ...")
j1 = w1 * np.einsum("i, ij -> ij", 1./ inv_exp_F, 1. / beta / gamma / Z1 )
jc = wc * np.einsum("i, ij -> ij", 1./ inv_exp_F, 1. / beta / gamma / Zc )

j = np.array( [ [ j1, jc ] ] )  

print("Current: ", j1[K//2] )
print("Theoretical current: ", w1 * F[K//2] / gamma / L / np.sinh( 0.5 * beta * V0 )**2 * ( 0.5 * beta * V0 )**2 )
print()
print("Force: ",  F[K//2] )
print("Mean velocity [mm/s]: ", (j1[K//2]+jc[K//2]).dot(ones * L/N) )
print("Theoretical velocity: ", w1 * F[K//2] / gamma / np.sinh( 0.5 * beta * V0 )**2 * ( 0.5 * beta * V0 )**2 
                              + wc * F[K//2] / gamma / np.sinh( 0.5 * beta * c * V0 )**2 * ( 0.5 * beta * c * V0 )**2 
)
print()
print("Force: ",  F[K-1] )
print("Mean velocity [mm/s]: ", (j1[K-1]+jc[K-1]).dot(ones * L/N) )
print("Theoretical velocity: ", (w1+wc) * F[K-1] / gamma )
print()
print("Force: ",  F[0] )
print("Mean velocity [mm/s]: ", (j1[0]+jc[0]).dot(ones * L/N) )
print("Theoretical velocity: ", (w1+wc) * F[0] / gamma )
print()
print("Iterations ..")
for i in range(O):
    rho1 = np.einsum("ijk,ik -> ij", full_ker1, - rho[-1,0] + rho[-1,1] ) * L/N
    rhoc = np.einsum("ijk,ik -> ij", full_kerc,   rho[-1,0] - rho[-1,1] ) * L/N 

    j1 = np.einsum("ijk, ik -> ij", J1, - rho[-1,0] + rho[-1,1] ) * L/N
    jc = np.einsum("ijk, ik -> ij", Jc,   rho[-1,0] - rho[-1,1] ) * L/N 

    rho = np.append( rho, [ [ rho1, rhoc ] ], axis=0 )

    j = np.append( j, [[ j1, jc ]], axis=0 )

full_rho = np.array( [[ w1 * rho[0,0], wc * rho[0,1] ]] ) 
for i in range(1,O+1):
    rho1 = full_rho[-1,0] + w1 * rho[i,0]
    rhoc = full_rho[-1,1] + wc * rho[i,1]
    
    full_rho = np.append( full_rho,[ [ rho1, rhoc ]], axis=0 )

print("Force: ", F[K//2] ) 
print( "Velocity first order [mm/s]: ", (j[1,0,K//2]+j[1,1,K//2]).dot( ones * L / N ) )
rho0n = np.exp( beta * V(x,V0,a,L) ) 
rho0n /= np.sum(rho0n) * L/N 
rho0cn = np.exp( beta * c * V(x,V0,a,L) ) 
rho0cn /= np.sum(rho0cn) * L/N 
print( "Theoretical velocity first order [mm/s]: ", L * lambda1 * lambdac / ( lambda1 + lambdac ) * gv.dot( ( rho0c - rho0 ) * L/N ).dot( ( rho0n - rho0cn) * L/N ) )
print( "Velocity second order [mm/s]: ", (j[2,0,K//2]+j[2,1,K//2]).dot( ones * L / N ) )

#Show results 
#plt.imshow( rho[0,0] )
#plt.show()
#
#plt.imshow( rho[0,1] )
#plt.show()
#
#plt.imshow( full_rho[-1,0] )
#plt.show()
#
#plt.imshow( full_rho[-1,1] )
#plt.show()
#
#for i in range(O+1):
#    plt.plot( np.linspace(0,2*L,2*N,endpoint=False), np.tile( full_rho[i,0,K//2], 2) ) 
#
#Z = np.sum(np.exp(-beta*V(np.linspace(0,L,N,endpoint=False),V0,a,L)) ) * L/N 
#plt.plot( np.linspace(0,2*L,2*N,endpoint=False), w1 * np.exp(-beta*V(np.linspace(0,2*L,2*N,endpoint=False),V0,a,L))/Z )
#plt.show()

for i in range(O+1):
    plt.plot( F, ( j[i,0]+j[i,1] ).dot( ones * L/N ) ) 
plt.show() 

for i in range(O+1):
    plt.plot( F, ( np.sum( j[:(i+1),0]+j[:(i+1),1] , axis=0) ).dot( ones * L/N ) ) 
plt.show() 

#for i in range(O+1):
#    plt.plot( np.linspace(0,2*L,2*N,endpoint=False), np.tile( full_rho[i,1,K//2], 2) ) 
#
#Z = np.sum(np.exp(-beta*V(np.linspace(0,L,N,endpoint=False),c*V0,a,L)) ) * L/N 
#plt.plot( np.linspace(0,2*L,2*N,endpoint=False), wc * np.exp(-beta*V(np.linspace(0,2*L,2*N,endpoint=False),c*V0,a,L))/Z )
#plt.show()
#
#for i in range(O+1):
#    plt.plot( np.linspace(0,2*L,2*N,endpoint=False), np.tile( w1 * rho[i,0,K//2], 2) ) 
#
#Z = np.sum(np.exp(-beta*V(np.linspace(0,L,N,endpoint=False),V0,a,L)) ) * L/N 
#plt.plot( np.linspace(0,2*L,2*N,endpoint=False), w1 * np.exp(-beta*V(np.linspace(0,2*L,2*N,endpoint=False),V0,a,L))/Z )
#plt.show()
#
