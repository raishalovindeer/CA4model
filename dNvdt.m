function Nvdot = dNvdt(t,Nv,data)
% Nvdot = dNvdt(t,Nv,data)

data.light_in = shift(t, data);

v = transform(Nv(4));

Irradiance = I(Nv,data);
[photons_absorbed,Ik3d] = Gam(Irradiance,data);
if Irradiance(125,2)>=Irradiance(100,2)
    alpha = data.alpha.green;
    phi = data.phigreen;
    pmax = data.pmax_g/(60*60*24);
else 
    alpha = data.alpha.blue;
    phi = data.phiblue;
    pmax = data.pmax_b/(60*60*24);
end

photons_absorbed = [photons_absorbed;v*Ik3d(1,:)+(1-v)*Ik3d(2,:)]; 
vintegral = trapz(data.z,Ik3d(1,:)-Ik3d(2,:),2);
vdot = vintegral*(phi*alpha/data.maxdepth);    

Nintegral = trapz(data.z,pmax*photons_absorbed./(pmax/phi+photons_absorbed),2);
Ndot = Nintegral.*Nv(1:3,:)/data.maxdepth-data.L*Nv(1:3,:);
Nvdot = [Ndot;vdot];

% plot(data.wavelengths,data.light_in)
% keyboard
end