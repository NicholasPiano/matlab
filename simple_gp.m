clear all, close all
 
meanfunc = {@meanSum, {@meanLinear, @meanConst}}; 
hyp.mean = [0;0];
likfunc = @likGauss;
load('cw1d.mat');

z = linspace(min(x)-1, max(x)+1, 200)';

covfunc = {@covProd, {@covPeriodic, @covSEiso}};
hyp.cov = [-0.5 0 0 2 0];
hyp.lik = 0;
hyp = minimize(hyp, @gp, -100, @infExact, meanfunc, covfunc, likfunc, x, y);
[m s2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y, z);

f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];

fill([z; flipdim(z,1)], f, [7 7 7]/8)
hold on; plot(z, m); plot(x, y, '+');