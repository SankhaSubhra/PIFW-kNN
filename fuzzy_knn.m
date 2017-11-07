function lab = fuzzy_knn(train,test)
% Function for getting labels using Fuzzy kNN

global k b membership

% Value of m variable.
m1 = 2;

% Finding the membership (V) of the test instances
Distance = wtdistance(train, test);
[d, idx] = sort(Distance);

test_fuzziness = zeros(b,1);
for i = 1:b
	sum2 = 0; sum1 = 0;
	for j = 1:k
		c = (d(j).^(1/(m1-1)));
		sum2 = sum2 + membership(idx(j),i)*(1/c);
		sum1 = sum1 + (1/c);
		
	end
	test_fuzziness(i,1) = sum2/sum1;
end

% Getting label from maximum vote of membership
[~, lab] = max(test_fuzziness);

end