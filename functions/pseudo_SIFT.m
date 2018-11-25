% -----------------------------------------
% Function for overall SIFT
% -----------------------------------------
function out_descs = pseudo_SIFT(img)

if(ndims(img) == 3)
	img = rgb2gray(img);
end

% pyramid of image with different scale
l_pyramid = cell(4, 1);
% feature points
f_pyramid = cell(4, 1);
for i=1:4
	start_img = imresize(img, 2^(1-0.5*i));
	l_pyramid{i, 1} = start_img;
	f_pyramid{i, 1} = detectHarrisFeatures(start_img, ...
			'MinQuality', 0.01);
	f_pyramid{i, 1} = f_pyramid{i, 1}.selectStrongest(200);
end

out_descs = [];
w_size = [15, 11, 7, 5];
for i=1:4
	for j=1:1
		orient_output = dom_orients(l_pyramid{i, j}, ...
				f_pyramid{i, j}, w_size(i));
		tmp = build_desc(l_pyramid{i, j}, 2^(1-0.5*i), ...
				orient_output);
		out_descs = [out_descs tmp];
	end
end
size(out_descs)

end
