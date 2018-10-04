function mutatedPath = Mutate(path, mutationProbability)
    numberOfGenes = size(path, 2);

    mutatedPath = path;
    
    for i = 1:numberOfGenes
        if rand < mutationProbability
            iRandomGene = SelectRandomGene(numberOfGenes);
            % Swap the genes at indices i and iRandomGene.
            mutatedPath([i iRandomGene]) = mutatedPath([iRandomGene i]);
        end
    end
end

function iSelected = SelectRandomGene(numberOfGenes)
    iSelected = 1 + fix(rand * numberOfGenes);
end
