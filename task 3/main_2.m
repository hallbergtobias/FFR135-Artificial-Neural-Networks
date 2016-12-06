function answer = main(k)
%A hybrid earning algorithm


inputs=2;

data = getPatterns();
patterns = [data(:,2) data(:,3)];


w = ((1--1).*rand(k,inputs) -1)'; %weights between 1 and -1

%Unsupervised part
n=0.02;
for t=1:50000 %50000
    x = getRandomData(patterns);
    w = updWeightUnsup(x,w,n);
    if t==5000
        w;
    end
    
    %plot stuff
    if(mod(t,500)==0)
        subplot(1,2,1)
        plot(patterns(1:1000,1), patterns(1:1000,2),'.b')
        hold on
        plot(patterns(1001:2000,1), patterns(1001:2000,2),'.r')

        plot(w(1,:)',w(2,:)','*k')
        hold off;
        %xlabel('x1')
        %ylabel('x2')
        %title('Weights and input')
        %legend('+1','-1','Weight vectors')
        drawnow
    end
end

%validation and training sets
val = [];
tra=data;
s=2000;
for i=1:600 %0,3*2000
    r = randi([1 s],1,1);
    val = [val;tra(r,:)];
    tra(r,:)=[];
    s=s-1;
end


outputs=1;

%random weights and thresholds between 1 and -1
w2 = ((1--1).*rand(outputs,k) -1)'; 
th = ((1--1).*rand(1,1) -1); 

%Supervised part
n=0.1;
beta = 1/2;

for t=1:3000
    
    d = getRandomData(tra)';
    x = [d(:,2) d(:,3)]';
    target = d(:,1);
    
    V=radialB(x,w);
    
    b = w2'*V - th;
    O = tanh(beta*b);
    gPrime = beta*(1-tanh(beta*O).^2);
    err = gPrime*(target-O);
    
    dw = n*err*V;
    dth = -n*err;
    th = th + dth;
    
    w2=w2+dw;
    
    if(mod(t,1000)==0)
        w2;
    end
    
end


subplot(1,2,2)
plot(patterns(1:1000,1), patterns(1:1000,2),'.b')
hold on
plot(patterns(1001:2000,1), patterns(1001:2000,2),'.r')
plot(w(1,:)',w(2,:)','*k')

function O = f(x2,x1)

    x = [x1; x2];

    V=radialB(x,w);

    b = w2'*V + th;
    O = tanh(beta*b);

end

dec = [];
for i=-15:25
    x1=i;
    x2=0;
    fun = @(x2) f(x2,x1);
    z = fzero(fun,x2,x1);
    
    dec = [dec;x1 z];

end

plot(dec(:,1),dec(:,2),'k')

hold off

xlabel('x1')
ylabel('x2')
axis([-15 25 -10 15])
title('Weights and input after classification')
legend('+1','-1','Weight vectors','Decision boundary')


end

