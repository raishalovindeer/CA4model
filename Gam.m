function [x,y] = Gam(Irradiance,data)
% [x,y] = Gam(Irradiance,data)
%number of photons absorption by picos

integrals = data.k(:,1:4)'*Irradiance;
x = integrals(1:2,:); % fixed Syn
y = integrals(3:4,:); % components of flex Syn
end