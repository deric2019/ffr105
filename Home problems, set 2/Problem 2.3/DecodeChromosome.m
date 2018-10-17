function network = DecodeChromosome(chromosome, layerSizes)
    numberOfInputNeurons = layerSizes(1) + 1;
    numberOfHiddenNeurons = layerSizes(2) + 1;
    
    numberOfInputWeights = numberOfInputNeurons * layerSizes(2);
    numberOfOutputWeights = numberOfHiddenNeurons * layerSizes(3);
    
    chromosomeLength = length(chromosome);
    expectedLength = numberOfInputWeights + numberOfOutputWeights;
    
    if chromosomeLength ~= expectedLength
        error('Invalid chromosome length. Expected %d, got %d', expectedLength, chromosomeLength);
    end
    
    inputWeights = chromosome(1:numberOfInputWeights);
    inputWeights = reshape(inputWeights, numberOfInputNeurons, layerSizes(2))';
    outputWeights = chromosome(numberOfInputWeights + 1:end);
    outputWeights = reshape(outputWeights, numberOfHiddenNeurons, layerSizes(3))';
    
    network = struct( ...
        'InputWeights', inputWeights, ...
        'OutputWeights', outputWeights);
end
