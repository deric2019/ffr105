function numberOfSlopes = GetNumberOfSlopes(iDataSet)
    if iDataSet == 1
%         numberOfSlopes = 70;
        numberOfSlopes = 10;
    elseif iDataSet == 2
%         numberOfSlopes = 20;
        numberOfSlopes = 5;
    elseif iDataSet == 3
%         numberOfSlopes = 10;
        numberOfSlopes = 5;
    else
        error('Invalid data set %d', iDataSet);
    end
end
