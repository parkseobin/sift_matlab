% -----------------------------------------
% Function for choosing dominant directions
% 	in_patch: input patch
%	b: bin size
%	out_orient: output orientation vector
%				size b and coordinates
% -----------------------------------------
function out_orient = calc_orient(in_patch, b)

[s, s_] = size(in_patch);
[G_x, G_y] = gradient(in_patch);

% build Gaussian filter
gauss_s = zeros(s);
if(mod(s, 2) == 0)
	gauss_s(s/2:s/2+1, s/2:s/2+1) = ...
		[0.25, 0.25; 0.25, 0.25]*s*s;
else
	gauss_s((s+1)/2, (s+1)/2) = 1*s*s;
end
gauss_s = imgaussfilt(gauss_s, 1);

orient = zeros(1, b);
for i=1:s
	for j=1:s
		% the range of arctan is [-pi/2 pi/2]
		theta = atan2(G_y(i, j), G_x(i, j));
		theta = mod(theta * b /pi /2, b);
		ind = floor(theta);
		mag = norm(G_x(i, j), G_y(i, j));
		mag = gauss_s(i, j) * mag;

		% split the magnitude to improve smoothness
		orient(mod(ind+1, b)+1) = ...
				orient(mod(ind+1, b)+1) + (ind+1-theta)*mag;
		orient(mod(ind+2, b)+1) =... 
				orient(mod(ind+2, b)+1) + (theta-ind)*mag;
	end
end

out_orient = orient/norm(orient);
	
end
