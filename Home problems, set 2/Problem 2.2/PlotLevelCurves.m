function PlotLevelCurves(xMin, xMax, fn)
    xValues = linspace(xMin, xMax);
    yValues = linspace(xMin, xMax);
    zValues = ComputeZValues(xValues, yValues, fn);
    contour(xValues, yValues, zValues, 50);
    xlabel('x');
    ylabel('y');
end

function values = ComputeZValues(xValues, yValues, fn)
    nx = size(xValues, 2);
    ny = size(yValues, 2);
    values = zeros(nx, ny);
    for i = 1:nx
        for j = 1:ny
            x = xValues(i);
            y = yValues(j);
            values(j, i) = fn(x, y);
        end
    end
end
