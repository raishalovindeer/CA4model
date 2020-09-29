%% Chromatic Acclimation Model
% Modified from Stomp et al 2008 by R. Lovindeer & F. Primeau
% For phytoplankton with 2 fixed & 1 flexible pigment phenotype

%% Initial Values
load('CA4MODELDATA.mat')

%%% Control In-coming light spectra
%%% Constant LED light
data.light_in = data.In.blue;           % Constant LED

%%% Constant Daylight with absorption parameters
% data.light_in = data.In.daylight;     % Daylight, W/m2 conv. to mol/m2/s
data.CHL = 0;                           % from 0.02 - 25 mg m^-3
data.Coccos = 0;                        % mg m^-3

%%% For Time-dependent oscillating light function
%%% Turn on oscillating light in dNvdt.m 
%%% Set frequency of ocillations, A below
%%% | 5=0.6d | 1=3d | 0.5=6d | 0.3=11d | 0.1=31d |
% data.A = 0.3; 

%%% Acclimation parameters
v = 0.5;                    % Acclimation starting point
data.alpha.blue = 0.000065; % Controls acclimation time in blue light
data.alpha.green = 0.00005; % Controls acclimation time in green light

%%% Initial abundance (cells/m^3) & initial v
%%% [3a;3c;3d;v]
Nv0 = [1E6;1E6;1E6;v];

%%% Photosynthetic efficiency (cells/umol photons)
data.phiblue = 1.2E11;
data.phigreen = 2.5E11;

%%% Maximum specific growth rate (/day)
data.pmax_g = 0.700;
data.pmax_b = 0.500;

%%% Loss rate (/day) 
data.L = 0.4/(24*60*60); % /second

%%% Changing absorption spectra to specific abs spectra
data.k(:,1:4) = data.k(:,1:4)*1E-14;

%%% Depth of the mixed layer / water column (m)
data.maxdepth = 20;     

data.zsteps = 21;
data.z = linspace(0,data.maxdepth,data.zsteps);

%%% Time span of the model run
tspan = [0,60*60*24*5000]; % seconds

%% Model Run

[T,Nv] = ode45(@(t,Nv) dNvdt(t,Nv,data),tspan,Nv0);

%%% Model output
N = Nv(:,1:3);          % Abundance (cells/m^3)
v = transform(Nv(:,4)); % Acclimation parameter
Td = T/(60*60*24);      % Run time converted to days
% Ot = sin(data.A*Td);    % Oscillation time, when application    

%%% Calculation of light exiting the system
light_out = (exp(-( ...
    Nv(:,1:2)*data.k(:,1:2)' ...
    +Nv(:,3).*(v*data.k(:,3)'+(1-v)*data.k(:,4)') ...
    +ones(size(v))*data.k(:,5)' ...
    )*data.maxdepth))*data.light_in;

%%% Print final abundance at equilibrium
Nv(length(Nv),1:3)  

%%% Save matrix files after each run
writematrix(Td)
writematrix(Nv)
writematrix(light_out)
% writematrix(Ot)

%%% Plot figures
figure(1)       % Abundance over time
plot(Td,N,'LineWidth',3)
legend('3a strain','3c strain','3d strain','Location','best')
title('Continuous light')
xlabel('Time, days')
ylabel('Cell density, cells m^-3')

figure(2)       % Light exiting the system
plot(Td,light_out,'LineWidth',3)
title('Light exiting the system')
ylabel('umol photons m^-2 s^-1')

figure(3)       % Acclimation over time
plot(Td,v,'LineWidth',3)
title('v - Chromatic acclimation parameter')

% figure(4)     % Light oscillations
% plot(Td,Ot)
% title('blue light oscillation frequency')