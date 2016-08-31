function [value,isterminal,direction] = math4910_percentI(t,x, total_pop,percent)

value = x(4) - (percent*total_pop);
isterminal = 0;   
direction = 0;

end

