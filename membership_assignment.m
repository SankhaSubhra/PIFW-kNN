function membership_assignment(train)
% Function for calculating membership values of each data-point for every
% labels. This functions basically cauculates U.

global k b membership

labels = train(:,size(train,2));
n = size(train,1);

% Assigning membership
distt = zeros(n,n);
for i = 1:n
    distt(i,:) = wtdistance(train,train(i,:))';
end

% Sort the points according to distance and find kNN
[~, Idx_sort] = sort(distt, 2);
kNN_labels = zeros(n,k);
for i = 1:n
    kNN_labels(i,:) = labels(Idx_sort(i,2:k+1));
end
edges = 1:b;
nnlabelsNum = histc(kNN_labels,edges,2);

% Calculation of membership values
membership = (0.49/k).*nnlabelsNum;
for i = 1:n
   membership(i,labels(i)) = membership(i,labels(i)) + 0.51;
end