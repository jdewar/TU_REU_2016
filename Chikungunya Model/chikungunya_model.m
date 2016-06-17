
%% Main script for running sir model

% Setting paramseters and initial conditions
close all; clc; clf; set(0,'DefaultFigureWindowStyle','docked');
addpath('../data');

country = 'Columbia';
[real, pop, name, firstWeek] = get_data(country);

%new_data = get_data(country,'linear_newinf');
init_infected_h = real(1);
tend = length(real);
total_pop_h = pop;
%min_K = pop *.5;
max_K = pop * 10;
tspan = (firstWeek*7):7:(55*7); % tspan not size of real data


param_struct = ...
    {'beta_hv', 0.24;
     'beta_vh', 0.24;
     'gamma_h', 1/6;
     'mu_h', 1/(70*365);
     'nu_h', 1/3;
     'psi_v', 0.3;
     'mu_v', 1/14;
     'nu_v', 1/11;
     'sigma_h', 19;
     'sigma_v', 0.5;
     'H0', total_pop_h;
     'prop_K', 1;
     'max_K', max_K;
     'init_cumu_infected', init_infected_h;
    }';
params = struct(param_struct{:});
array_names = param_struct(1,:);

%params = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6,field7,value7,field8,value8,field9,value9,field10,value10,field11,value11,field12,value12,field13,value13,field14,value14);

field1 = 'K_v';  value1 = @chik_K_v;
functions = struct(field1,value1);

% test K_v
% display(functions.K_v(params.min_K,params.max_K,tspan));
 
lb = [0.24,0.24,1/6,1/(70*365),1/3,.3,1/14,1/11,.1,0.5, params.H0, params.prop_K*.01, params.max_K, .001];
ub = [0.24,0.24,1/6,1/(70*365),1/3,.3,1/14,1/11,50,0.5, params.H0, params.prop_K, params.max_K*10, mean(real)* .95];

%plotting
% figure()
% init = chik_init_conditions(params, tspan);
% [t_model,out_model] = chik_balanced_solve([0 400], init, params, functions);
% plot_chik_model(t_model,out_model)


% figure()
% plot(0:1:365, chik_K_v(params.min_K, params.max_K, 0:1:365))
% xlabel('Days'); ylabel('Mosquito Carrying Capacity'); title('Seasonal K_v')

% figure()
%  chik_plot_data(real) % ?

% optimizing


% cumulative infected
obj_fn1 = @(parray)chik_obj_fn(parray, real, array_names, tspan, functions);
opt_params1 = optimizer(obj_fn1, lb, ub, params)

init = chik_init_conditions(opt_params1, tspan);
[t,out] = chik_balanced_solve(tspan, init, opt_params1, functions);
[rate_vh, rate_hv] = chik_calc_biting_rates(opt_params1, out);

figure()
% % subplot(1,2,1)
chik_plot_both(t, out, real);
drawnow
% 
% 
% subplot(1,2,2)
%chik_plot_both_NewlyInfected(t,out,new_data);% newly infected

% new infected
% obj_fn2 = @(parray)chik_obj_fn(parray, new_data, array_names, tspan, functions);
% opt_params2 = optimizer(obj_fn2, nonlincon, lb, ub, params)
% 
% init = chik_init_conditions(opt_params2, tspan);
% [t,out] = chik_balanced_solve(tspan, init, opt_params2, functions);
% 
% %both
% figure()
% subplot(1,2,1)
% chik_plot_both(t, out, real_data);
% 
% subplot(1,2,2)
% chik_plot_both_NewlyInfected(t,out,new_data) % newly infected
% range = linspace(lb(14), ub(14), 40);
% chik_plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, tspan, functions, 'init_cumu_infected', range)

%res
% figure()
% plot_chik_residual(t, out, new_data);

%mosq
% figure()
% plot_mosquito(t, out, real_data);
% 
% 
% figure()
% plot_chik_residual(t,out,real_data);

% figure()
% plot_susceptible_proportions(params, real_data, t, lb, ub, functions) % this won't work given balancing errors
% 
% total_infected = chik_cumu_infect_real(real_data)
% time = chik_percent_real(real_data, .1, total_infected)
% hold on
% chik_plot_data(real_data)
% plot(time,real(time),'o');
% 
% figure()
% country_names = {'Saint Martin', 'Saint Barthelemy', 'Saint Kitts and Nevis', 'Antigua', 'Monserrat', 'Guadeloupe','Anguilla'};
% country_epstart(country_names)
% 
% figure()
% country_names = {'Guadeloupe','Dominica','Martinique','Saint Lucia','Barbados','Saint Vincent and the Grenadines','Grenada','French Guiana'};
% country_epstart(country_names)
% 
% figure()
% country_names = { 'Saint Martin', 'Saint Barthelemy','Guadeloupe'};
% country_epstart(country_names)
% country_names = { 'Saint Martin', 'Saint Barthelemy','Guadeloupe', 'Dominica','Dominican Republic','Martinique','French Guiana'};
% country_epstart(country_names)

% Q1 = @(params)chik_Q_cumu_infect (params, out, t, functions);
% Q2 = @(params)chik_Q_time_to_percent(params,out(end,5), tspan,init, .01, functions);
% Q3 = @(params)chik_obj_fn(struct2array(params, array_names), real, array_names, tspan, functions);
% figure()
% chik_plot_contour(Q3,opt_params1,linspace(1,200,40), linspace(1, 20, 40));

