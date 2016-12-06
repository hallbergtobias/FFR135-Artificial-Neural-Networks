function answer = rateUpdate(x0,t,tau)
%update function for learning rate and width

answer = x0*exp(-t/tau);

end