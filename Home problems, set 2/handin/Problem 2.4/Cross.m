function [newChromosome1, newChromosome2] = Cross(chromosome1, chromosome2)
    [chromosome1part1, chromosome1part2, chromosome1part3] = GetCrossoverParts(chromosome1);
    [chromosome2part1, chromosome2part2, chromosome2part3] = GetCrossoverParts(chromosome2);
    newChromosome1 = [chromosome1part1 chromosome2part2 chromosome1part3];
    newChromosome2 = [chromosome2part1 chromosome1part2 chromosome2part3];
end

function [part1, part2, part3] = GetCrossoverParts(chromosome)
    points = GetCrossoverPoints(chromosome);
    part1 = chromosome(1:points(1));
    part2 = chromosome(points(1) + 1:points(2));
    part3 = chromosome(points(2) + 1:end);
end

function points = GetCrossoverPoints(chromosome)
    numberOfInstructions = length(chromosome) / 4;
    instructionPoint1 = RandomIndex(numberOfInstructions - 1);
    instructionPoint2 = RandomIndex(numberOfInstructions - 1);
    point1 = instructionPoint1 * 4;
    point2 = instructionPoint2 * 4;
    points = sort([point1 point2]);
end
