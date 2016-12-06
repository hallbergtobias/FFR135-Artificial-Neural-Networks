function triangle = createPoints()
%Creates points inside a triangle with sides 1

triangle=zeros(1000,2);

size = 0;
while(size<1000)
    p = rand(1,2); %a point in unit square
    
    if(inTriangle(p(1,1),p(1,2)))
        triangle(size+1,:)=p;
        size = size +1;
    end 
end
end