function [t,out, te,ye,ie] = chik_output(t_in, Y, param, options, functions)

dydt_fn = @(t,Y) chikungunya_rhs(t, Y, param, functions);

if numel(options) ~= 0
    [t, out, te, ye, ie] = ode23s(dydt_fn, t_in, Y, options);
else
    
    [t, out] = ode23s(dydt_fn, t_in, Y);
end

end