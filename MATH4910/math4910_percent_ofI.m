function [value,isterminal,direction] = math4910_percent_ofI(t,x,percent,total_infected)

value = x(5) - (percent* total_infected);
isterminal = 0;
direction = 0;

end
