clear all, close all

load('cw1e.mat');

meanfunc = @meanConst; 
hyp.mean = 0;
covfunc = @covSEiso; 
ell = 1.0; 
sf = 1.0; 
hyp.cov = log([ell sf]);
likfunc = @likGauss;
hyp.lik = 0;

hyp = minimize(hyp, @gp, -40, @infEP, meanfunc, covfunc, likfunc, x, y);

% test data with a different grid size to original x
[t1 t2] = meshgrid(min(x(:,2)):0.1:max(x(:,2)),min(x(:,1)):0.1:max(x(:,1)));
t = [t1(:) t2(:)];

nlml = gp(hyp, @infEP, meanfunc, covfunc, likfunc, x, y)
[m s] = gp(hyp, @infEP, meanfunc, covfunc, likfunc, x, y, t);

% surface plot from x,y
surf(reshape(x(:,1),11,11),reshape(x(:,2),11,11),reshape(y,11,11)); hold on;

% two mesh plots of mean +/- std
m_plus = m + 2*sqrt(s);
m_minus = m - 2*sqrt(s);
a = size(t);
a = sqrt(a(1));
mesh(reshape(t(:,1),a,a),reshape(t(:,2),a,a),reshape(m_plus,a,a)); hold on;
mesh(reshape(t(:,1),a,a),reshape(t(:,2),a,a),reshape(m_minus,a,a));
alpha(0.5);