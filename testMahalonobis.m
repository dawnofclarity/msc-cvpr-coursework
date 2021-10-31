%% Test cases for evaluating the Mahalanobis distance

clear all

%% Load the descriptors
[ALLFEAT, ALLFILES] = loadDescriptors('griddedColourG8');

% Grab search descriptor
k = findFile(ALLFILES, '1_1_s.bmp');
queryImgDsc = ALLFEAT(k,:)';

% calc the "search" eigen model
query_e = Eigen_Build(queryImgDsc);

% Given: compare to itself!
% Then: distance should be small
dist = Eigen_Mahalanobis(queryImgDsc, query_e);
fprintf("Distance(%s): %.6f\n", '1_1_s.bmp', dist);

% Given: compare to similar
% Then: distance should be medium
k = findFile(ALLFILES, '1_6_s.bmp');
testImgDsc = ALLFEAT(k,:)';
dist = Eigen_Mahalanobis(testImgDsc, query_e);
fprintf("Distance(%s): %.6f\n", '1_6_s.bmp', dist);

% Given: compare to similar
% Then: distance should be medium
k = findFile(ALLFILES, '1_7_s.bmp');
testImgDsc = ALLFEAT(k,:)';
dist = Eigen_Mahalanobis(testImgDsc, query_e);
fprintf("Distance(%s): %.6f\n", '1_7_s.bmp', dist);

% Given: compare to dissimilar
% Then: distance should be large
k = findFile(ALLFILES, '3_18_s.bmp');
testImgDsc = ALLFEAT(k,:)';
dist = Eigen_Mahalanobis(testImgDsc, query_e);
fprintf("Distance(%s): %.6f\n", '3_18_s.bmp', dist);

function idx = findFile(ALLFILES, name)
    for idx = 1 : size(ALLFILES)
        fname = ALLFILES{idx,2};
        if (contains(fname, name))
            return;
        end
    end
end