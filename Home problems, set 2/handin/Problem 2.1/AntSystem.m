clear all;
restoredefaultpath;
addpath('ACO', 'helpers', 'TSPGraphics');

% Import data
cityLocations = LoadCityLocations();
numberOfCities = length(cityLocations);

% Define parameters
numberOfAnts = numberOfCities;
alpha = 1.0;
beta = 2.0;
rho = 0.5;

nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocations);
tau0 = numberOfAnts / nearestNeighbourPathLength;

targetPathLength = 123.0;

% Initialization
range = [0 20 0 20];
tspFigure = InitializeTspPlot(cityLocations, range);
connection = InitializeConnections(cityLocations);
pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0);
visibility = GetVisibility(cityLocations);

% Main loop
minimumPathLength = inf;
bestPath = [];

iIteration = 0;

while (minimumPathLength > targetPathLength)
 iIteration = iIteration + 1;

 % Generate paths
 pathCollection = [];
 pathLengthCollection = [];
 for k = 1:numberOfAnts
  path = GeneratePath(pheromoneLevel, visibility, alpha, beta);
  pathLength = GetPathLength(path,cityLocations);
  if (pathLength < minimumPathLength)
    minimumPathLength = pathLength;
    bestPath = path;
    disp(sprintf('Iteration %d, ant %d: path length = %.5f',iIteration,k,minimumPathLength));
    PlotPath(connection,cityLocations,path);
  end
  pathCollection = [pathCollection; path];           
  pathLengthCollection = [pathLengthCollection; pathLength];
 end

 % Update pheromone levels
 deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection);
 pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho);

end

fprintf('bestPath = %s;\n', mat2str(bestPath));
