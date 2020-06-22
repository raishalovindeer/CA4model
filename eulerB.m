function E = eulerB(Function,time,x0,Weight)
%E = eulerB(Function,time,x0,Weight)

dt = time(2)-time(1);
tolerance = 1E-4;
E = zeros(length(x0),length(time));
E(:,1) = x0;
x = x0;

for k = 2:length(time)
    G = @(x) x-dt*Function(time(k),x)-E(:,k-1);
    x = newton(G,E(:,k-1),tolerance,Weight);
    E(:,k) = x;
end
   
