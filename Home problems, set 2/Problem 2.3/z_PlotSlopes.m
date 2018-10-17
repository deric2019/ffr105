clear all;

iTrainingDataSet = 1;
iValidationDataSet = 2;
iTestDataSet = 3;

figure;

subplot(2, 2, 1);
title('Training slopes');
axis([0 1000 0 10]);
hold on;
PlotAllSlopes(iTrainingDataSet);

subplot(2, 2, 2);
title('Validation slopes');
axis([0 1000 0 10]);
hold on;
PlotAllSlopes(iValidationDataSet);

subplot(2, 2, 3);
title('Test slopes');
axis([0 1000 0 10]);
hold on;
PlotAllSlopes(iTestDataSet);

function PlotAllSlopes(iDataSet)
    numberOfSlopes = GetNumberOfSlopes(iDataSet);

    for iSlope = 1:numberOfSlopes
        fplot(@(x) GetSlopeAngle(x, iSlope, iDataSet));
    end
end
