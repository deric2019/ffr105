function mutatedChromosome = Mutate(originalChromosome, mutationProbability, creepMutationProbability, creepRate, mutationWeightRange)
    chromosomeLength = length(originalChromosome);

    mutatedChromosome = originalChromosome;
    
    for i = 1:chromosomeLength
        r = rand;
        if r < mutationProbability
            q = rand;
            if q < creepMutationProbability
                % Creep mutation using uniform distribution
                p = rand;
                newValue = originalChromosome(i) - creepRate / 2 + creepRate * p;
            else
                % Ordinary mutation
                p = rand;
                minWeight = mutationWeightRange(1);
                maxWeight = mutationWeightRange(2);
                newValue = p * abs(maxWeight - minWeight) + minWeight;
            end
            
%             if newValue < mutationWeightRange(1)
%                 newValue = mutationWeightRange(1);
%             elseif newValue > mutationWeightRange(2)
%                 newValue = mutationWeightRange(2);
%             end
            
            mutatedChromosome(i) = newValue;
        else
            mutatedChromosome(i) = originalChromosome(i);
        end
    end
end
