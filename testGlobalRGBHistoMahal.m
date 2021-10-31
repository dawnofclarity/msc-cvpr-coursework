%% Global Colour Histogram, Mahalonobis Distance
% NB: Requires that the descriptor generation for globalRGBhisto has been completed

close all;
clear all;

%% 1) Load all the descriptors
% each row of ALLFEAT is a descriptor (is an image)
[ALLFEAT, ALLFILES] = loadDescriptors('globalRGBhistoQ8');
  
%% 2) Pick an image at random to be the query

NIMG=size(ALLFEAT,1);           % number of images in collection
queryimg=floor(rand()*NIMG);    % index of a random image

%% 3) Compute the distance of image to the query

tic
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
elapsedTime = toc;

%% Enrich the search result data
% calculates classes of images, Precision / Recall, Average Precision
data = enrichData(NIMG, ALLFILES, dst, queryimg);

%% 4) Visualise the results
showSingleSearchResult(data, elapsedTime, 'Global RGB Histo with Mahalonobis Distance');
