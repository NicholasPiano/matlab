load('mauna.mat');

% parameters
meanfunc = {@meanSum, {@meanLinear, @meanConst}}; 
hyp.mean = [0;0];
likfunc = @likGauss;
hyp.lik = 0;
covfunc = @covSEiso;
hyp.cov = [-2 0];

% minimize
hyp = minimize(hyp, @gp, -100, @infExact, meanfunc, covfunc, likfunc, trainyear, trainCO2);

year = cat(1, trainyear, testyear);

% test
gp(hyp, @infExact, meanfunc, covfunc, likfunc, testyear, testCO2)
[m s] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, testyear, testCO2, testyear);

% plot output
f = [m+2*sqrt(s); flipdim(m-2*sqrt(s),1)];
fill([testyear; flipdim(testyear,1)], f, [7 7 7]/8); hold on;

% plot data
plot([2004],[390], testyear, testCO2);