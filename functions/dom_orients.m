% -----------------------------------------
% Function for choosing dominant directions
%	input: image
%	f: feature points
%	w: window size
%	out_orients: set of logic list of 
%			dominant orientations
% -----------------------------------------
function out_orients = dom_orients(in_img, f, w)

d = (w-1)/2;
[m, n] = size(in_img);
padded_img = padarray(im2double(in_img), [d, d]);
[gradx_2, grady_2] = gradient(padded_img);


%output = [];
output = cell(size(f, 1), 2);
for i=1:size(f, 1)
	f_co = f(i).Location;
	f_x = round(f_co(1));
	f_y = round(f_co(2));
	output{i, 2} = [f_x, f_y];
	% drop edges!!!
	e = 20;
	if(f_x<1+e || f_x>n-e || f_y<1+e || f_y>m-e)
		output{i, 1} = zeros(36);
		continue;
	end
	orient = calc_orient(padded_img(f_y:f_y+w-1, f_x:f_x+w-1), 36);
	threshold = max(orient) * .8;
	output{i, 1} = orient > threshold;
end

out_orients = output;

% function end
end
