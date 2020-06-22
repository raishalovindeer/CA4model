function Irradiance = I(Nv,data)
% Irradiance = I(Nv,data)

v = Nv(4);
fixedSyn = data.k(:,1:2);
pigment1 = data.k(:,3);
pigment2 = data.k(:,4);
flexSyn = (v * pigment1) + ((1-v) * pigment2);
background = data.k(:,5);
Achl = data.k(:,6);
Bchl = data.k(:,7);
CHL = Achl.*(data.CHL.^-Bchl);
depth = data.z;

Irradiance = data.light_in.*exp(-(fixedSyn*Nv(1:2)+flexSyn*Nv(3)+background+CHL)*depth);
end