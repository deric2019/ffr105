function length = PathLength(path, cityLocations)
    numberOfCities = size(path, 2);
    
    length = 0;
    
    for i = 1:numberOfCities - 1
        fromCity = path(i);
        toCity = path(i + 1);
        length = length + DistanceBetweenCities(fromCity, toCity, cityLocations);
    end
    
    firstCity = path(1);
    lastCity = path(end);
    length = length + DistanceBetweenCities(firstCity, lastCity, cityLocations);
end
