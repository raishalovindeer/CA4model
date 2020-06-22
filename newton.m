function x = newton(Function,x,tolerance,Weight)
%N = newton(F,x,tol,W)

maxit = 500;
F0 = Function(x);
i=1;
while F0.'*F0>tolerance
    J = jac(Function,x);
    dx = -J\F0;
    x = x + dx;
    F0 = Function(x);
    
    i = i+1;
    if i>maxit
        fprintf('|F0| = %e\n',F0.'*F0) % prints norm of F0
        fprintf('(%e,%e,%e,%e)\n',x)
        keyboard
    end
end

