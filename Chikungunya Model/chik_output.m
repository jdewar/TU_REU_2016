function [t,out, te,ye,ie] = chik_output(t_in, Y, param, options, functions)
if numel(options) ~= 0
 [t,out, te,ye,ie] = ode45(@(t,Y)chikungunya_rhs(t,Y,param, functions),t_in, Y, options);
else
    [t,out] = ode45(@(t,Y)chikungunya_rhs(t,Y,param, functions),t_in, Y, options);
end
end