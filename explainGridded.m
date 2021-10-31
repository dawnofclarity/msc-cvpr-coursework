%% Explanation of RGB histo descriptor

close all;
clear all;

fname = '20_10_s.bmp';
gridSize = 2;

imgfname_full = ([Config.DATASET_FOLDER,'/Images/', fname]);
img = double(imread(imgfname_full)) ./ 255;

sx = allocate(size(img, 2), gridSize);
sy = allocate(size(img, 1), gridSize);

dsc = [];
for ix = 1 : gridSize
    for iy = 1 : gridSize
        subImg = img(sy(iy)+1:sy(iy+1), sx(ix)+1:sx(ix+1), :);
        figure;
        imshow(subImg);
        cdsc = deriveGlobalColourDescriptor(subImg);

        % normalise (for pie)
        candidate = cdsc ./ sum(cdsc);

        figure;
        h = pie(candidate);
        patchHand = findobj(h, 'Type', 'Patch'); 
        patchHand(1).FaceColor = 'r';
        patchHand(2).FaceColor = 'g';
        patchHand(3).FaceColor = 'b';
        
        dsc = [dsc, cdsc];
    end
end


function idx = findFile(ALLFILES, name)
    for idx = 1 : size(ALLFILES)
        fname = ALLFILES{idx,2};
        if (strcmp(fname, name) == 1)
            return;
        end
    end
end

function buckets = allocate(value, size)
    buckets = zeros(size + 1);
    for ix = 1 : size
        buckets(ix + 1) = floor(value / size);
    end
    for ix = 1 : mod(value, size)
        buckets(ix + 1) = buckets(ix + 1) + 1;
    end
    for ix = 2 : size
        buckets(ix + 1) = buckets(ix + 1) + buckets(ix);
    end
    return;
end