%% derive an Egde Orientation histogram for pixels in an image
%
% Inputs:
%  Q - number of hitsogram buckets to use (positive integer)

function dsc = deriveEdgeOrientationHistogram(img, Q, T)

    % kernel for sobel filter (gaussian + edge)
    kernelX = [1 2 1 ; 0 0 0 ; -1 -2 -1];
    kernelY = kernelX';
    
    % strip colour information to yield greyscale
    greyimg = img(:,:,1) * 0.30 + img(:,:,2) * 0.59 + img(:,:,3) * 0.11;
    
    % convolve with sobel
    dx = conv2(greyimg, kernelX, 'same');
    dy = conv2(greyimg, kernelY, 'same');
    
    % derive the gradient per pixel
    theta = atan2(dy, dx) + pi; % adjust from -pi .. pi to 0 .. 2pi
    
    % and the magnitude
    mag = sqrt(dx.^2 + dy.^2);

    % establish a threshold (% of max magnitude)
    threshold = max(max(mag)) * T;

    % accumulate strong edges (where magnitude is high)
    bin = zeros(Q, 1);
    for ii = 1 : size(img, 1)
        for jj = 1 : size(img, 2)
            if mag(ii, jj) > threshold
                 idx = min(floor((theta(ii, jj) * Q) / (2*pi)), Q-1) + 1;
                 bin(idx) = bin(idx) + 1;
            end
        end
    end

    % normalise into the range 0..1
    dsc = (bin ./ sum(bin))';
    
end
