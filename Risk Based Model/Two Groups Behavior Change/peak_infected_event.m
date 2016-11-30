function [value,isterminal,direction] = peak_infected_event(t, Y, P)
derivatives = RHS_eq_twoGroup(t,Y, P);
if ((derivatives(2) < abs(0.01)))
    value = 0;
else
    value = derivatives(2); % dI/dt = 0
end
isterminal = 0; % stops graph when event is triggered
direction = 1; 
