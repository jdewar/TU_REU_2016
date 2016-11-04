function [t,out, te,ye,ie] = output(t_in, Y, param, options)

dydt_fn = @(t,Y) RHS_eq_oneGroup(t, Y, param);

if numel(options) ~= 0
    [t, out, te, ye, ie] = ode23s(dydt_fn, t_in, Y, options);
else
    
    [t, out] = ode23s(dydt_fn, t_in, Y);
end

end