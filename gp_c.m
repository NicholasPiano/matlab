clear all, close all

% mean function and hyp
meanfunc = {@meanSum, {@meanLinear, @meanConst}}; 
hyp.mean = [0;0];

% likelihood function
likfunc = @likGauss;

% data x,y
load('cw1d.mat');

% test x
z = linspace(min(x)-1, max(x)+1, 200)';

% covariance function and hyp
covfunc = @covPeriodic;
hyp.cov = [-1 1 0];
hyp.lik = 0;

% minimize hyp.cov
hyp = minimize(hyp, @gp, -100, @infExact, meanfunc, covfunc, likfunc, x, y);

% run gaussian process
[m s] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y, z); % [mean_list std_list]

% plot
f = [m+2*sqrt(s); flipdim(m-2*sqrt(s),1)]; % extent based on std.
fill([z; flipdim(z,1)], f, [7 7 7]/8)
hold on; 

plot(z, m, 'b-');
hold on;

plot(x, y, 'g+');