function ode_fn = make_ode(params)

% This function creates a function that evaluates the right hand side of an ODE, given t and y as input.
%  the params passed may be a struct [params.alpha], or array [params(1) % alpha]
%  the function that is returned has constant access to the params.
% If you want to make a new ODE with different params, run make_ode again, and use the new dydt_fn.

ode_fn = @myode;

function dydt = myode(t, x)

S = x(1);
I = x(2);
R = x(3);

dydt(1) = params.alpha * S * I ;
dydt(2) = params.alpha * S * I - params.beta * I;
dydt(3) = params.beta * I;

dydt=dydt'; % must return column vector for matlab ode integrators

end

end
