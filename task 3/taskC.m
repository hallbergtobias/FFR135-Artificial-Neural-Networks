%Calculated avarage classification error of main
%Runs k=1,...,20. For every k it runs 20 times, and calculated the avarage
%final classification error.

data = [];
for k=1:20
    k
    avg = 0;
    for l=1:5
        class = main(k,1);
        avg = avg + class/5;
        
    end
    data = [data;k avg];
end

plot(data(:,1),data(:,2),'ok')
xlabel('k')
ylabel('Classification error')
title('Network performance - avarage final classification error')