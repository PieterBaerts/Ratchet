#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>
#include <time.h>
#include <iostream>
#include <fstream>
#include <boost/random.hpp>


const double KbT = 4.278;

const double dt = 0.0005;
const long int N_timesteps = 2e10;
const int printevery = 2e7;

const int N = 64; /*Number of copies in ensemble to average over*/

const double l = 8.;

const int N_heads = 4;
const double l_heads = 12.; /*15.*/
const double l_motor = 200.; /*total motor length*/

const double a = 0.25;
const int N_a = 1;

const double dE = 30.4;
const double V = 40;
const int N_V = 1;

const double c = 0.3;
const int N_c = 1;

const double k_spring_min = 0.0001;
const double k_spring_max = 10.0;
const double Nk_spring = 7;


const double k_bind = 4e-4; /*4e-5*/ 
const double k_unbind = 8e-4; /*8e-5*/
      
const double gamma_fil = 20.; /*0.97*/ 
const double gamma_motor = 13.33; /*0.66*/

boost::random::mt19937 rng;   
boost::random::uniform_real_distribution<> uniform;
boost::random::normal_distribution<> normal;

double F_actin(const double motor_x, const double actin_x, const double a, const double Vmax);
double exp_time(double k);
double speed_sim(const int N_heads, const double a, const double Vmax, double c, double k_spring, double &x1, double &x2, double &x1_2, double &x2_2, double &xm, double &xm_2, double &Q_in, double &Q_out, double &Q_in2, double &Q_out2);
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
    	double k_spring = k_spring_min;
	printf("#k\tx1\tdx1\tx2\tdx2\txm\tdxm\tQ_in\tQ_out\tdQ_in\tdQ_out\n");
        for(int i = 0; i < N_a; i++){
//                double a = a_min + (a_max-a_min)*i/double(N_a-1);
                for(int j = 0; j < Nk_spring; j++){                        
                        k_spring = exp( log(k_spring) + 0.57564 );
//                       double k_spring = atof(argv[1]);
            		double x1, x2, x1_2, x2_2, xm, xm_2;
                        double x1_tot = 0.;
                        double x1_tot_2 = 0.;
                        double x2_tot = 0.;
                        double x2_tot_2 = 0.;
                        double xm_tot = 0.;
                        double xm_tot_2 = 0.;
               			double Q_in = 0, Q_out = 0;
            			double Q_in2 = 0, Q_out2 = 0;
			            for(int k=0; k<N; k++){
		                    speed_sim(N_heads, a, V, c, k_spring, x1 ,x2, x1_2, x2_2, xm, xm_2, Q_in, Q_out, Q_in2, Q_out2);
		                    x1_tot += x1;
			                x1_tot_2 += x1_2;
			                x2_tot += x2;
			                x2_tot_2 += x2_2;
			                xm_tot += xm;
			                xm_tot_2 += xm_2;
			            }
	
	                    x1_tot /= double(N);
	                    x1_tot_2 /= double(N);
	                    x2_tot /= double(N);
	                    x2_tot_2 /= double(N);
	                    xm_tot /= double(N);
	                    xm_tot_2 /= double(N);
	                    Q_in /= double(N);
			            Q_out /= double(N);
			            Q_in2 /= double(N);
			            Q_out2 /= double(N);

                    	printf("%lf\t%lf\t%lf\t%lf\t%lf\t%lf\t%lf\t%lf\t%lf\t%lf\t%lf\n", k_spring, x1_tot, sqrt(x1_tot_2 - x1_tot*x1_tot), x2_tot, sqrt(x2_tot_2 - x2_tot*x2_tot), xm_tot, sqrt(xm_tot_2 - xm_tot*xm_tot), Q_in, Q_out, sqrt(Q_in2 - Q_in*Q_in), sqrt(Q_out2 - Q_out*Q_out));

	            }
                printf("\n");
        }
        
   	
	    end = clock();
	    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
	    printf("#a = %lf V = %lf #N_heads = %d   c = %lf       N = %d     time = %lf\n", a, V, N_heads, c, N, dt*N_timesteps);
	    printf("#CPU_time = %f\n", cpu_time_used);

        return 1;        
}



double speed_sim(const int N_heads, const double a, const double Vmax, const double c, double k_spring, double &x1, double &x2, double &x1_2, double &x2_2, double &xm, double &xm_2, double &Q_in, double &Q_out, double &Q_in2, double &Q_out2){

	double t = 0.;
	
	double p = uniform(rng);
	double motor_x = 5000. + p*l;
	const double actin1_init = 0.;
	p = uniform(rng);
	const double actin2_init = 2*5000. + p*l;
	double actin1_x = actin1_init;
	double actin2_x = actin2_init; 
	
	double q_in = 0, q_out = 0;
	
	int motor_bound1[N_heads];
	int motor_bound2[N_heads];
	double jump_time1[N_heads];
	double jump_time2[N_heads];
	for(int i=0; i<N_heads; i++){
	    double p1 = uniform(rng);
	    double p2 = uniform(rng);
	    if(p1 < k_bind/(k_bind + k_unbind)){
	        motor_bound1[i] = 1;
	        jump_time1[i] = exp_time(k_unbind); //Draw time of next jump from exponential distribution
	    }
        else{
            motor_bound1[i] = 0;
            jump_time1[i] = exp_time(k_bind); //Draw time of next jump from exponential distribution
        }
	    if(p2 < k_bind/(k_bind + k_unbind)){
	        motor_bound2[i] = 1;
	        jump_time2[i] = exp_time(k_unbind); //Draw time of next jump from exponential distribution
	    }
        else{
            motor_bound2[i] = 0;
            jump_time2[i] = exp_time(k_bind); //Draw time of next jump from exponential distribution
        }
    }
        
    const double D_motor = sqrt(2*KbT*dt/gamma_motor);
    const double D_fil = sqrt(2*KbT*dt/gamma_fil); 
    x1 = 0;
    x2 = 0;
    x1_2 = 0;
    x2_2 = 0;
    xm = 0;
    xm_2 = 0;
        
	for(long int i=0; i < N_timesteps; i++, t+=dt){
		
		double F1 = 0, F2 = 0;
		
		for(int j=0; j < N_heads; j++){
		    //Interaction with actin1 filament and left end of the motor
		    jump_time1[j] -= dt;
		    double head_x1 = motor_x - l_motor/2 + j*l_heads;
		    if(motor_bound1[j] == 0){
				F1 += c * F_actin(head_x1, actin1_x, a, Vmax);
		        if(jump_time1[j] < 0){
				    motor_bound1[j] = 1;
				    jump_time1[j] += exp_time(k_unbind);
				    q_out -= dE + (c-1) * V_actin(head_x1, actin1_x, a, Vmax);
				}
		    }
		    else{
		        F1 += F_actin(head_x1, actin1_x, a, Vmax);
		        if(jump_time1[j] < 0){
				    motor_bound1[j] = 0;
	                jump_time1[j] += exp_time(k_bind);
	                q_in += dE + (c-1) * V_actin(head_x1, actin1_x, a, Vmax);
	            }
	        }
		    //Interaction with actin2 filament and right end of the motor
		    jump_time2[j] -= dt;
		    double head_x2 = motor_x + l_motor/2 - j*l_heads;
		    if(motor_bound2[j] == 0){
				F2 += c * F_actin(head_x2, actin2_x, 1-a, Vmax);
		        if(jump_time2[j] < 0){
				    motor_bound2[j] = 1;
				    jump_time2[j] += exp_time(k_unbind);
				    q_out -= dE + (c-1) * V_actin(head_x2, actin2_x, 1-a, Vmax);
				}
		    }
		    else{
		        F2 += F_actin(head_x2, actin2_x, 1-a, Vmax);
		        if(jump_time2[j] < 0){
				    motor_bound2[j] = 0;
	                jump_time2[j] += exp_time(k_bind);
	                q_in += dE + (c-1) * V_actin(head_x2, actin2_x, 1-a, Vmax);
	            }
	        }
	    }
	        
	    motor_x += dt * (F1 + F2) / gamma_motor + D_motor * normal(rng);
	    actin1_x += dt * ( -F1 - k_spring * ( actin1_x - actin1_init ) ) / gamma_fil +  D_fil * normal(rng);
        actin2_x += dt * ( -F2 - k_spring * ( actin2_x - actin2_init ) ) / gamma_fil +  D_fil * normal(rng);
             
        if(i%printevery == 0){
            x1 += actin1_x - actin1_init;
            x2 += actin2_x - actin2_init;
            x1_2 += (actin1_x - actin1_init)*(actin1_x - actin1_init);
            x2_2 += (actin2_x - actin2_init)*(actin2_x - actin2_init);
            xm += motor_x;
            xm_2 += motor_x*motor_x;
        }
              
	}
	
	Q_in += q_in;
	Q_in2 += q_in*q_in;
	Q_out += q_out;
	Q_out2 += q_out*q_out;
	
    x1 /= (double)(N_timesteps/printevery);
    x2 /= (double)(N_timesteps/printevery);
    x1_2 /= (double)(N_timesteps/printevery);
    x2_2 /= (double)(N_timesteps/printevery);
    xm /= (double)(N_timesteps/printevery);
    xm_2 /= (double)(N_timesteps/printevery);
    
	return 1.;
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



