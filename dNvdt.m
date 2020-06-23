function Nvdot = dNvdt(Nv,data)
% Nvdot = dNvdt(Nv,data)

v = Nv(4);
Irradiance = I(Nv,data);
[photons_absorbed,Ik3d] = Gam(Irradiance,data);
if Irradiance(150,2)>=Irradiance(100,2)
    alpha = data.alpha.green;
    phi = data.phigreen;
    pmax = data.pmax_g/(60*60*24);
else 
    alpha = data.alpha.blue;
    phi = data.phiblue;
    pmax = data.pmax_b/(60*60*24);
end

photons_absorbed = [photons_absorbed;v*Ik3d(1,:)+(1-v)*Ik3d(2,:)]; 
vintegral = simpsons(Ik3d(1,:)-Ik3d(2,:),...
                data.z(1),data.maxdepth,data.zsteps);
vdot = vintegral*(alpha*phi(3)/data.maxdepth);
    
if v>=0.99999999999999
    vdot = 0; 
elseif v<=0.000000000000
    vdot = 0; 
end

Nintegral = simpsons(pmax*photons_absorbed./(pmax./phi'+photons_absorbed),... ...
                data.z(1),data.maxdepth,data.zsteps);
Ndot = Nintegral*Nv(1:3,:)/data.maxdepth-data.L*Nv(1:3,:);
Nvdot = [Ndot;vdot];
%keyboard
end