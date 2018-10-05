function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    numberOfNodes = size(pheromoneLevel, 1);
    
    path = zeros(1, numberOfNodes + 1);
    tabuList = zeros(1, numberOfNodes);

    startNode = GetRandomNode(numberOfNodes);
    path(1) = startNode;
    % The tabu list is represented as a vector of 1s and 0s of length N,
    % where a 1 at index i indicates that node i is on the tabu list.
    % This allows for faster lookups compared to using a list that contains
    % the visited nodes in order.
    tabuList(startNode) = 1;
    
    for i = 2:numberOfNodes
        currentNode = path(i - 1);
        node = GetNextNode(numberOfNodes, currentNode, tabuList, pheromoneLevel, visibility, alpha, beta);
        path(i) = node;
        tabuList(node) = 1;
    end
    
    path(end) = startNode;
end

function node = GetRandomNode(numberOfNodes)
    node = 1 + fix(rand * numberOfNodes);
end

function node = GetNextNode(numberOfNodes, currentNode, tabuList, pheromoneLevel, visibility, alpha, beta)
    probabilities = CalculateProbabilities(numberOfNodes, currentNode, tabuList, pheromoneLevel, visibility, alpha, beta);
    node = randsample(1:numberOfNodes, 1, true, probabilities);
end

function probabilities = CalculateProbabilities(numberOfNodes, currentNode, tabuList, pheromoneLevel, visibility, alpha, beta)
    weights = zeros(numberOfNodes);
    
    j = currentNode;

    for i = 1:numberOfNodes
        isTabu = tabuList(i) == 1;
        
        if ~isTabu
            weight = GetEdgeWeight(i, j, pheromoneLevel, visibility, alpha, beta);
            weights(i) = weight;
        end
    end
    
    probabilities = weights / sum(weights);
end

function weight = GetEdgeWeight(i, j, pheromoneLevel, visibility, alpha, beta)
    tau = pheromoneLevel(i, j);
    eta = visibility(i, j);
    weight = tau^alpha * eta^beta;
end
