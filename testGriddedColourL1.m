%% Gridded RGB, Euclidian L1 Distance
% NB: Requires that the descriptor generation for globalRGBhisto has been completed

close all;
clear all;

%% 1) Load all the descriptors
% each row of ALLFEAT is a descriptor.
% Testing has informed that Q=8 appears to be best dataset
[ALLFEAT, ALLFILES] = loadDescriptors('griddedColourG6');
  
%% 2) Pick an image at random to be the query

NIMG=size(ALLFEAT,1);           % number of images in collection
queryimg=floor(rand()*NIMG);    % index of a random image

%% 3) Compute the distance of image to the query
tic
dst=zeros(NIMG, 2);
for ii=1:NIMG
    candidate=ALLFEAT(ii,:);
    query=ALLFEAT(queryimg,:);
    thedst=compareL1Norm(query, candidate);
    dst(ii,:) = [thedst ii];
end
dst=sortrows(dst,1);  % sort the results
elapsedTime = toc;

%% Enrich the search result data
% calculates classes of images, Precision / Recall, Average Precision
data = enrichData(NIMG, ALLFILES, dst, queryimg);

%% 4) Visualise the results
showSingleSearchResult(data, elapsedTime, 'Gridded RGB with L1 Norm Distance');

