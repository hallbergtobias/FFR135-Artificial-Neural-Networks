function answer = main(k,runs)
%A hybrid learning algorithm
%k - number of radial basis functions
%runs - number of runs we should do. 
%Returns minimal classification error and plots

inputs=2;

data = getPatterns();
patterns = [data(:,2) data(:,3)];

classificationError = 1;

%final w, V, w2, th
fW = [];
fV = [];
fW2 = [];
fTh = 0;
fP1 = [];
fP2 = [];


for l=1:runs
    
    w = ((1--1).*rand(k,inputs) -1)'; %weights between 1 and -1

    %Unsupervised part
    n=0.02;
    for t=1:50000 %50000
        x = getRandomData(patterns);
        w = updWeightUnsup(x,w,n);
        if t==5000
            w;
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


    %classification/validation
    errors = 0;
    p1 = []; %points classified as -1
    p2 = []; %points classified as +1

    for t=1:size(val,1)

        d = val(t,:);
        x = [d(:,2) d(:,3)]';
        target = d(:,1);
        V=radialB(x,w);
        b = w2'*V + th;
        O = tanh(beta*b);

        if~(target==sign(O))
            errors = errors +1;
        end

        if(O<0)
            p1 = [p1; val(t,:)];
        else
            p2 = [p2; val(t,:)];
        end
    end

    %percentCorr = ok/600
    classError = errors/600
    
    if(classError<classificationError)
        classificationError = classError;
        fW = w;
        fV = V;
        fW2 = w2;
        fTh = th;
        fP1 = p1;
        fP2 = p2;
    end
    
end

w = fW;
V = fV;
w2 = fW2;
th = fTh;
p1 = fP1;
p2 = fP2;


subplot(1,2,1);
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
xlabel('x_{1}')
ylabel('x_{2}')
axis([-15 25 -10 15])
title(['Input and decision boundary at k = ' int2str(k)])
legend('Input class +1','Input class -1','Weight vectors','Decision boundary')


subplot(1,2,2);
if~(size(p2,1)*size(p1,1)) %if all patterns are classified to one input
    if~(size(p2,1)) %all patterns are -1
        plot(p1(:,2),p1(:,3),'or')
        hold on
        plot(dec(:,1),dec(:,2),'k')
        hold off
        legend('Input classified as -1','Decision boundary')
    end
    
    if~(size(p1,1)) %all patterns are +1
        plot(p2(:,2),p2(:,3),'ob')
        hold on
        plot(dec(:,1),dec(:,2),'k')
        hold off
        legend('Input classified as +1','Decision boundary')
    end
    
else %patterns are classified both to +1 and -1
    plot(p2(:,2),p2(:,3),'ob')   
    hold on
    plot(p1(:,2),p1(:,3),'or')
    plot(dec(:,1),dec(:,2),'k')
    hold off
    legend('Input classified as +1','Input classified as -1','Decision boundary')
end


xlabel('x_{1}')
ylabel('x_{2}')
axis([-15 25 -10 15])
title(['Classified input and decision boundary at k = ' int2str(k)])

answer = classificationError;

end