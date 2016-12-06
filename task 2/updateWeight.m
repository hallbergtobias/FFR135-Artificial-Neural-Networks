function w = updateWeight(w,sigma,p,n)
%Updates weights using Kohonens algorithm
%w - weights
%sigma - width
%p - a pattern
%n - learning rate

distances = sqrt(sum(bsxfun(@minus,w',p').^2,1))';
winner = find(distances==min(distances)); %index of winner
closest = w(winner,:);

m = 20;

row = mod(winner-1,m) + 1;
col = (winner - row)/m + 1;

distances = euclidian(row,col,m);

neighbourhood = exp((-distances.^2)/(2*sigma^2)); %neighbourhoodfunc
b = bsxfun(@minus,p,w); %(inputj - wij)
dW = n*bsxfun(@times,neighbourhood,b); %(neigh(i,i*)(inputj - wij)

w = w + dW;

end


function distances = euclidian(row,col,m)
    r1 = mod((0:400-1)',m)+1;
    c1 = floor((0:400-1)/m)'+1;
    distances = sqrt(sum(bsxfun(@minus, [r1 c1], [row col]).^2,2));
end

function distances = manhattan(row,col,m)
    B=ones(1,m)'*(1:m);
    C = abs(zeros(m,m) - abs(B-row)' - abs(B-col));
    distances = C(:);
end