# Fitting a single subject's recall errors using StandardMixtureModel
# by zhang and luck, 2008; # this version no mu!, mu = 0
# Zane Xie, 2018

data {
int<lower=0> trials; //number of trials
real <lower= -pi(),upper = pi()>  errors[trials];
}

parameters {
real<lower=0.001, upper = 130> kappa;
real<lower=0, upper=1> pm;
}

model {
        //prior increment_log_prob(log_sum_exp((log(1-g) + von_mises_log(errors[i],0,kappa)), log(g)+log(1/)
        // no guessing, increment_log_prob(von_mises_log(errors[i],0,kappa)), verified

    //prior of the parameters
    pm ~ uniform(0,1);
    kappa ~ gamma(5,1);

    for(i in 1:trials){

          increment_log_prob(log_sum_exp(log(pm)+von_mises_log(errors[i],0,kappa),log((1-pm)/(2*pi()))));
}
}

