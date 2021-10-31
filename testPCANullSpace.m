%% Load all descriptors and visualise them in a 3D plot
%
close all;
clear all;

folder = 'globalRGBhistoQ14';

%% 1) Load all the descriptors into "ALLFEAT"
% each row of ALLFEAT is a descriptor (is an image)
[ALLFEAT, ALLFILES] = loadDescriptors(folder);
n = size(ALLFEAT,1);           % number of descriptors in collection

%% Perform PCA over descriptors
% Eigen functions expect data transposed compared to how we've loaded it.
pts = ALLFEAT';

% eigen model
E = Eigen_Build(pts);

% project into 3d
deflated = Eigen_Deflate(E, 'keepf', 0.9);

projected = Eigen_Project(pts, deflated)';

% % plot data
% figure
% plot3(projected(:, 1), projected(:, 2), projected(:, 3), 'x');
% xlabel('ev1');
% ylabel('ev2');
% zlabel('ev3');
% grid on;
% title(['Visualisation of descriptors from ', folder]);