function PlotData(data)
    xValues = data(:, 1);
    yValues = data(:, 2);
    scatter(xValues, yValues, 5, 'black', 'filled');
end
