# Fitting multiple subjects' 'recall errors across different conditionsusing StandardMixtureModel
# by zhang and luck, 2008; # this version no mu!, mu = 0
# Zane Xie, 2018

data {
int<lower=1> trials; // number of trials
int<lower=1> nsub; //number of subjects for each conditions
real<lower= -pi(),upper = pi()>  errors[trials,nsub];
}


parameters {

real<lower=0.001> kappa[nsub];
real<lower=0, upper=1> pm[nsub];

real<lower=0.001> mukappa;
real<lower=0, upper=1> mupm;
real<lower=0.001> sdkappa;
real<lower=0.001> sdpm;

}

model {

    //optimal pm and kappa for each subject under each condition
        for (isub in 1:nsub){
            pm[isub] ~ normal(mupm, sdpm);
            kappa[isub] ~ normal(mukappa, sdkappa);
            }

    // trial data for all subjects across conditions
        for (isub in 1:nsub){
            for(i in 1:trials){
                increment_log_prob(log_sum_exp(log(pm[isub])+von_mises_log(errors[i,isub],0,kappa[isub]),log((1-pm[isub])/(2*pi()))));
            }
        }
}
