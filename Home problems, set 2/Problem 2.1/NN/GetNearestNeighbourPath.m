function nearestNeighbourPath = GetNearestNeighbourPath(startCity, cityLocations)
    numberOfCities = size(cityLocations, 1);
    
    nearestNeighbourPath = zeros(1, numberOfCities + 1);
    nearestNeighbourPath(1) = startCity;

    for i = 2:numberOfCities
        currentCity = nearestNeighbourPath(i - 1);
        nextCity = GetNearestNeighbour(currentCity, nearestNeighbourPath, cityLocations);
        nearestNeighbourPath(i) = nextCity;
    end
    
    nearestNeighbourPath(end) = startCity;
end

function nearestNeighbour = GetNearestNeighbour(city, visitedCities, cityLocations)
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
