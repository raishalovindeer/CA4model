function Nvdot = dNvdt(Nv,data)
% Nvdot = dNvdt(Nv,data)

v = Nv(4);
Irradiance = I(Nv,data);
[photons_absorbed,Ik3d] = Gam(Irradiance,data);
if Irradiance(130)>=Irradiance(230)
    alpha = data.alpha.green;
    phi = data.phigreen;
    pmax = data.pmax_g/(60*60*24);
else 
    alpha = data.alpha.blue;
    phi = data.phiblue;
    pmax = data.pmax_b/(60*60*24);
end

photons_absorbed = [photons_absorbed;v*Ik3d(1,:)+(1-v)*Ik3d(2,:)]; 
vdot = trapz(data.z,Ik3d(1,:)-Ik3d(2,:),2)*(phi(3)*alpha/data.maxdepth);
if v>=0.99999999999999
    vdot = 0; 
elseif v<=0.000000000000
    vdot = 0; 
end
Ndot = trapz(data.z,pmax*photons_absorbed./(pmax./phi'+photons_absorbed),2).*Nv(1:3,:)/data.maxdepth-data.L*Nv(1:3,:);
Nvdot = [Ndot;vdot];
%keyboard
end