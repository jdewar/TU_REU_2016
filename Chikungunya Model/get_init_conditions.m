function [init] = get_init_conditions( param)

init = [param.H0 - param.init_infected;0;param.init_infected;0;param.init_infected;param.K_v;0;0;0];

end

