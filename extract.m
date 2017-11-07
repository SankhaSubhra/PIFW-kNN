function parameter = extract(data)
% Funtion to extract data (W and k) from the chromosome

global b f

parameter.k = data(end);
if parameter.k<=0
    parameter.k=eps;
elseif parameter.k>1
    parameter.k=1;
end
data(end) = [];

W = reshape(data', [f,b])';
% Normalization of feature weights. 
minW=min(W, [], 2);
maxW=max(W, [], 2);
adjust=maxW-minW;
for i=1:b
    W(i, :)=(W(i, :)-minW(i))./adjust(i);
end
parameter.W = W;

end