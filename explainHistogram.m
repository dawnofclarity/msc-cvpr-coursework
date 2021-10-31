close all
clear all

fname = '1_6_s.bmp';
Q = 3;

imgfname_full = ([Config.DATASET_FOLDER,'/Images/', fname]);
img = double(imread(imgfname_full)) ./ 255;

qimg=floor(img .* Q);

bin = qimg(:,:,1)*Q^2 + qimg(:,:,2)*Q^1 + qimg(:,:,3);

vals=reshape(bin,1,size(bin,1)*size(bin,2));

H = histcounts(vals, Q^3);
H = H ./ sum(H);

figure;
bar( H);

fname = '20_10_s.bmp';

imgfname_full = ([Config.DATASET_FOLDER,'/Images/', fname]);
img = double(imread(imgfname_full)) ./ 255;

qimg=floor(img .* Q);

bin = qimg(:,:,1)*Q^2 + qimg(:,:,2)*Q^1 + qimg(:,:,3);

vals=reshape(bin,1,size(bin,1)*size(bin,2));

H = histcounts(vals, Q^3);
H = H ./ sum(H);

figure;
bar( H);

