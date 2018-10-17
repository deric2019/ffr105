clear all;

iTrainingDataSet = 1;
iValidationDataSet = 2;
iTestDataSet = 3;

disp('% Training');
disp('if iDataSet == 1');
for i = 1:GetNumberOfSlopes(iTrainingDataSet)
    slope = GenerateRandomSlope();
    if i == 1
        fprintf('    if iSlope == %d\n', i);
    else
        fprintf('    elseif iSlope == %d\n', i);
    end
    fprintf('        alpha = %s;\n', slope);
end
disp('    end');

disp('% Validation');
disp('elseif iDataSet == 2');
for i = 1:GetNumberOfSlopes(iValidationDataSet)
    slope = GenerateRandomSlope();
    if i == 1
        fprintf('    if iSlope == %d\n', i);
    else
        fprintf('    elseif iSlope == %d\n', i);
    end
    fprintf('        alpha = %s;\n', slope);
end
disp('    end');

disp('% Test');
disp('elseif iDataSet == 3');
for i = 1:GetNumberOfSlopes(iTestDataSet)
    slope = GenerateRandomSlope();
    if i == 1
        fprintf('    if iSlope == %d\n', i);
    else
        fprintf('    elseif iSlope == %d\n', i);
    end
    fprintf('        alpha = %s;\n', slope);
end
disp('    end');
disp('end');
