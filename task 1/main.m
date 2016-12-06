inputs = 2;
outputs = 100;
points = createPoints();

w = (0.6-0.4).*rand(outputs,inputs) + 0.4; %random weights


%--- Ordering phase ---
sigma0 = 100;
n0 = 0.1;
tau = 200;

sigma = sigma0;
n = n0;

for t=1:1000
    p = getRandomPattern(points)';
    w = updateWeight(w,sigma,p,n);

    sigma = rateUpdate(sigma0,t,tau);
    n = rateUpdate(n0,t,tau);
end

w2 = w;

subplot(1,2,1)
plot(w2(:,1),w2(:,2))
axis([0 1 0 1])
title('Weight vectors after "Ordering phase"')

hold on; %adding triangle lines
x = [0;0.5;1;0];
y = [0;sqrt(0.75);0;0];
plot(x,y)
hold off;

%--- Convergence phace ---
sigma = 0.9;
n = 0.01;

for t=1:50000

    p = getRandomPattern(points)';
    w = updateWeight(w,sigma,p,n);
end

w2 = w;

subplot(1,2,2)
plot(w2(:,1),w2(:,2))
axis([0 1 0 1])
title('Weight vectors after "Convergence phase"')

hold on; %adding triangle lines
x = [0;0.5;1;0];
y = [0;sqrt(0.75);0;0];
plot(x,y)
hold off;