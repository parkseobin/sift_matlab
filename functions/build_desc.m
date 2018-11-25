% -----------------------------------------
% Function for building descriptor
%	in_img: input image
%	scale: in_img scale from real img
%	orients: orientation informations
%	out_descs: output descriptor objects
% -----------------------------------------
function out_descs = build_desc(in_img, scale, orients)

[m, n] = size(in_img);
% the patch is 23x23
w = 23;
d = (w-1)/2;
padded_img = padarray(im2double(in_img), [d, d]);

% set of desc objects
desc_per_feature = [];
for i=1:size(orients, 1)
	f_x = orients{i, 2}(1);
	f_y = orients{i, 2}(2);
	if(f_x<1 || f_x>n || f_y<1 || f_y>m)
		[f_x, f_y]
		continue;
	end
	patch = padded_img(f_y:f_y+w-1, f_x:f_x+w-1);
	tmp_desc = DescClass;
	tmp_desc.set_coordinates(round(f_x/scale), round(f_y/scale));

	angles = find(orients{i, 1});
	% angles are somtimes [0, 1] => need fix
	if(size(angles, 1) == 0)
		continue;
	end

	for j=1:size(angles, 2)
		patch_r = imrotate(patch, -angles(j)*10, 'bicubic', 'crop');
		% this is not a center crop!!
		patch_16x16 = patch_r(4:19, 4:19);
		one_desc = [];
		for k=1:4
			for l=1:4
				patch_4x4 = patch_16x16(4*k-3:4*k, 4*l-3:4*l);
				one_desc = [one_desc calc_orient(patch_4x4, 8)];
			end
		end
		tmp_desc.add_desc(one_desc);
	end
	desc_per_feature = [desc_per_feature tmp_desc];
end

out_descs = desc_per_feature;

% function end
end
