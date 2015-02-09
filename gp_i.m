load('mauna.mat');

% parameters
meanfunc = {@meanSum, {@meanLinear, @meanConst}}; 
hyp.mean = [0;0];
likfunc = @likGauss;
hyp.lik = 0;

% define cov func
cov1 = @covSEiso;
cov2 = {@covProd, {@covSEiso, @covPeriodic}};
cov3 = @covRQiso;
cov4 = {@covSum, {@covSEiso, @covNoise}};

covfunc = {@covSum, {cov1, cov2, cov3, cov4}};
hyp.cov = 0.1*randn(13 ,1);

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