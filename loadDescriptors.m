%% Load the descriptors
%
% Reads from Config for directories, etc.
% Input:
% folder    - Name of subfolder containg the descriptors
% Output:
% ALLFEAT   - Vector of Descriptors
% ALLFILES  - Vector of full path filenames
% NAMES     - Vector of filenames only
function [ALLFEAT, ALLFILES] = loadDescriptors(folder)
    ALLFEAT=[];
    ALLFILES=cell(1,2);
    allfiles=dir (fullfile([Config.DATASET_FOLDER,'/Images/*.bmp']));
    for filenum=1:length(allfiles)
        fname=allfiles(filenum).name;
        imgfname_full=([Config.DATASET_FOLDER,'/Images/',fname]);
        featfile=[Config.DESCRIPTOR_FOLDER,'/',folder,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
        load(featfile,'F');
        ALLFILES{filenum, 1} = imgfname_full;
        ALLFILES{filenum, 2} = fname;
        ALLFEAT=[ALLFEAT ; F];
    end
end