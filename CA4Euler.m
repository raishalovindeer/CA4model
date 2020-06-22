% Chromatic Acclimation Model
% Modified from Stomp et al 2008 by R. Lovindeer & F. Primeau

%% Description of Constants & Variables
% L, loss rate (/h)
% zm, water column depth (cm)
% pmax, species max specific growth rate (/h)
% phi, photosynthetic efficiency (cells/umol)
% alpha_color, acclimation parameter to a color (dimensionless)
% Kbg (/cm) = (log(In.white)-log(Out.white))/3; % (/cm)

%% Initial & Calculated Values
load('CA4MODEL.mat')

v = 0.5; %<- UPDATE to start at opposite color, 0.01 green, 0.90 red
Nv0 = [10E6;10E6;10E6;v]; %population density cells/cm^3 of G, R & flex pico, v
nz = 6;
Weight = diag([10E6,10E6,10E6,1]);

data.L = data.L/(60*60);         %converted to /s
data.pmax = pmax/(60*60);   %converted to /s

z = linspace(0,zm,nz);
data.z = z;

days = 50; % length of model run
time_span = 60*60*24*days;
number_of_steps = 24*60*days;

time = linspace(0,time_span,number_of_steps); 
[Nv] = eulerB(@(time,Nv) dNvdt(time,Nv,data),time,Nv0,Weight);

Plankton_density = Nv(1:3,:); 
Chromatic_acclimation_parameter = Nv(4,:);
Time_in_days = time/(60*60*24);

Absorbance = AbsEuler(Nv,data); %per cm

figure(1)
plot(Time_in_days,Plankton_density,'LineWidth',3)
legend('green pico','red pico','flexible pico')
title('Continuous green light')
xlabel('Time, days')
ylabel('Cell density, cells cm^-3')

figure(2) 
plot(Time_in_days,Absorbance,'LineWidth',3)
legend('green pico','red pico','flexible pico')
title('Continuous green light')
xlabel('Time, days')
ylabel('Total light absorption per cm')

figure(3)
plot(Time_in_days,Chromatic_acclimation_parameter,'LineWidth',3)
title('v - chromatic acclimation parameter')
