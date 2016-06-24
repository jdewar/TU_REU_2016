function [sensitivity] = chik_sensitivity_analysis(Q,params,param_name) %#ok<*INUSL>
%CHIK_SENSITIVITY_ANALYSIS sensitivity analysis, respect to Beta
params.(param_name) = params.(param_name);

epsilon = 0.01 * params.(param_name);
params1 = params;
params2 = params;

params1.(param_name) = params.(param_name) + epsilon;
params2.(param_name) = params.(param_name) - epsilon;

te1 = Q(params1);
te2 = Q(params2);
te3 = Q(params);

time = (te1-te2)/(2*epsilon);
sensitivity = time * params.(param_name)/te3;


end

