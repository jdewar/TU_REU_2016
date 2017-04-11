%% Main script for running model with no and high risk groups and no behavior change
close all; 
addpath('../data_chik');
country = 'Guadeloupe';
[real2014, pop, name, firstWeek2014] = get_data(country);
full_count = real2014;
real = full_count;
init_infected_h = real(1);
tend = length(real);
tspan = [(firstWeek2014)*7:7:((tend+firstWeek2014-1)*7)];
tend = (tend+firstWeek2014-1);

%switch L_MODEL
%CASE 'SINGLE'
%CASE 'DOUBLE'
%commit
%make struct with model and params
%% Parameter values

param_struct = ...
    {'beta_h', 0.24;
     'beta_v', 0.24;
     'gamma_h', 1/6;
     'mu_h', 1/(70*365);
     'nu_h', 1/3;
     'psi_v', 0.3;
     'mu_v', 1/17;
     'nu_v', 1/11;
     'sigma_h1', 10; %low risk contacts
     'sigma_h2', 30; %high risk contacts
     'sigma_v', 0.5;
     'H0', pop;
     'theta1', .3; %proportion of population in group 1 - low risk
     'theta2', .7;% proportion of population in group 2 - high risk
     'theta0', .8; % no risk group
     'init_cumulative_infected', init_infected_h;
     'K_v' , pop * 2;
     'pi1', 0.1; %proportion that continues to be bitten in infected group 1
     'pi2', 0.4; %proportion that continues to be bitten in infected group 2
    }';
params = struct(param_struct{:});
array_names = param_struct(1,:);
params.H0 = params.H0 * (1 - params.theta0);
%% Plot Cumulative vs. Newly Infected
%  figure()
%  subplot(1,2,1)
%  plot_data(full_count, tspan_full_count)
% 
% subplot(1,2,2)
% newly_infected = get_newly_infected_count(real);
% plot(tspan,newly_infected)

%% Plot ODE Solutions

%  params.H0 =  10000;
%  params.K_v = 100000;
% 
%  params.init_cumulative_infected = 1;
% init = ...
%     [params.H0 * params.theta1 - params.init_cumulative_infected*params.theta1,
%     params.H0 * params.theta2 - params.init_cumulative_infected*params.theta2,
%     params.init_cumulative_infected * params.theta1,
%     params.init_cumulative_infected * params.theta2,
%     0,
%     0,
%     params.init_cumulative_infected * params.theta1,
%     params.init_cumulative_infected * params.theta2,
%     params.K_v,
%     0,
%     0];

% params
% [t_model,out_model] = balance_and_solve([0:400], init, params);
% R01 = calc_R0(params, out_model(1,:))
% Reff = calc_Reff(params, out_model, t_model)
% [peak] = get_peak_infected(out_model)
% total = out_model(end,7) + out_model(end,8)
% plot_Reff(t_model,out_model,params);
% plot_model(t_model,out_model)
% figure()
% plot(t_model,out_model(:,3))
% figure()
% plot(t_model,out_model(:,4))


% [peak] = get_peak_infected(out_model)
% total = out_model(end,7) + out_model(end,8)
% plot_Reff(t_model,out_model,params);
% plot_model(t_model,out_model);
% %sensitivity_time(params, out_model, t_model)

%% Optimization & Plot - Original Obj Fn
lb = struct2array(params,array_names);
ub = struct2array(params,array_names);


% [lb, ub] = range(lb, ub, 'sigma_h1', .1, 5, array_names);
% [lb, ub] = range(lb, ub, 'sigma_h2', 5, 50, array_names);
%[lb, ub] = range(lb, ub, 'theta0', .6, .9, array_names);
 [lb, ub] = range(lb, ub, 'theta2', .01, .8, array_names);
 %[lb, ub] = range(lb, ub, 'theta1', 1-params.theta2, 1-params.theta2, array_names);
 [lb, ub] = range(lb, ub, 'init_cumulative_infected', params.init_cumulative_infected * 0.1, params.init_cumulative_infected * 10, array_names);
 [lb, ub] = range(lb, ub, 'K_v', params.H0, params.H0 * 10, array_names);
 [lb, ub] = range(lb, ub, 'pi1', .001, .5, array_names);
 [lb, ub] = range(lb, ub, 'pi2', .001, .8, array_names);
 %[lb, ub] = range(lb, ub, 'H0', params.H0 *0.1, params.H0, array_names);

%  I* from integrating steady state

% c = 1;
% for i = 1:length(lb)
%     if lb(i) ~= ub(i)
%         optimized{c} = array_names{i};
%         c = c+1;
%     end
% end
% optimized;

% 
obj_fn1 = @(parray)obj_fn(parray, real, array_names, tspan, get_init_conditions(params, 0));
[opt_params1,fval,grad,hes] = optimizer(obj_fn1, lb, ub, params);
opt_params1.theta1 = 1 - opt_params1.theta2;

init1 = get_init_conditions(opt_params1, 0);
[t1,out1] = balance_and_solve(tspan, init1, opt_params1);

% opt_params1.theta2 = (1 - opt_params1.theta0) * opt_params1.theta2;
% opt_params1.theta1 = 1-(opt_params1.theta2 + opt_params1.theta0);
% opt_params1
 
R01 = calc_R0(opt_params1, out1(1,:))
Reff1 = calc_Reff(opt_params1, out1(30,:))
%Rinf = calc_Rinf(opt_params1, out1(end,:))
%peak = get_peak_infected(out1);


% figure()
% plot_model(t1, out1)
figure()
plot_both(t1, out1, tspan, real);
drawnow

opt_params1
%  figure()
%  plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, t1, 'theta2', .1, 1);
%  
%  figure()
%  plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, t1, 'pi2', .01, 1);

% R01 = calc_R0(opt_params1, out1(1,:))
% Reff = calc_Reff(params, out_model(1,:))
% [peak] = get_peak_infected(out_model)
% bT = calc_b_T(params, init)
% out_model(end,4)
% plot_Reff(t_model,out_model,params);
% plot_model(t_model,out_model)
% drawnow
% figure()
% plot(t_model,out_model(:,2))
%% Compare ChikV and Zika
opt_params1.pi1 = 0.8;
opt_params1.pi2 = 1;
init1 = get_init_conditions(opt_params1, tspan);
[t2,out2] = balance_and_solve([0 tspan], init1, opt_params1);
R02 = calc_R0(opt_params1, out2(1,:))
Reff2 = calc_Reff(opt_params1, out1(30,:))
figure()
plot_two_models(t1,out1,t2,out2,real)
% comparing models - sum squared
difference = cmp_models(out1,out2, real)
%% Plot Objective Functions
% figure()
% r = linspace(lb(9), ub(9), 100);
% [param,val] = plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, tspan, 'sigma_h1', r);
% 
% figure()
% r = linspace(lb(10), ub(10), 100);
% [param,val] = plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, tspan, 'sigma_h2', r);
% 
% figure()
% r = linspace(lb(15), ub(15), 100);
% [param,val] = plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, tspan, 'init_cumulative_infected', r);
% 
% figure()
% r = linspace(lb(13), ub(13), 100);
% [param,val] = plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, tspan, 'theta1', r);
% 
% figure()
% r = linspace(lb(14), ub(14), 100);
% [param,val] = plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, tspan, 'theta2', r);
% 
% figure()
% r = linspace(lb(16), ub(16), 100);
% [param,val] = plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, tspan, 'K_v', r);


