%% Build descriptor set for GriddedColour
%

close all;
clear all;

folder = 'griddedColourG';
gvalues = [2, 3, 4, 6, 8, 10, 12, 14, 16];

allfiles=dir (fullfile([Config.DATASET_FOLDER,'/Images/*.bmp']));
for ii = 1 : size(gvalues, 2)
    G = gvalues(ii)
    for filenum = 1 : length(allfiles)
        fname = allfiles(filenum).name;
        fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
        
        % read in image and
        % normalise image to 0..1
        imgfname_full = ([Config.DATASET_FOLDER,'/Images/',fname]);
        img = double(imread(imgfname_full))./255;
        
        % compute descriptor
        F = deriveGriddedRGBDescriptor(img, G);
        
        % format filename - replace .bmp with .mat
        fout = sprintf("%s/%s%d/%s", Config.DESCRIPTOR_FOLDER, folder, G, fname(1:end-4),'.mat');
        save(fout,'F');
    end
end