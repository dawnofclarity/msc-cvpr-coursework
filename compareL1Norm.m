
%%
% Derive the euclidian L1 Norm distance between two descriptors
%
function dst = compareL1Norm(F1, F2)

    % difference all members
    x = abs(F1 - F2);
    
    % Sum the differences
    dst = sum(x);

return;