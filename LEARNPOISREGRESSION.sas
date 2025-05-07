*simulate the data according to a mathematical model
in real life, we wouldnt know this, as the point of modeling is finding out;
*however, simulating is nice when practicing, because you can check your results;
data df;
    do x = 0 to 100 by 0.25;  
        rate = exp(-2 + 0.06 * x);
        y = rand("Poisson", rate);
        output;
    end;
run;

*plot the data;
proc sgplot data=df;
    scatter x=x y=y;
run;

* poisson linear model;
proc glimmix data=df;
    model y(event='1') = x / dist=poisson link=log solution;
    estimate "begining" int 1 x 1 / ilink; * make an estimate at 2;
    estimate "middle" int 1 x 50 / ilink; * make an estimate at 50;
    estimate "end" int 1 x 99 / ilink; *...add as many as you like!;
run;


* gaussian linear model; 
proc glimmix data=df;
    model y(event='1') = x / solution;
    estimate "begining" int 1 x 1 / ilink; * make an estimate at 2;
    estimate "middle" int 1 x 50 / ilink; * make an estimate at 50;
    estimate "end" int 1 x 99 / ilink; *...add as many as you like!;
run;
