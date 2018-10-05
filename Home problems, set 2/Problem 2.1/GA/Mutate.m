function mutatedChromosome = Mutate(chromosome, mutationProbability)
    numberOfGenes = size(chromosome, 2);

    mutatedChromosome = chromosome;
    
    for i = 1:numberOfGenes
        if rand < mutationProbability
            iRandomGene = RandomIndex(numberOfGenes);
            % Swap the genes at indices i and iRandomGene.
            mutatedChromosome([i iRandomGene]) = mutatedChromosome([iRandomGene i]);
        end
    end
end
