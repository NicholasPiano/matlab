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
covfunc = @covSEiso;
hyp.cov = [-1 0];
hyp.lik = 0;

% minimize hyp.cov
hyp
hyp2 = minimize(hyp, @gp, -100, @infExact, meanfunc, covfunc, likfunc, x, y);
hyp2

% run gaussian process
[m2 s2] = gp(hyp2, @infExact, meanfunc, covfunc, likfunc, x, y, z); % [mean_list std_list]

% plot
f2 = [m2+2*sqrt(s2); flipdim(m2-2*sqrt(s2),1)]; % extent based on std.
m2
s2
size(f2)
size(z)
fill([z; flipdim(z,1)], f2, [7 7 7]/16)
hold on;

plot(z, m2);
hold on;

plot(x, y, 'g+');