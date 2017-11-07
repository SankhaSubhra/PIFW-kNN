function x=wt_Mean(A, df)
% Function to get weighted mean

wt = df/sum(df);
x = sum(A.*wt);

end