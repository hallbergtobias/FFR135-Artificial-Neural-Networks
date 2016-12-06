function pointOk = inTriangle(x,y)
%Checks if point is inside triangle

pointOk = y<=yL(x) && y<=yR(x);

end

function y = yL(x)
    %Checks if beneath left side of triangle
    y = x*2*sqrt(0.75);
end

function y = yR(x)
    %Checks if beneath right side of triangle
    y = -x*2*sqrt(0.75)+2*sqrt(0.75);
end