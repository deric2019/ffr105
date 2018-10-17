function network = DecodeChromosome(chromosome, numberOfInputs, numberOfHiddenNeurons, numberOfOutputs)
    numberOfInputNeurons = numberOfInputs + 1;
    numberOfHiddenNeuronsPlusBias = numberOfHiddenNeurons + 1;
    
    numberOfInputWeights = numberOfInputNeurons * numberOfHiddenNeurons;
    numberOfOutputWeights = numberOfHiddenNeuronsPlusBias * numberOfOutputs;
    
    if length(chromosome) ~= numberOfInputWeights + numberOfOutputWeights
        error('Invalid chromosome length. Expected %d, got %d', numberOfInputWeights + numberOfOutputWeights, length(chromosome));
    end
    
    inputWeights = chromosome(1:numberOfInputWeights);
    inputWeights = reshape(inputWeights, numberOfInputNeurons, numberOfHiddenNeurons)';
    outputWeights = chromosome(end - numberOfOutputWeights + 1:end);
    outputWeights = reshape(outputWeights, numberOfHiddenNeuronsPlusBias, numberOfOutputs)';
    
    network = struct( ...
        'InputWeights', inputWeights, ...
        'OutputWeights', outputWeights);
end
