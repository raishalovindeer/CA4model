function J = jac(Function,x)
%J = jac(F,x)

F0 = Function(x);
n = length(F0);
m = length(x);
h = i*eye(m)*eps^3; % from the derivative definition
J = zeros(n,m);
for k = 1:m
    J(:,k) = imag(Function(x+h(:,k)))/eps^3;
end



    