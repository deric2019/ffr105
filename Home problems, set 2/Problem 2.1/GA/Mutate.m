function mutatedChromosome = Mutate(chromosome, mutationProbability)
    numberOfGenes = size(chromosome, 2);

    mutatedChromosome = chromosome;
    
    for i = 1:numberOfGenes
        if rand < mutationProbability
            iRandomGene = SelectRandomGene(numberOfGenes);
            % Swap the genes at indices i and iRandomGene.
            mutatedChromosome([i iRandomGene]) = mutatedChromosome([iRandomGene i]);
        end
    end
end

function iSelected = SelectRandomGene(numberOfGenes)
    iSelected = 1 + fix(rand * numberOfGenes);
end
