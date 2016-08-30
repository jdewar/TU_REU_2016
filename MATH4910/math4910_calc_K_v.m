function K_v = math4910_calc_K_v(params, functions, t)
%CHIK_CALC_K_V Return current K_v given params and a scalar time

K_v = functions.K_v(params.prop_K, params.max_K, t);

end