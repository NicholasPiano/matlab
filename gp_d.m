clear all, close all

% mean
meanfunc = {@meanSum, {@meanLinear, @meanConst}}; 
hyp.mean = [0.5; 1];

% covariance
covfunc = {@covProd, {@covSEiso, @covPeriodic}}; 
hyp.cov = [-0.5 0 0 2 0];

% lik
likfunc = @likGauss; 
hyp.lik = -1;

% data x,y
x = linspace(-5,5,100)';
mu = feval(meanfunc{:}, hyp.mean, x);
K = feval(covfunc{:}, hyp.cov, x) + 1e-6*eye(100);

y = chol(K)'*gpml_randn(0.354, 100, 1) + mu;
y1 = chol(K)'*gpml_randn(0.35, 100, 1) + mu;
y2 = chol(K)'*gpml_randn(0.31, 100, 1) + mu;
y3 = chol(K)'*gpml_randn(0.38, 100, 1) + mu;

% plot
figure; hold on;

a = plot(x, y, '-');
b = plot(x, y1, 'r-');
c = plot(x, y2, 'g-');
d = plot(x, y3, 'y-');

ma = 'seed=0.354';
mb = 'seed=0.35';
mc = 'seed=0.31';
md = 'seed=0.38';

legend(ma,mb,mc,md);
