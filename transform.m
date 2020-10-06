function y = transform(v)
% y = transform(v)
% limits dv/dt between 0 and 1
    
y = 0.5+0.5*(tanh(v));