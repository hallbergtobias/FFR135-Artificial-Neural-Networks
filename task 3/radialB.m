function g = radialB(x, w)
%radial basis function gj(x)
%x is a vector
%w is weights
a = sqrt(sum(bsxfun(@minus, w', x').^2,2));
b = exp(-a.^2/2);
c = sum(b);
g = b/c;
end