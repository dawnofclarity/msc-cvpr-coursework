%% Build descriptor set for GlobalRGB
%

close all;
clear all;

folder = 'globalRGB';

allfiles=dir (fullfile([Config.DATASET_FOLDER,'/Images/*.bmp']));
for filenum = 1 : length(allfiles)
    fname = allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);

    % read in image and
    % normalise image to 0..1
    imgfname_full = ([Config.DATASET_FOLDER,'/Images/',fname]);
    img = double(imread(imgfname_full))./255;

    % compute descriptor
    F = deriveGlobalColourDescriptor(img);

    % format filename - replace .bmp with .mat
    fout = sprintf("%s/%s/%s", Config.DESCRIPTOR_FOLDER, folder, fname(1:end-4),'.mat');
    save(fout,'F');
end
