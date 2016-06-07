function [value,isterminal,direction] = chik_balancing_event(t,out, init_infected)
%balancing_event gives correct initial conditions
value = out(3) - init_infected; %triggers event when infected ==1
isterminal = 1; %stops graph when event is triggered
direction = 1; 
end