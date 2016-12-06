function p = getRandomData(data)
%returns a random data row from data

s = size(data,1);
r = randi([1 s],1,1);
p = data(r,:)';

end