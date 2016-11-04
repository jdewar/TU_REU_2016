function [value,isterminal,direction] = balancing_event(t, Y, init_infected)
%CHIK_BALANCING_EVENT event halting at when reaching initial infected
value = Y(4) - init_infected; % infected at desired level
isterminal = 1; % stops graph when event is triggered
direction = 1; 
