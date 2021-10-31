
%%
% Derive the euclidian L2 Norm distance between two descriptors
%
function dst = compareL2Norm(F1, F2)

    % difference all members
    x = F1 - F2;
    
    % Square the differences
    x = x.^2;
    
    % Sum the differences
    x = sum(x);

    % Take root
    dst = sqrt(x);

return;