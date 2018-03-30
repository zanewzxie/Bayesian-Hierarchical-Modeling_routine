# Fitting a single subject's recall errors using Variable Precision Model
# Zane Xie, 2018

data {
int<lower=0> trials; //number of trials
real <lower= -pi(),upper = pi()>  errors[trials];
real nvm;
}

parameters {
real<lower=0.01 upper = 100> alpha;
real<lower=0.01 upper = 100> beta;
}




model {
        //prior increment_log_prob(log_sum_exp((log(1-g) + von_mises_log(errors[i],0,kappa)), log(g)+log(1/)
        // no guessing, increment_log_prob(von_mises_log(errors[i],0,kappa)), verified

    //prior of the parameters
    vector[500] probs;
    real <lower = 0.001 upper =100> kappa[500];

    for(j in 1:500){
            kappa[j] ~ gamma(alpha,beta);
    }

    for(i in 1:trials){
        for(j in 1:500){
            probs[j] <- von_mises_log(errors[i],0,kappa[j])+log(1/nvm);
            }
        increment_log_prob(log_sum_exp(probs));
        }
}

