#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>
#include <time.h>
#include <iostream>
#include <fstream>
#include <boost/random.hpp>


const double KbT = 4.278;

const double dt = 0.01;
const long int N_timesteps = 1e6;
const int N_printevery = 1e1;
const int N_out = N_timesteps / N_printevery;

const int N = 1e2; /*Number of copies in ensemble to average over*/

const double l = 8.;

const int N_heads = 1;
const double l_heads = 15.;

const double a = 0.25;
const int N_a = 1;

const double dE = 30.4;
const double V = 40;
const int N_V = 1;

const double c = 0.3;
const int N_c = 1;
          
const double F = 0.;

const double k_bind = 4e-5; 
const double k_unbind = 8e-5;
const int N_k = 1;
      
const double gamma_fil = 0.97;
const double gamma_motor = 0.66;

boost::random::mt19937 rng;   
boost::random::uniform_real_distribution<> uniform;
boost::random::normal_distribution<> normal;

double F_actin(const double motor_x, const double actin_x, const double a, const double Vmax);
double exp_time(double k);
double speed_sim(const double F_stall, const double a, const double Vmax, double c, double k_unbind, double &Q_in, double &Q_out, std::vector< std::vector<double> > &times, std::vector<double> &x, std::vector< std::vector<int> > &s);
double V_actin(const double motor_x, const double actin_x, const double a, const double Vmax);
double create_protocol(std::vector< std::vector<double> > &times);

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
//    	double F = 0;
	printf("#t	xm-xa	states\n");
        for(int i = 0; i < N_a; i++){
//                double a = a_min + (a_max-a_min)*i/double(N_a-1);
                for(int j = 0; j < N_k; j++){                        
//                        double c = c_min + (c_max - c_min)*j/double(N_c-1);
				    double Q_in, Q_out;
				    std::vector< std::vector<double> > times(N_heads, std::vector<double>());
				    create_protocol(times);
				    std::vector< std::vector<int> > s(N_heads, std::vector<int>(N_out));
				    std::vector<double> x(N_out);
				    for(int i=0; i < N_out; i++)
				        x[i] = 0;
				    for(int k=0; k<N; k++){
		                speed_sim(F, a, V, c, k_unbind, Q_in, Q_out, times, x, s);
			        }
			        
				    for(int i=0; i < N_out; i++){
				        x[i] /= N;
				        printf("%lf\t%lf\t%d\t%d\t%d\t%d\n", i*dt*N_printevery, x[i], s[0][i], s[1][i], s[2][i], s[3][i]);
				    }
	            }
        }
        
   	
	    end = clock();
	    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
	    printf("#a = %lf V = %lf #N_heads = %d	N = %d     time = %lf\n", a, V, N_heads, N, dt*N_timesteps);
	    printf("#CPU_time = %f\n", cpu_time_used);

        return 1;        
}



double create_protocol(std::vector< std::vector<double> > &times){

	int state[4] = {1, 0, 1, 0};
	
	for(int i=0; i<N_heads;i++)
	{
	    double t = 0.;
	    while( t < (double)N_timesteps*dt )
	    {
	        t += ( state[i] ? exp_time(k_unbind) : exp_time(k_bind) );
	        state[i] = 1 - state[i];
	        times[i].push_back(t);
	    }
	}
	
	return 1.;
}


double speed_sim(const double F_stall, const double a, const double Vmax, const double c, double k_unbind, double &Q_in, double &Q_out, std::vector< std::vector<double> > &times, std::vector<double> &x, std::vector< std::vector<int> > &s){

	double t = 0.;
	
	double motor_x = 4.;
	double actin_x = 0.;
	double q_in = 0, q_out = 0;
	
	int motor_bound[4] = {1, 0, 1, 0};
        
    const double D_motor = sqrt(2*KbT*dt/gamma_motor);
    const double D_fil = sqrt(2*KbT*dt/gamma_fil); 
    
    
    int count[4] = {0, 0, 0, 0};
	for(long int i=0; i < N_timesteps; i++, t+=dt){
		double F = 0;
		for(int j=0; j < N_heads; j++){
		    double head_x = motor_x - j*l_heads;
		    if(motor_bound[j] == 0){
				F += c * F_actin(head_x, actin_x, a, Vmax);
		        if(times[j][count[j]] < t){
				    motor_bound[j] = 1;
				    count[j]++;
 				    q_out -= dE + (c-1) * V_actin(head_x, actin_x, a, Vmax);
                }
		    }
		    else{
		        F += F_actin(head_x, actin_x, a, Vmax);
		        if(times[j][count[j]] < t){
				    motor_bound[j] = 0;
	                count[j]++;
				    q_in += dE + (c-1) * V_actin(head_x, actin_x, a, Vmax);
                    }
	           }
	    }
	        
	    motor_x += dt * (F - F_stall) / gamma_motor + D_motor * normal(rng);
	    actin_x += -dt * F / gamma_fil +  D_fil * normal(rng);
        
            
        if( i%N_printevery == 0){// && i > N_timesteps/2)
		    int time = i/N_printevery;
		    x[time] += motor_x - actin_x - l*floor((motor_x - actin_x)/l);
		    for(int j=0; j < N_heads; j++)
		        s[j][time] = motor_bound[j];		    
		}
	}
	
//	Q_in += q_in;
//	Q_out += q_out;

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



