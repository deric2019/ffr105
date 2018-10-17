function diversity = CalculateDiversity(population)
    populationSize = length(population);

    totalDistance = 0;

    for i = 1:populationSize-1
        for j = i+1:populationSize
            individual1 = population(i);
            individual2 = population(j);
            chromosome1 = individual1.Chromosome;
            chromosome2 = individual2.Chromosome;
            
            distance = CalculateDistance(chromosome1, chromosome2);

            totalDistance = totalDistance + distance;
        end
    end
    
    diversity = 2 / (populationSize * (populationSize - 1)) * totalDistance;
end

function distance = CalculateDistance(chromosome1, chromosome2)
    maxLength = max(length(chromosome1), length(chromosome2));

    totalDiff = 0;
    
    for k = 1:maxLength
        gene1 = 0;
        gene2 = 0;
        if k <= length(chromosome1)
            gene1 = chromosome1(k);
        end
        if k <= length(chromosome2)
            gene2 = chromosome2(k);
        end
        
        if gene1 == gene2
            diff = 0;
        else
            diff = 1;
        end
        
        totalDiff = totalDiff + diff;
    end
    
    distance = totalDiff / maxLength;
end
