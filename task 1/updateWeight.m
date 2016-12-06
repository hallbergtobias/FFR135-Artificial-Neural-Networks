function w = updateWeight(w,sigma,p,n)
%Updates weights using Kohonens algorithm. One dimension.
%w - weights
%sigma - width
%p - a pattern
%n - learning rate

distances = sqrt(sum(bsxfun(@minus,w',p').^2,1))';
winner = find(distances==min(distances)); %index of winner
closest = w(winner,:);

distances = abs((1:size(w,1))'-winner);
%distances = sqrt(sum(bsxfun(@minus,w',closest').^2,1))';

neighbourhood = exp((-distances.^2)/(2*sigma^2)); %neighbourhoodfunc
b = bsxfun(@minus,p,w); %(inputj - wij)
dW = n*bsxfun(@times,neighbourhood,b); %(neigh(i,i*)(inputj - wij)

w = w + dW;

end