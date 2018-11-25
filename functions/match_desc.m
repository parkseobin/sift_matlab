% -----------------------------------------
% Function for matching descriptors
% Matching with NNDR (d1 -> d2)
% -----------------------------------------
function matches = match_desc(d1, d2, threshold)

matches = [];
for i=1:size(d1, 2)
	f1 = 9999999999;
	f2 = 9999999999;
	for j=1:size(d2, 2)
		dist = d1(i).get_distance(d2(j));
		if(dist < f1)
			f2 = f1;
			f1 = dist;
			m = d2(j).Coordinates;
		elseif(dist < f2)
			f2 = dist;
		end
	end

	% matched
	if(f2 == 0)
		matches = [matches; d1(i).Coordinates m 0];
	elseif(f1/f2 < threshold)
		matches = [matches; d1(i).Coordinates m f1/f2];
	end
end


% function end
end
