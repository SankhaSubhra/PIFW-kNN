global b f k membership W 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A MATLAB implementation of PIFW-kNN.
% Written by: Nimagna Biswas and Saurajit Chakraborty.
% Reference: Nimagna Biswas, Saurajit Chakraborty, Sankha Subhra Mullick, 
% and Swagatam Das,A Parameter Independent Fuzzy Weighted k-Nearest Neighbor
% Classifier,Pattern Recognition Letters, November, 2017.
% 
% n is the number of instances, where each data point is d-dimensional real.
% Input:
% Features: data matrix: n*d.
% Labels: data class labels n*1.
% Output: 
% Mean accuracy and standard deviation of k-fold cross validation.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Temp_Features = Features;
Temp_Labels = Labels;

% Normalizing Features
max_x = max(Temp_Features,[],1);
min_x = min(Temp_Features,[],1);
Temp_Features = (Temp_Features-repmat(min_x,[size(Temp_Features,1),1]))./repmat(max_x-min_x,[size(Temp_Features,1),1]);

[~, ~, Temp_Labels] = unique(Temp_Labels);

dataset = [Temp_Features,Temp_Labels];

% Number of Labels
b = max(Temp_Labels);

% Number of Features
f = size(Temp_Features,2);

% Number of Fold
k_fold = 10; % Edit here for adjusting the fold value for cross validation.

% CV Partition
cv = cvpartition(size(dataset,1), 'kfold', k_fold);
acc = 0; answer = [];

for count = 1:k_fold
	
	matched = 0; unmatched = 0;
	
	trainMatrix = dataset(training(cv,count), : );
	testMatrix = dataset(test(cv,count), : );
	
	% Initialization weight matrix
	W = ones(b,f);
	
	% Initial Value of k
	k = floor(sqrt(size(dataset,1)));
	
	membership_assignment(trainMatrix);
	
	% Calling of SHADE
	shade(trainMatrix, count);
	
	% Prediction and checking of labels
	for i = 1:size(testMatrix,1)
		lab = fuzzy_knn(trainMatrix,testMatrix(i,:));
		if lab == testMatrix(i,size(testMatrix,2))
			matched = matched + 1;
		else
			unmatched = unmatched+1;
		end
	end
	
	% Calculating and printing the results for each run
	h = sprintf('Matched: %d',matched);
	disp(h);
	h = sprintf('Unmatched: %d',unmatched);
	disp(h);
	
	acc = matched/(matched+unmatched);
	acc = acc*100;
	h = sprintf('Accuracy: %.2f',acc);
	disp(h);
	
	h = sprintf('Value of K: %d',k);
	disp(h);
	disp('------------------------------');
	
	answer = [answer;acc];
end

% The Final Result
h = sprintf('Acc : %.2f (%.2f)',mean(answer),std(answer));
disp(h);
