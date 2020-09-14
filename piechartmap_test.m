%Plotting dataset of CA4 strains

load Allcruises_0828.mat
% load Martinydata.mat
% Martiny = ones(size(LatLon))*10;

data = AllCruises;

Lat = data(:,1);
Lon = data(:,2);
PT3a = data(:,3);
PT3c = data(:,4);
PT3dA =data(:,5);
PT3dB = data(:,6);
PT3f = data(:,7);
Fixed = PT3a + PT3c + PT3f;
Flexible = PT3dA + PT3dB;
Total = Fixed + Flexible;

%Scale data so you can see circles on map.
maxCircleSize = 100;
% Specialists = maxCircleSize * Fixed/max(Total);
Specialists = maxCircleSize * Fixed./Total;
Generalists = maxCircleSize * Flexible./Total;
% Points = maxCircleSize * Martiny(:,1)/max(Total);
for i = 1:length(Total)
    if Specialists(i,1) <= 0;
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
LatLim = [min(Lat)-10 max(Lat)+10];
LonLim = [min(Lon)-10 max(Lon)+10];
% tiledlayout(2,1)
% nexttile
worldmap(LatLim, LonLim)
coast = plotm(coastlat, coastlon, 'k', 'LineWidth',1);
S1 = scatterm(Lat, Lon, Specialists,'MarkerEdgeColor', '#D95319','LineWidth',1.5);
hold
% % scatterm(Lat, Lon, Points, 'MarkerEdgeColor', 'blue','LineWidth',1.5)
% % 'MarkerFaceColor', '#D95319','MarkerEdgeColor', 'none')
% % nexttile
% % worldmap(LatLim, LonLim)
% % coast = plotm(coastlat, coastlon, 'k', 'LineWidth',1);
S2 = scatterm(Lat, Lon, Generalists,'MarkerEdgeColor','#EDB120','LineWidth',1.5);
legend([S1,S2],'% Specialists','% Generalists','Location','southeast',...
    'Orientation','horizontal','FontSize',14)