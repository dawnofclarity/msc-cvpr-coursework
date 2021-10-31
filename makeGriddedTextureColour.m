%% Build descriptor set for GriddedTextureColour
%

close all;
clear all;

folder = 'griddedTextureColour';
gvalues = [6, 8, 10, 12];
qvalues = [6, 8, 10];

allfiles=dir (fullfile([Config.DATASET_FOLDER,'/Images/*.bmp']));
for ii = 1 : size(qvalues, 2)
    Q = qvalues(ii);
    
    for jj = 1 : size(gvalues, 2)
        G = gvalues(jj);
        
        for filenum = 1 : length(allfiles)
            fname = allfiles(filenum).name;
            fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);

            % read in image and
            % normalise image to 0..1
            imgfname_full = ([Config.DATASET_FOLDER,'/Images/',fname]);
            img = double(imread(imgfname_full))./255;

            % compute descriptor
            F = deriveGriddedEdgeWithColourDescriptor(img, G, Q);

            % format filename - replace .bmp with .mat
            fout = sprintf("%s/%sQ%dG%d/%s", Config.DESCRIPTOR_FOLDER, folder, Q, G, fname(1:end-4),'.mat');
            save(fout,'F');
        end
    end
end