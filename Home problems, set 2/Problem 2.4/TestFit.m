clear all;

data = LoadFunctionData();

numberOfRegisters = 10;
constants = [1 3 -1];
divisionByZeroConstant = 10000;

bestChromosome = [5 4 6 10 3 1 4 3 5 3 3 8 2 2 9 3 7 4 1 9 6 3 3 4 6 3 9 6 3 4 5 6 6 4 5 9 3 4 4 8 4 3 1 4 4 2 6 8 4 3 9 5 6 4 3 5 7 1 10 5 7 1 2 3 3 1 2 6 4 1 2 3 4 2 2 3 3 1 9 1 4 3 3 4 2 2 9 2 3 2 9 6 4 4 7 10 6 3 5 3 3 3 1 1 4 1 7 4 5 2 9 5 4 3 4 5 6 4 10 5 6 1 6 6 6 1 8 1 6 3 1 1 6 3 4 6 2 1 5 8 5 1 1 6 6 1 6 6 7 1 10 5 7 1 2 3 3 1 3 8 4 1 2 3 4 2 2 3 3 1 9 1 4 3 3 4 5 2 9 2 3 2 6 6 4 4 7 9 6 3 5 3 3 3 1 1 4 4 7 4 5 2 9 5 4 3 4 5 6 4 10 5 6 1 6 6 6 1 8 1 6 3 1 1 6 3 4 6 2 1 5 8 5 4 6 6 6 1 6 6 7 3 7 7 5 1 7 7 6 2 6 10 6 1 6 2 5 2 3 3 6 1 9 6 2 2 5 2 7 3 3 5 2 3 6 6 2 2 6 2 6 4 8 7 2 1 7 2 5 2 1 3 4 1 5 3 6 3 6 2 2 3 4 3 5 4 8 7 2 4 5 7 5 2 1 3 4 3 3 5 3 3 6 4 5 1 4 3 2 1 7 1 3 2 3 5 2 4 3 1 4 2 8 6 7 1 2 3 4 3 6 3 5 2 1 1 6 1 8 2 2 1 6 6 2 1 8 7 1 4 6 2];
error = CalculateError(bestChromosome, data, numberOfRegisters, constants, divisionByZeroConstant);

syms x;
fn = (x^3 - x^2 + 1)/(x^4 - x^2 + 1); % Generated with the DecodeChromosome function

figure;
hold on;
xlabel('x');
ylabel('g(x)');

PlotData(data);
fplot(fn);
fprintf('error = %.5f\n', error);
