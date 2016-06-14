
%% Main script for running sir model

% Setting paramseters and initial conditions
close all; clc; clf; set(0,'DefaultFigureWindowStyle','docked');
addpath('../data');

country = 'Guadeloupe';
[real_data, pop, name, firstWeek] = get_data(country);

new_data = get_data(country,'linear_newinf');

init_infected_h = real(1);
tend = length(real);
total_pop_h = pop*.2;
min_K = pop *.5;
max_K = pop * 10;
tspan = firstWeek:7:(55*7);

%paramseters
field1 = 'beta_hv';  value1 = 0.24;
field2 = 'beta_vh';  value2 = 0.24;
field3 = 'gamma_h';  value3 = 1/6;
field4 = 'mu_h';     value4 = 1/(70*365);
field5 = 'nu_h';     value5 = 1/3;
field6 = 'psi_v';    value6 = 0.3;
field7 = 'mu_v';     value7 = 1/14;
field8 = 'nu_v';     value8 = 1/11;
field9 = 'sigma_h';  value9 = 19;
field10 = 'sigma_v'; value10 = 0.5;
field11 = 'H0';      value11 = total_pop_h;
field12 = 'min_K';     value12 = min_K;
field13 = 'max_K';     value13 = max_K;
field14 = 'init_infected'; value14 = init_infected_h;

params = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6,field7,value7,field8,value8,field9,value9,field10,value10,field11,value11,field12,value12,field13,value13,field14,value14);

field1 = 'K_v';  value1 = @chik_K_v;
functions = struct(field1,value1);

% test K_v
% display(functions.K_v(params.min_K,params.max_K,tspan));

array_names = {'beta_hv', 'beta_vh', 'gamma_h', 'mu_h', 'nu_h', 'psi_v', 'mu_v', 'nu_v', 'sigma_h', 'sigma_v', 'H0','min_K','max_K', 'init_infected'};
 
lb = [0.24,0.24,0,1/(70*365),1/3,.3,1/14,1/11,50  ,0.5, params.H0, params.min_K * .5, params.max_K * .5, params.init_infected];
ub = [0.24,0.24,1,1/(70*365),1/3,.3,1/14,1/11,100,0.5, params.H0, params.min_K * 10, params.max_K * 10, params.init_infected];

% plotting
figure()
init = chik_init_conditions(params, tspan);
[t_model,out_model] = chik_balanced_solve([0 400], init, params, functions);
plot_chik_model(t_model,out_model)

figure()
plot(0:1:365, chik_K_v(params.min_K, params.max_K, 0:1:365))
xlabel('Days'); ylabel('Mosquito Carrying Capacity'); title('Seasonal K_v')

figure()
chik_plot_data(real_data) % ?

% optimizing
nonlincon = @(x) chik_nonlincon_R0(x, array_names, functions, tspan(1));
% cumulative infected
% obj_fn1 = @(parray)chik_obj_fn(parray, real_data, array_names, tspan, functions);
% opt_params1 = optimizer(obj_fn1, nonlincon, lb, ub, params);
% 
% init = chik_init_conditions(opt_params1, t);
% [t,out] = chik_balanced_solve(tspan, init, opt_params1, functions);
% 
% figure()
% subplot(1,2,1)
% chik_plot_both(t,out,real_data);
% 
% subplot(1,2,2)
% chik_plot_both(t,out,new_data); % newly infected

% new infected
obj_fn2 = @(parray)chik_obj_fn(parray, new_data, array_names, tspan, functions);
opt_params2 = optimizer(obj_fn2, nonlincon, lb, ub, params);

init = chik_init_conditions(opt_params2, tspan);
[t,out] = chik_balanced_solve(tspan, init, opt_params2, functions);

%both
figure()
subplot(1,2,1)
chik_plot_both(t, out, real_data);

subplot(1,2,2)
chik_plot_both(t, out, new_data) % newly infected

%res
figure()
plot_chik_residual(t, out, new_data);

%mosq
figure()
plot_mosquito(t, out, real_data);


figure()
plot_chik_residual(t,out,real_data);

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
