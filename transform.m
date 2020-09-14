function y = transform(v)
% y = transform(v)
% transform dv/dt from -inf to inf and then take the tangent of this funct
    
if v < 0
        v = v*-inf;
else if v> 0
        v = v*inf;
    end

y = 0.5+0.5*(tanh(v));