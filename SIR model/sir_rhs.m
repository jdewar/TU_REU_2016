function [out] = sir_rhs( t, init, param)
% sir_rhs defines the ode for a simple SIR model
% parameters are set
    %Input param:
        %t is time
        %init is initial conditions column vector
        %beta  is probability of transmission
        %c is contact rate
    %Output:
        %out is the suceptible and infected array
        
out = zeros(size(init));
s = init(1);%Susceptible
i = init(2);%Infected
r = init(3);%Recovered
cumulative_i = init(4);%Cumulative infected count

N = s+i+r; % total population
lambda = param.beta * param.c * (i/N);

out(1) = -lambda * s; % change in susceptible
out(2) = lambda * s - param.gamma * i;% change in infected
out(3) = param.gamma * i;% change in recovered
out(4) = lambda * s; %change in cumulative infected

end
