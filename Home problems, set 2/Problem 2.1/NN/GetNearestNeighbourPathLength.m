function [nearestNeighbourPath, nearestNeighbourPathLength] = GetNearestNeighbourPathLength(startCity, cityLocations)
    numberOfCities = size(cityLocations, 1);
    
    nearestNeighbourPath = zeros(1, numberOfCities + 1);
    nearestNeighbourPathLength = 0;
    
    nearestNeighbourPath(1) = startCity;
    currentCity = startCity;
    for i = 2:numberOfCities
        [nextCity, distance] = GetNearestNeighbour(currentCity, nearestNeighbourPath, cityLocations);
        nearestNeighbourPathLength = nearestNeighbourPathLength + distance;
        nearestNeighbourPath(i) = nextCity;
        currentCity = nextCity;
    end
    
    nearestNeighbourPathLength = nearestNeighbourPathLength + DistanceBetweenCities(currentCity, startCity, cityLocations);
    nearestNeighbourPath(end) = startCity;
end

function [nearestNeighbour, nearestNeighbourDistance] = GetNearestNeighbour(city, visitedCities, cityLocations)
    numberOfCities = size(cityLocations, 1);
    
    nearestNeighbour = 0;
    nearestNeighbourDistance = -1;
    
    for otherCity = 1:numberOfCities
        if ~ismember(otherCity, visitedCities)
            distance = DistanceBetweenCities(city, otherCity, cityLocations);

            if nearestNeighbourDistance == -1 || distance < nearestNeighbourDistance
                nearestNeighbour = otherCity;
                nearestNeighbourDistance = distance;
            end
        end
    end
end
