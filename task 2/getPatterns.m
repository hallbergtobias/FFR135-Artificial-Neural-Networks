function patterns = getPatterns()
%returns patterns

A = getWineData();
A(:,1) = []; %remove first column

%normalization for each column
for col=1:size(A,2)
    A(:,col)=A(:,col)-mean(A(:,col)); %zero mean
    A(:,col)=A(:,col)/std(A(:,col)); %unit variance
end


patterns = A;

end

