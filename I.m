function Irradiance = I(Nv,data)
% Irradiance = I(Nv,data)

v = transform(Nv(4));
fixedSyn = data.k(:,1:2);
pigment1 = data.k(:,3);
pigment2 = data.k(:,4);
flexSyn = (v * pigment1) + ((1-v) * pigment2);
background = data.k(:,5);
Achl = data.k(:,6);
Bchl = data.k(:,7);
if data.CHL >= 0.02
    CHL = (Achl.*(data.CHL.^-Bchl))*data.CHL;
elseif data.CHL<=0.02
    CHL = 0;
end

Coccos = data.Coccos*data.k(:,8);
depth = data.z;

Irradiance = data.light_in.*...
    exp(-(fixedSyn*Nv(1:2)+flexSyn*Nv(3)...
    +background+CHL+Coccos)*depth);
end