function answer = main()
%2D Kohonen network

inputs = 13; %13 parameters
outputs = 400;

patterns = getPatterns(); %normalized wine data

w = rand(outputs,inputs);

%--- Ordering phase ---
sigma0 = 30;
n0 = 0.1;
tau = 300;

sigma = sigma0;
n = n0;

f1 = 10;
f2 = 12;

for t=1:1000
    p = getRandomPattern(patterns)';
    w = updateWeight(w,sigma,p,n);

    sigma = rateUpdate(sigma0,t,tau);
    n = rateUpdate(n0,t,tau);
    
    if(mod(t,200)==0)
        data = w;
        
        subplot(2,2,1)
        plotData(data,f1,f2)
    end
end


%--- Convergence phace ---
sigma = 0.9; %0.9
n = 0.01; %0.01

for t=1:20000
    p = getRandomPattern(patterns)';
    w = updateWeight(w,sigma,p,n);
    
    if(mod(t,2000)==0)
        data = w;
        
        subplot(2,2,2)
        plotData(data,f1,f2)
    end
    
end

%Color each input depending on wine class
s = size(patterns,1);
data = zeros(s,inputs);
for t=1:s
    p = patterns(t,:);
    distances = sqrt(sum(bsxfun(@minus,w',p').^2,1))';
    winner = find(distances==min(distances));
    data(t,:) = w(winner,:);
end    s

%Break data into the three wine classes
data1 = data(1:59,:);
data2 = data(60:130,:);
data3 = data(131:178,:);

subplot(2,2,3)
plot(data1(:,f1),data1(:,f2),'r*')
hold on;
plot(data2(:,f1),data2(:,f2),'g*')
plot(data3(:,f1),data3(:,f2),'b*')
hold off;
xlabel(['Attribute ' int2str(f1)])
ylabel(['Attribute ' int2str(f2)])
title('All wines being fed once')
legend('Class 1','Class 2','Class 3')


f1=7;
f2=13;

subplot(2,2,4)
plot(data1(:,f1),data1(:,f2),'r*')
hold on;
plot(data2(:,f1),data2(:,f2),'g*')
plot(data3(:,f1),data3(:,f2),'b*')
hold off;
xlabel(['Attribute ' int2str(f1)])
ylabel(['Attribute ' int2str(f2)])
title('All wines being fed once')
legend('Class 1','Class 2','Class 3')

std(data);

end

function answer = plotData(data,f1,f2)
        plot(data(:,f1),data(:,f2),'.b')
        hold on;        
        for z=1:20
            plot(data(z*20-19:z*20,f1),data(z*20-19:z*20,f2),'k','linewidth',0.5)
            for z2=1:19
                plot([data(z2*20-(20-z),f1) data((z2+1)*20-(20-z),f1)],[data(z2*20-(20-z),f2) data((z2+1)*20-(20-z),f2)],'k','linewidth',0.5)
            end
        end

        hold off;
        xlabel(['Attribute ' int2str(f1)])
        ylabel(['Attribute ' int2str(f2)])
        drawnow
end