%% use the malhalanobis distance as a comparison

function dst = compareMalhalanobis(F1, F2)

%    E = Eigen_Build(F1);
%    dst = Eigen_Mahalanobis(F2, E);
   mahal(F2, F1)

end
