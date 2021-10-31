
fname = '10_15_s.bmp';
% fname = '1_8_s.bmp';
Q = 2;
T = 0.85;

imgfname_full = ([Config.DATASET_FOLDER,'/Images/', fname]);
img = double(imread(imgfname_full)) ./ 255;

dsc = deriveGriddedEdgeOrientationHistogramDescriptor(img, 8, 2);
