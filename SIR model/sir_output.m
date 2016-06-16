function [t,out, te, ye, ie] = sir_output(t_in, Y, param, options)
solver = @ode45;
if numel(options) ~=0
 [t,out, te, ye, ie] = solver(@(t,Y)sir_rhs(t,Y,param),t_in, Y, options);
else
  [t,out] = solver(@(t,Y)sir_rhs(t,Y,param),t_in, Y); 
end
 
end