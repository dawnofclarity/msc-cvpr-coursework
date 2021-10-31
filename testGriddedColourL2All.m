%% Gridded Colour Euclidian L2 Distance All searches
% NB: Requires that the descriptor generation for griddedColour has been completed
%
% Searches all combinations of image, computing AP for each to yield MAP

close all;
clear all;

%% 1) Load all the descriptors
% each row of ALLFEAT is a descriptor (is an image)
[ALLFEAT, ALLFILES] = loadDescriptors('griddedColourG6');
NIMG=size(ALLFEAT,1);           % number of images in collection
  
%% 2) For each image
tic
averagePrecisionRunningTotal = 0;
p = zeros(NIMG, NIMG);
r = zeros(NIMG, NIMG);
for queryimg = 1 : NIMG

    % progress...
    fprintf("queryimg: %d\n", queryimg);
    
    %% 3) Compute the distance of image to the query
    dst=zeros(NIMG, 2);
    for ii=1:NIMG
        candidate=ALLFEAT(ii,:);
        query=ALLFEAT(queryimg,:);
        thedst=compareL2Norm(query, candidate);
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
elapsedTime = toc

%% 5) post image figures
map = averagePrecisionRunningTotal / NIMG;
mp = mean(p,1);
mr = mean(r,1);

%% 6) Visualise the results
fprintf("MAP: %0.3f\n", map);
fprintf("Elapsed time: %.3f", elapsedTime)

figure
plot(mr, mp, '-');
axis([0 1 0 1]);
title('Precision-Recall Curve');
xlabel('Recall');
ylabel('Precision');
