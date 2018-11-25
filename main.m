% -------------------------
% Computer Vision 2018 
% Seobin Park 2014001303
% -------------------------
addpath(genpath('functions'));
addpath(genpath('classes'));

img1 = imread('imgs/illumination/img1.png');
img2 = imrotate(img1, 30, 'bicubic', 'crop');

img1 = im2double(img1);
img2 = im2double(img2);

d1 = pseudo_SIFT(img1);
d2 = pseudo_SIFT(img2);

matches = match_desc(d1, d2, 0.8);

% Visualize match
if(~isempty(matches))	
	showMatchedFeatures(img1, img2, matches(:, 1:2), ...
			matches(:, 3:4), 'montage');
end
