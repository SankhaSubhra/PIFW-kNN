function y = cauchy_rand(a, b, n)
% Cauchy Random function

y = a + b*tan(pi*(rand(1,n)-0.5));
end