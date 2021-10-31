%% Global Colour Histogram, Mahalonobis Distance All searches
% NB: Requires that the descriptor generation for globalRGBhisto has been completed
%
% Searches all combinations of image, computing AP for each to yield MAP

close all;
clear all;

%% 1) Load all the descriptors
% each row of ALLFEAT is a descriptor (is an image)
[ALLFEAT, ALLFILES] = loadDescriptors('globalRGBhistoQ8');
NIMG=size(ALLFEAT,1);           % number of images in collection
  
%% 2) For each image
averagePrecisionRunningTotal = 0;
p = zeros(NIMG, NIMG);
r = zeros(NIMG, NIMG);
for queryimg = 1 : NIMG

    % progress...
    fprintf("queryimg: %d\n", queryimg);
    
    %% 3) Compute the distance of image to the query

    % calc the "search" eigen model
    queryImgDsc = ALLFEAT(queryimg,:)';
    query_e = Eigen_Build(queryImgDsc);

    % Now compare our eigen model to all the other points
    mahal_dist = Eigen_Mahalanobis(ALLFEAT', query_e);

    % normalise 0..1
    mahal_dist = mahal_dist ./ max(mahal_dist);

    dst=zeros(NIMG, 2);
    for ii=1:NIMG
        thedst=mahal_dist(ii);
        dst(ii,:) = [thedst ii];
    end
    dst=sortrows(dst,1);  % sort the results
    
    %% 4) Enrich the search result data
    % calculates classes of images, Precision / Recall, Average Precision
    data = enrichData(NIMG, ALLFILES, dst, queryimg);
    
    averagePrecisionRunningTotal = averagePrecisionRunningTotal + data.averagePrecision;
    
    p(queryimg,:) = [data.results(:).precisionScore];
    r(queryimg,:) = [data.results(:).recallScore];
    
end

%% 5) post image figures
map = averagePrecisionRunningTotal / NIMG;
mp = mean(p,1);
mr = mean(r,1);

%% 6) Visualise the results
fprintf("MAP: %0.3f\n", map);

figure
plot(mr, mp, '-');
axis([0 1 0 1]);
title('Precision-Recall Curve');
xlabel('Recall');
ylabel('Precision');

