function y = transform(v)
% y = transform(v)
% transform dv/dt from -inf to inf and then take the tangent of this funct
    
y = 0.5+0.5*(tanh(v));