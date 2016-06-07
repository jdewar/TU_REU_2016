function [value,isterminal,direction] = sir_10percentI(t,x, total_pop)
value = x(4) - 46600;%(.10*total_pop); 
isterminal = 0;   
direction = 0;
end