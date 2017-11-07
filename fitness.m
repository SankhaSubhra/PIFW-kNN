function error = fitness(TR)
% Function to get fitness values

error = 0;

% Using leave-one-out cross-validation technique
for i = 1:size(TR,1)
	Bags = TR;
	Bags(i,:) = [];
	lab = fuzzy_knn(Bags, TR(i,:));
	if lab ~= TR(i,end);
		error = error+1;
	end
end
error = error/size(TR,1);