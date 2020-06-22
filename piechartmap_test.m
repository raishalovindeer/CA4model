%Plotting the TARA dataset of CA4 strains

load TARAdata.mat
% load Martinydata.mat
% Martiny = ones(size(LatLon))*10;

Lat = data.TARASyn(:,3);
Lon = data.TARASyn(:,4);
PT3a = data.TARASyn(:,5);
PT3c = data.TARASyn(:,6);
PT3dA =data.TARASyn(:,7);
PT3dB = data.TARASyn(:,8);
PT3f = data.TARASyn(:,9);
Fixed = PT3a + PT3c + PT3f;
Flexible = PT3dA + PT3dB;
Total = Fixed + Flexible;

%Scale data so you can see circles on map.
maxCircleSize = 2000;
Specialists = maxCircleSize * Fixed/max(Total);
Generalists = maxCircleSize * Flexible/max(Total);
Points = maxCircleSize * Martiny(:,1)/max(Total);
for i = 1:length(Total)
    if Specialists(i,1) == 0;
        Specialists(i,1) = NaN;
    end
end
for i = 1:length(Total)
    if Generalists(i,1) == 0;
        Generalists(i,1) = NaN;
    end
end

%Make map with circle size proportional to Total.
load coastlines
LatLim = [min(LatLon(:,1))-10 max(LatLon(:,1))+10];
LonLim = [min(LatLon(:,2))-10 max(LatLon(:,2))+10];
tiledlayout(2,1)
nexttile
worldmap(LatLim, LonLim)
coast = plotm(coastlat, coastlon, 'k', 'LineWidth',1.5);
scatterm(Lat, Lon, Specialists,'MarkerEdgeColor', '#D95319','LineWidth',1.5)
% hold
% scatterm(LatLon(:,1), LatLon(:,2), Points, 'MarkerEdgeColor', 'blue','LineWidth',1.5)
% 'MarkerFaceColor', '#D95319','MarkerEdgeColor', 'none')
xlabel("Specialists")
nexttile
worldmap(LatLim, LonLim)
coast = plotm(coastlat, coastlon, 'k', 'LineWidth',1.5);
scatterm(Lat, Lon, Generalists,'MarkerEdgeColor','#EDB120','LineWidth',1.5)
xlabel("Generalists")

% X = [1 3 0.5 2.5 2];
% p=pie(X);
% p(1).Vertices
% sc = 0.001; % <scaling factor (different for each city) 
% % Loop through each slice of the pie: 
% for k = 1:2:length(p)
%      % x,y coordinates of a slice: 
%      tmp = p(k).Vertices; 
%      % Scale the size of the slice: 
%      tmp = tmp*sc; 
%      [x0,y0] = mfwdtran(lat,lon); % <geocoordinates of the city
%      % Place the center of the pie on its city: 
%      tmp(:,1) = tmp(:,1)+x0; 
%      tmp(:,2) = tmp(:,2)+x0; 
%      patch(tmp(:,1),tmp(:,2),'b') % <-specify the color you want
%   end