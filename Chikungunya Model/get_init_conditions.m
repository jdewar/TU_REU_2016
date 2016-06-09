function [init] = get_init_conditions(param, t)
K_v = chik_K_v(param.min_K,param.max_K, t(1));
init = [param.H0 - param.init_infected;0;param.init_infected;0;param.init_infected;K_v;0;0;0];

end

