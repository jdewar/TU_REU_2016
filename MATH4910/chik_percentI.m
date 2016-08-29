function [value,isterminal,direction] = chik_percentI(t,x, total_pop,percent)

value = x(5) - (percent*total_pop);
isterminal = 0;   
direction = 0;

end

