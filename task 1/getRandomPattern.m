function p = getRandomPattern(patterns)
%returns a random pattern from patterns

s = size(patterns,1);
r = randi([1 s],1,1);
p = patterns(r,:)';

end