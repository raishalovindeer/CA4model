%% Chromatic Acclimation Model
% Modified from Stomp et al 2008 by R. Lovindeer & F. Primeau
% For phytoplankton with 2 fixed & 1 flexible pigment phenotype

%% Initial Conditions
load('CA4MODELDATA')

%%% Control In-coming light spectra (0 for off, 1 for on)
data.Constant_LED = 0;
    data.LED = data.In.green;
    
data.LED_Oscillation = 1;
    data.Light1 = data.In.cyan;
    data.Light2 = data.In.green;
    data.frequency = 1;
    % frequency: 5=0.6d | 1=3d | 0.5=6d | 0.3=11d | 0.1=31d |
    % colors: blue, green, cyan, cyan_faux, white
    
data.Daylight = 0;                   

%%% Absorption parameters
data.CHL = 0;                       % valid from 0.02 - 25 mg m^-3
data.Coccos = 0;                    % mg m^-3

%%% Chromatic acclimation (CA4) parameters
v = 0.5;                 % Acclimation starting point
data.alpha.blue = 0.95;  % Controls acclimation time in blue light
data.alpha.green = 0.70; % Controls acclimation time in green light

%%% Initial abundance (cells/m^3) & v & light intensity
%%% [3a;3c;3d;v;l]
Nv0 = [1E6;1E6;1E6;v];

%%% Photosynthetic efficiency (cells/(umol photons))
data.phiblue = 1.2E6;
data.phigreen = 2.4E6;

%%% Maximum specific growth rate (/day)
data.pmax_b = 0.500;
data.pmax_g = 0.700;

%%% Loss rate (/hr)
data.L = 0.005/(60*60); % /second

%%% Changing absorption spectra to specific abs spectra
data.k(:,1:4) = data.k(:,1:4)*1E-12;

%%% Depth of water column (m)
data.maxdepth = 60;     

data.zsteps = 21;
data.z = linspace(0,data.maxdepth,data.zsteps);

%%% Time span of simulation
tspan = [0,60*60*24*10000]; % seconds

%% Model Simulation
% dNvdt.m calls functions I.m, Gam.m, shift.m, and transform.m

[T,Nv] = ode45(@(t,Nv) dNvdt(t,Nv,data),tspan,Nv0);

%% Model Output

N = Nv(:,1:3);          % Abundance (cells/m^3)
v = transform(Nv(:,4)); % Acclimation parameter
Td = T/(60*60*24);      % Run time converted to days

%%% Prints final abundance at equilibrium
N_Equilibrium = Nv(length(Nv),1:3)

%%% Plots abundance with time
figure(1)       
plot(Td,N,'LineWidth',10)
legend('3a strain','3c strain','3d strain','Location','best')
title('Synechococcus strain abundance')
xlabel('Time, days')
ylabel('Cell density, cells m^-3')