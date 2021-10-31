%% Grid based edge orientation histogram plus colour descriptor for an image
%
% Input: img
% Configurable: grid_size (integer)
% Configurable: Q - bucket size for direction of angle quantisation (integer)
%
function dsc = deriveGriddedEdgeWithColourDescriptor(img, gridSize, Q)

    % Threshold percentage for strong edges.
    T = 0.5;

    % grid up the image
    sx = allocate(size(img, 2), gridSize);
    sy = allocate(size(img, 1), gridSize);

    % process the chunks
    dsc = [];
    for ix = 1 : gridSize
        for iy = 1 : gridSize
            subImg = img(sy(iy)+1:sy(iy+1), sx(ix)+1:sx(ix+1), :);
            dsc = [dsc, deriveGlobalColourDescriptor(subImg)];
            dsc = [dsc, deriveEdgeOrientationHistogram(subImg, Q, T)];
        end
    end
    return;
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