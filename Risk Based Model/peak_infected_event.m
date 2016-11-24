function [value,isterminal,direction] = peak_infected_event(t, Y, P)
derivatives = RHS_eq_twoGroup(t,Y, P);
value = derivatives(3); % dI/dt = 0
isterminal = 0; % stops graph when event is triggered
direction = 1; 
