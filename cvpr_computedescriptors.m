%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_computedescriptors.m
%% Skeleton code provided as part of the coursework assessment
%% This code will iterate through every image in the MSRCv2 dataset
%% and call a function 'extractRandom' to extract a descriptor from the
%% image.  Currently that function returns just a random vector so should
%% be changed as part of the coursework exercise.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

%% Load each file, and apply the descriptor computation
% The descriptor is saved in the OUT_SUBFOLDER as <filename>.mat

allfiles=dir (fullfile([Config.DATASET_FOLDER,'/Images/*.bmp']));
for filenum = 1 : length(allfiles)
    fname = allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    imgfname_full = ([Config.DATASET_FOLDER,'/Images/',fname]);
    img = double(imread(imgfname_full))./255;
    fout = [Config.DESCRIPTOR_FOLDER,'/',Config.DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    F = Config.DESCRIPTOR_FACTORY(img);
    save(fout,'F');
end
