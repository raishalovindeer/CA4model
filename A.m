function Absorbance = A(Nv,data)
% x = A(Nv,data)
% Converts N in cells per cm^3 to total light absorption per cm

N1 = Nv(:,1);
N2 = Nv(:,2);
N3 = Nv(:,3);
v = Nv(:,4);
wavelength_steps = 1;
Absorbance = zeros(length(Nv),1);

for i = 1:length(Nv)
kfp = v(i)*data.k(:,3)+(1-v(i))*data.k(:,4)+data.k(:,5);
Absorbance(i,1) = log(sum(data.light_in*wavelength_steps)/(wavelength_steps*data.light_in.'*exp(-data.k(:,1)*N1(i)*data.zm)))/data.zm;
Absorbance(i,2) = log(sum(data.light_in*wavelength_steps)/(wavelength_steps*data.light_in.'*exp(-data.k(:,2)*N2(i)*data.zm)))/data.zm;
Absorbance(i,3) = log(sum(data.light_in*wavelength_steps)/(wavelength_steps*data.light_in.'*exp(-kfp*N3(i)*data.zm)))/data.zm;
end

