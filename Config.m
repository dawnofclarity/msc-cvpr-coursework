%% Config
% Singleton Class to hold global configuration
%
classdef Config < handle
    properties (Constant)
        % Edit the following line to the folder you unzipped the MSRCv2 dataset to
        DATASET_FOLDER = 'Y:\cvpr\msrc_objcategimagedatabase_v2';

        % Folder that holds the results...
        DESCRIPTOR_FOLDER = 'Y:\cvpr\descriptors';
    end
end
 