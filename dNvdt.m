function Nvdot = dNvdt(t,Nv,data)
% Nvdot = dNvdt(t,Nv,data)

if data.Constant_LED == 1;
    data.light_in = data.LED;
elseif data.LED_Oscillation == 1;
    data.light_in = shift(t, data);    
    else data.light_in = data.In.daylight;
end

v = transform(Nv(4));

Irradiance = I(Nv,data);
[Ik3ac,Ik3d] = Gam(Irradiance,data);
if Irradiance(125,2)>=Irradiance(100,2)
    alpha = data.alpha.green;
    phi = data.phigreen;
    pmax = data.pmax_g/(60*60*24);
else 
    alpha = data.alpha.blue;
    phi = data.phiblue;
    pmax = data.pmax_b/(60*60*24);
end

photons_absorbed = [Ik3ac;v*Ik3d(1,:)+(1-v)*Ik3d(2,:)]; 
vintegral = trapz(data.z,Ik3d(1,:)-Ik3d(2,:),2);
vdot = vintegral*(phi*alpha/data.maxdepth);    

Nintegral = trapz(data.z,pmax*photons_absorbed./(pmax/phi+photons_absorbed),2);
Ndot = ((Nintegral/data.maxdepth).*Nv(1:3,:))-data.L*Nv(1:3,:);

Nvdot = [Ndot;vdot];
end