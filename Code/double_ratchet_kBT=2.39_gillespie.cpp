#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>
#include <time.h>
#include <iostream>
#include <fstream>
#include <boost/random.hpp>


const double KbT = 2.39;

const double dt = 0.001;
const int N_timesteps = 1e9;

const int N = 1e2; /*Number of copies in ensemble to average over*/

const double l = 8.;

const int N_heads = 4;
const double l_heads = 15.;

const double a = 0.25;
const int N_a = 1;

const double dE = 30.4;
const double V = 40;
const int N_V = 1;

const double c = 0.3;
const int N_c = 1;
          
const double F_min = 0.;
const double F_max = 0.1;
const double N_F = 11;

const double k_bind = 4e-5; 
const double k_unbind = 8e-5;
      
const double gamma_fil = 0.97;
const double gamma_motor = 0.66;

boost::random::mt19937 rng;   
boost::random::uniform_real_distribution<> uniform;
boost::random::normal_distribution<> normal;

double F_actin(const double motor_x, const double actin_x, const double a, const double Vmax);
double exp_time(double k);
double speed_sim(const int N_heads, const double F_stall, const double a, const double Vmax, double c, double &Q_in, double &Q_out, double &Q_in2, double &Q_out2);
double V_actin(const double motor_x, const double actin_x, const double a, const double Vmax);

int main(int argc, char* argv[]){



	clock_t start, end;
	double cpu_time_used;
	start = clock();
	
	using namespace std;

    //Initialization of random number generator
    unsigned int seed;
    ifstream random_dev("/dev/random", ios::in | ios::binary); 
    if( random_dev.read((char *)&seed, sizeof(seed)) )
    {
        rng.seed(seed);
        cerr << "New seed: " << seed << endl;
    }
    random_dev.close();
    	
	printf("#F\tv(nm/us)\tdv\tQ_in\tQ_out\tdQ_in\tdQ_out\n");
        for(int i = 0; i < N_a; i++){
//                double a = a_min + (a_max-a_min)*i/double(N_a-1);
                for(int j = 0; j < N_F; j++){                        
                        double F = F_min + (F_max - F_min)*j/(N_F-1);
//       			if( j != 0)
//				F = exp( log( F ) + 0.06  );
 
                        double v_tot = 0.;
                        double v2_tot = 0.;
			double Q_in = 0, Q_out = 0;
			double Q_in2 = 0, Q_out2 = 0;
			            for(int k=0; k<N; k++){
		                    double v = speed_sim(N_heads, F, a, V, c, Q_in, Q_out, Q_in2, Q_out2);
			                    v_tot += v;
				            v2_tot += v * v;
			            }
	
	                v_tot /= double(N);
	                v2_tot /= double(N);
			Q_in /= double(N);
			Q_out /= double(N);
			Q_in2 /= double(N);
			Q_out2 /= double(N);

                    	printf("%g\t%g\t%g\t%g\t%g\t%g\t%g\n", F, v_tot, sqrt(v2_tot - v_tot * v_tot), Q_in, Q_out, sqrt(Q_in2 - Q_in*Q_in), sqrt(Q_out2 - Q_out*Q_out));
                        fflush(stdout);

	            }
                printf("\n");
        }
        
   	
	    end = clock();
	    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
	    printf("#a = %lf V = %lf #N_heads = %d   c = %lf       N = %d     time = %lf\n", a, V, N_heads, c, N, dt*N_timesteps);
	    printf("#CPU_time = %f\n", cpu_time_used);

        return 1;        
}



double speed_sim(const int N_heads, const double F_stall, const double a, const double Vmax, const double c, double &Q_in, double &Q_out, double &Q_in2, double &Q_out2){

	double t = 0.;
	
	double p = uniform(rng);
	double motor_x = p*l;
	double actin_x = 0.;
	double q_in = 0, q_out = 0;
	
	int motor_bound[N_heads];
	double jump_time[N_heads];
	for(int i=0; i<N_heads; i++){
	    double p = uniform(rng);
	    if(p < k_bind/(k_bind + k_unbind)){
	        motor_bound[i] = 1;
	        jump_time[i] = exp_time(k_unbind); //Draw time of next jump from exponential distribution
	    }
        else{
            motor_bound[i] = 0;
            jump_time[i] = exp_time(k_bind); //Draw time of next jump from exponential distribution
        }
    }
        
    const double D_motor = sqrt(2*KbT*dt/gamma_motor);
    const double D_fil = sqrt(2*KbT*dt/gamma_fil); 
        
	for(int i=0; i < N_timesteps; i++, t+=dt){
		
		double F = 0;
		
		for(int j=0; j < N_heads; j++){
		    jump_time[j] -= dt;
		    double head_x = motor_x - j*l_heads;
		    if(motor_bound[j] == 0){
				F += c * F_actin(head_x, actin_x, a, Vmax);
		        if(jump_time[j] < 0){
				    motor_bound[j] = 1;
				    jump_time[j] += exp_time(k_unbind);
 				    q_out -= dE + (c-1) * V_actin(head_x, actin_x, a, Vmax);
			}
		    }
		    else{
		        F += F_actin(head_x, actin_x, a, Vmax);
		        if(jump_time[j] < 0){
				    motor_bound[j] = 0;
	                	    jump_time[j] += exp_time(k_bind);
				    q_in += dE + (c-1) * V_actin(head_x, actin_x, a, Vmax);
	                }
	           }
	    }
	        
	    motor_x += dt * (F - F_stall) / gamma_motor + D_motor * normal(rng);
	    actin_x += -dt * F / gamma_fil +  D_fil * normal(rng);
                
	}
	
	Q_in += q_in;
	Q_in2 += q_in*q_in;
	Q_out += q_out;
	Q_out2 += q_out*q_out;

	return (motor_x - actin_x) / t;
}

double F_actin(const double motor_x, const double actin_x, const double a, const double Vmax){
	double x = motor_x - actin_x - l*floor((motor_x - actin_x)/l);
	double al = l*a;                        /* a times l */
	if(x < al)
		return -Vmax / al;
	else
		return Vmax / (l - al);
}


double exp_time(double k){
    if( k > 0. ) 
    {
	    return -1./k*log(1.-uniform(rng));
    } 
    return std::numeric_limits<double>::max(); 
}

double V_actin(const double motor_x, const double actin_x, const double a, const double Vmax){
	double x = motor_x - actin_x - l*floor((motor_x - actin_x)/l);
	double al = l*a;                        /* a times l */
	if(x < al)
		return Vmax * x / al;
	else
		return Vmax * (l - x) / (l - al);
}



