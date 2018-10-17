function output = RunNeuralNetwork(network, input)
    inputWeights = network.InputWeights;
    outputWeights = network.OutputWeights;
    
    inputNeurons = [input; 1];
    
    hiddenNeurons = sigmf(inputWeights * inputNeurons, [1 0]);
    hiddenNeurons = [hiddenNeurons; 1];
    
    output = sigmf(outputWeights * hiddenNeurons, [1 0]);
end
