%% Explanation of colour descriptor

close all;
clear all;

%% 1) Load all the descriptors
% each row of ALLFEAT is a descriptor (is an image)
[ALLFEAT, ALLFILES] = loadDescriptors('globalRGBHistoQ2');

ii = findFile(ALLFILES, '1_6_s.bmp');
candidate=ALLFEAT(ii,:);

% normalise (for pie)
candidate = candidate ./ sum(candidate);

h = pie(candidate);
patchHand = findobj(h, 'Type', 'Patch'); 
patchHand(1).FaceColor = 'r';
patchHand(2).FaceColor = 'g';
patchHand(3).FaceColor = 'b';

function idx = findFile(ALLFILES, name)
    for idx = 1 : size(ALLFILES)
        fname = ALLFILES{idx,2};
        if (strcmp(fname, name) == 1)
            return;
        end
    end
end