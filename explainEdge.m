%% script to explain the Edge Orientation descriptor

close all
clear all

fname = '10_15_s.bmp';
% fname = '1_8_s.bmp';
Q = 8;
T = 0.8;

imgfname_full = ([Config.DATASET_FOLDER,'/Images/', fname]);
img = double(imread(imgfname_full)) ./ 255;

figure;
imshow(img);

% kernel for sobel filter (gaussian + edge)
kernelX = [1 2 1 ; 0 0 0 ; -1 -2 -1];
kernelY = kernelX';

% strip colour information to yield greyscale
greyimg = img(:,:,1) * 0.30 + img(:,:,2) * 0.59 + img(:,:,3) * 0.11;

figure;
imshow(greyimg);

% convolve with sobel
dx = conv2(greyimg, kernelX, 'same');
dy = conv2(greyimg, kernelY, 'same');

figure;
imshow(dx);

figure;
imshow(dy);

% derive the gradient per pixel
% dx(dx==0)=0.001; % don't like Inf.
theta = atan2(dy, dx) + pi;
mag = sqrt(dx.^2 + dy.^2);

% establish a threshold (% of max magnitude)
threshold = max(max(mag)) * T;

figure;
imshow(mag);

figure;
imshow(theta ./ max(max(theta)));

bin = zeros(Q, 1);
for ii = 1 : size(img, 1)
    for jj = 1 : size(img, 2)
        if mag(ii, jj) > threshold
             idx = min(floor((theta(ii, jj) * (Q-1)) / (2*pi)), Q) + 1;
             bin(idx) = bin(idx) + 1;
        end
    end
end

% It is convenient to normalise the histogram, so the area under it sum to 1.
dsc = bin ./ sum(bin);

figure;
bar(dsc);


