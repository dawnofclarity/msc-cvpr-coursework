%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_visualsearch.m
%% Skeleton code provided as part of the coursework assessment
%%
%% This code will load in all descriptors pre-computed (by the
%% function cvpr_computedescriptors) from the images in the MSRCv2 dataset.
%%
%% It will pick a descriptor at random and compare all other descriptors to
%% it - by calling cvpr_compare.  In doing so it will rank the images by
%% similarity to the randomly picked descriptor.  Note that initially the
%% function cvpr_compare returns a random number - you need to code it
%% so that it returns the Euclidean distance or some other distance metric
%% between the two descriptors it is passed.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;


%% 1) Load all the descriptors into "ALLFEAT"
% each row of ALLFEAT is a descriptor (is an image)
[ALLFEAT, ALLFILES] = loadDescriptors();
  
%% 2) Pick an image at random to be the query

NIMG=size(ALLFEAT,1);           % number of images in collection
queryimg=floor(rand()*NIMG);    % index of a random image

%% 3) Compute the distance of image to the query

tic
dst=zeros(NIMG, 2);
for ii=1:NIMG
    candidate=ALLFEAT(ii,:);
    query=ALLFEAT(queryimg,:);
    thedst=Config.DESCRIPTOR_COMPARATOR(query, candidate);
    dst(ii,:) = [thedst ii];
end
dst=sortrows(dst,1);  % sort the results
elapsedTime = toc;

%% Enrich the search result data
% calculates classes of images, Precision / Recall, Average Precision
data = enrichData(NIMG, ALLFILES, dst, queryimg);

%% 4) Visualise the results
showSingleSearchResult(data, elapsedTime);
