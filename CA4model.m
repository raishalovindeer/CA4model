% Chromatic Acclimation Model
% Modified from Stomp et al 2008 by R. Lovindeer & F. Primeau
% For phytoplankton with 2 fixed & 1 flexible phenotype

%% Description of Constants & Variables
% L, loss rate (/h)
% zm, water column depth (m)
% pmax, species max specific growth rate (/d)
% phi, photosynthetic efficiency (cells/umol)
% alpha, acclimation parameter to a color (dimensionless)

%% Initial & Calculated Values
load('CA4MODEL_8020.mat')

% data.light_in = data.In.daylight*10;   % W/m2
% data.light_in = data.In.blue;
v = 0.5;    % starting at white light
Nv0 = [1E6;1E6;1E6;v];  % [3a;3c;3d;v] in cells/m^3 (1000L)
data.A = 1; % (5=0.6d, 1=3d, 0.5=6d,| 0.3=11d, 0.1=31d, 0.01=313d) freq.
data.alpha.green = 0.007;
data.alpha.blue = 0.095;
data.phiblue = 1.3E6;
data.phigreen = 3.0E6;
% data.k(:,1:4) = data.k(:,1:4)*1E5;
data.k(:,1:4) = data.k(:,1:4)*1E-14;
data.CHL = 0;    % from 0.02 - 25 mg m^-3
data.Coccos = 0; % mg m^-3
data.zsteps = 21;
data.maxdepth = 50;
data.L = 0.005/(60*60); % /s
data.z = linspace(0,data.maxdepth,data.zsteps);
tspan = [0,60*60*24*1000]; % seconds

[T,Nv] = ode45(@(t,Nv) dNvdt(t,Nv,data),tspan,Nv0);

N = Nv(:,1:3);
v = tanh(Nv(:,4));
Td = T/(60*60*24);   % converted to days
% Ot = sin(data.A*Td); % blue oscillation 

light_out = (exp(-( ...
    Nv(:,1:2)*data.k(:,1:2)' ...
    +Nv(:,3).*(v*data.k(:,3)'+(1-v)*data.k(:,4)') ...
    +ones(size(v))*data.k(:,5)' ...
    )*data.maxdepth))*data.light_in;

writematrix(Td)
writematrix(Nv)
writematrix(light_out)
% writematrix(Ot)

figure(1)
plot(Td,N,'LineWidth',3)
legend('3a strain','3c strain','3d strain','Location','best')
title('Continuous light')
xlabel('Time, days')
ylabel('Cell density, cells m^-3')

figure(2)
plot(Td,light_out,'LineWidth',3)
title('Light exiting the system')
ylabel('umol photons m^-2 s^-1')

figure(3)
plot(Td,v,'LineWidth',3)
title('v - Chromatic acclimation parameter')
% 
% figure(4)
% plot(Td,Ot)
% title('blue light oscillation frequency')