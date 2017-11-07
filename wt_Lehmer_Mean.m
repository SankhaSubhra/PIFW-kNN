function x=wt_Lehmer_Mean(A, df)
% Function to get weighted lehmar mean

wt = df/sum(df);
x = sum((A.*A).*wt)/sum(A.*wt);

end