clear all;

startingPoint = [1; 2];

penaltyFactors = [0, 1, 10, 100, 1000, 10000];
stepLength = 0.00001;
threshold = 10^(-6);

table = cell2table(cell(0, 3), 'VariableNames', {'penaltyFactor', 'x1', 'x2'});

for penaltyFactor = penaltyFactors
    x = GradientDescent(startingPoint, penaltyFactor, stepLength, threshold);
    table = [table; {penaltyFactor, round(x(1), 3), round(x(2), 3)}];
end

disp(table);
