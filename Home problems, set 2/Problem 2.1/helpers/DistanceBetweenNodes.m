function distance = DistanceBetweenNodes(node1, node2, nodeLocations)
    location1 = nodeLocations(node1, :);
    location2 = nodeLocations(node2, :);
    distance = EucledianDistance(location1, location2);
end

function distance = EucledianDistance(point1, point2) 
    x1 = point1(1);
    y1 = point1(2);
    x2 = point2(1);
    y2 = point2(2);
    distance = sqrt((x2 - x1)^2 + (y2 - y1)^2);
end
