clear all;

xMin = -5;
xMax = 5;
a = 0.01;

figure;
PlotLevelCurves(xMin, xMax, @EvaluateFunction);
figure;
PlotLevelCurves(xMin, xMax, @(x, y) log(a + EvaluateFunction(x, y)));
