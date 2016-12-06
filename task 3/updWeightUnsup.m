function w = updWeightUnsup(x,w,n)
%Updates weights for the unsupervised part
%x - input pattern
%w - weights
%n - learning rate

g = radialB(x,w); %radial basis

%find winning unit
winner = find(g==max(g)); %index of winner

k = size(w,2);
dw = zeros(2,k);
dw(:,winner)= n*(x-w(:,winner));

w = w + dw; %update weight
end