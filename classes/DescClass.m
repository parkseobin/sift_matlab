classdef DescClass < handle
	properties
		% 128xN sized tensor
		Descriptors
		Coordinates
	end
	methods

		% Constructor function
		function obj = DescClass(val)
			obj.Descriptors = [];
		end

		function trash = add_desc(obj, new_desc)
			% normalize new descriptor
			new_desc = new_desc/norm(new_desc);
			obj.Descriptors = [obj.Descriptors; new_desc];
			trash = [];
		end

		function trash = set_coordinates(obj, x, y)
			obj.Coordinates = [x, y];
			trash = [];
		end

		% Computing L2 distance
		% 	choose the min distance among
		%	multiple descriptors
		%	
		function distance = get_distance(obj, obj2)
			D1 = obj.Descriptors;
			D2 = obj2.Descriptors;
			d1_size = size(D1, 1);
			d2_size = size(D2, 1);

			dists = zeros(d1_size, d2_size);

			for i=1:d1_size
				for j=1:d2_size
					dists(i, j) = norm(D1(i,:)-D2(j,:));
%					dists(i, j) = acos(dot(D1(i,:), D2(j,:)));
				end
			end
			distance = mean(mink(dists(:), max(d1_size, d2_size)));
			
		% function end
		end
	end
end
