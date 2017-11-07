function dist = wtdistance(Train, Test)
% Function to get weighted distance

global W 

Test(:,end) = [];

% Preprocessing data
Labels = Train(:,end);
Train(:,end) = [];

% Getting weighted distance
Test = repmat(Test, [size(Train,1),1]);
Test = abs(Test-Train);
Test = Test.*Test;

for i = 1:size(Train,1)
	Test(i,:) = Test(i,:).*W(Labels(i),:);
end

dist = sum(Test,2);