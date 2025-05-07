*simulate the data according to a mathematical model
in real life, we wouldnt know this, as the point of modeling is finding out;
*however, simulating is nice when practicing, because you can check your results;
data df;
data df;
    do x = 0 to 50 by 0.025;  
        p = 1 / (1 + exp(-(-25 + 1 * x)));
        y = rand("Bernoulli", p);
        output;
    end;
run;

*plot the data;
proc sgplot data=df;
    scatter x=x y=y;
run;

*make a logistic regression model;
proc glimmix data=df;
    model y(event='1') = x / dist=binomial link=logit solution;
    estimate "middle" int 1 x 25 / ilink; *make an estimate at x=25;
    estimate "beginning" int 1 x 1 / ilink; *make an estimate at x=1;
    estimate "end" int 1 x 49 / ilink; *... add as many as you like!;
run;

*make a gaussian linear model;
proc glimmix data=df;
    model y(event='1') = x / solution;
    estimate "middle" int 1 x 25 / ilink; *make an estimate at x=25;
    estimate "beginning" int 1 x 1 / ilink; *make an estimate at x=1;
    estimate "end" int 1 x 49 / ilink; *... add as many as you like!;
run;
