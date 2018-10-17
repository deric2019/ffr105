clear all;
restoredefaultpath;
addpath('helpers', 'TSPGraphics');

debug = false;

cityLocations = LoadCityLocations();

numberOfCities = size(cityLocations, 1);

startCity = RandomIndex(numberOfCities);
nearestNeighbourPath = GetNearestNeighbourPath(startCity, cityLocations);
nearestNeighbourPathLength = GetPathLength(nearestNeighbourPath, cityLocations);

fprintf('Nearest neighbour path length = %.2f (starting in city %d)\n', nearestNeighbourPathLength, startCity);

if debug == true
    tspFigure = InitializeTspPlot(cityLocations, [0 20 0 20]); 
    connections = InitializeConnections(cityLocations);
    PlotPath(connections, cityLocations, nearestNeighbourPath);
end
