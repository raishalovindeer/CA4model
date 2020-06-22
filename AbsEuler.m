function Absorbance = AbsEuler(Nv,data)
% x = A(Nv,data)
% Converts N in cells per cm^3 to total light absorption per cm

Ngp = Nv(1,:);
Nrp = Nv(2,:);
Nfp = Nv(3,:);
v = Nv(4,:);
Incoming_light = data.In.green; %<- UPDATE FOR COLOR
zm = data.zm;
kgp = data.k.gp;
krp = data.k.rp;
kpe = data.k.pe;
kpc = data.k.pc;
kchl = data.k.chl;
wavelength_steps = 1;
Absorbance = zeros(length(Nv),1);

for i = 1:length(Nv)
kfp = v(i)*kpe+(1-v(i))*kpc+kchl;
Absorbance(i,1) = log(sum(Incoming_light*wavelength_steps)/(wavelength_steps*Incoming_light.'*exp(-kgp*Ngp(i)*zm)))/zm;
Absorbance(i,2) = log(sum(Incoming_light*wavelength_steps)/(wavelength_steps*Incoming_light.'*exp(-krp*Nrp(i)*zm)))/zm;
Absorbance(i,3) = log(sum(Incoming_light*wavelength_steps)/(wavelength_steps*Incoming_light.'*exp(-kfp*Nfp(i)*zm)))/zm;
end
end

