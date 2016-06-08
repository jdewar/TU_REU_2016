function [difference, q_val] = chik_sensitivity_analysis(Q,params,param_name) %#ok<*INUSL>
%sensativity analysis, respect to Beta
params.(param_name) = params.(param_name);

epsilon = 0.001 * params.(param_name);
params1 = params;
params2 = params;

params1.(param_name) = params.(param_name) + epsilon;
params2.(param_name) = params.(param_name) - epsilon;

q1 = Q(params1);
q2 = Q(params2);
q3 = Q(params);

q_val = (q1-q2)/(2*epsilon);
difference = q_val * params.(param_name)/q3;


end

