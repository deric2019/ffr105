clear all;

xMin = -5;
xMax = 5;
a = 0.01;

xValues = [-2.805118 3.000000 3.584428 -3.779310];
yValues = [3.131313 2.000000 -1.848127 -3.283186];

figure;
hold on;
PlotLevelCurves(xMin, xMax, @EvaluateFunction);
scatter(xValues, yValues, 10, 'black', 'filled');
figure;
PlotLevelCurves(xMin, xMax, @(x, y) log(a + EvaluateFunction(x, y)));
