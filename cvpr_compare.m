
%%
% Compare two descriptors
%
% This function should compare F1 to F2 - i.e. compute the distance
% between the two descriptors
%
function dst=cvpr_compare(F1, F2)

    % delegate to L2 Norm
    dst=deriveEuclidianL2Norm(F1, F2);

return;

%%
% Derive the euclidian L2 Norm distance between two descriptors
%
function dst=deriveEuclidianL2Norm(F1, F2)

    % difference all members
    x = F1 - F2;
    
    % Square the differences
    x = x.^2;
    
    % Sum the differences
    x = sum(x);

    % Take root
    dst = sqrt(x);

return;