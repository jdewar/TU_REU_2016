
%%% Main script for running sir model

%% Setting parameters and initial conditions
close all;

[real,pop,name] = get_data('Guadeloupe');
init_infected_h = real(1);
tend = length(real);
total_pop_h = pop*.20;
min_K = pop *.5;
max_K = pop * 10;

%parameters
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


param = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5, value5, field6,value6,field7,value7, field8,value8,field9,value9,field10,value10, field11,value11, field12,value12,field13,value13, field14,value14);

field1 = 'K_v';  value1 = @chik_K_v;
functions = struct(field1,value1);

functions.K_v(param.min_K,param.max_K,[0:7:(tend*7)]);

%chik_optimize_subset(param)

%initial conditions
init = get_init_conditions(param, [0:7:(tend*7)]);

%% solving


% plotting
% figure(1)
% [t_model,out_model] = chik_balanceANDsolve([0 400], init, param);
% 
% plot_chik_model(t_model,out_model)
% 
% 
% figure(2)
%  plot([0:1:365],chik_K_v(min,max,[0:1:365]))


% figure(3)
% 
%  chik_plot_data(real)
% 
% 
% 
% % figure(4)
% % subplot(1,2,1)
[t,out] = chik_balanceANDsolve([0:7:(tend*7)], init, param, functions);
% 
% chik_plot_both(t,out,real);
% 
array_names = {'beta_hv', 'beta_vh', 'gamma_h', 'mu_h', 'nu_h', 'psi_v', 'mu_v', 'nu_v', 'sigma_h', 'sigma_v', 'H0','min_K','max_K', 'init_infected'};
 
lb = [0.24,0.24,0,1/(70*365),1/3,.3,1/14,1/11,50  ,0.5, param.H0, param.min_K * .5, param.max_K * .5, param.init_infected*.5];
ub = [0.24,0.24,1,1/(70*365),1/3,.3,1/14,1/11,100,0.5, param.H0, param.min_K * 10, param.max_K * 10, param.init_infected*10];
 
% param1 = optimizer(real,lb,ub, param, array_names, t, functions)
% 
% init = get_init_conditions(param1, t);
% [t,out] = chik_balanceANDsolve([0:7:tend*7], init, param1, functions);
% 
% figure(1)
% subplot(1,2,1)
% chik_plot_both(t,out,real);
% 
% subplot(1,2,2)
% chik_plot_both_newlyInfected(t,out,real)

%optimizing new infected
param2 = optimizer_newInfected(real,lb,ub, param, array_names, t, functions)



init = get_init_conditions(param2, t);
[t,out] = chik_balanceANDsolve([0:7:tend*7], init, param2, functions);

figure(2)
subplot(1,2,1)
chik_plot_both(t,out,real);

subplot(1,2,2)
chik_plot_both_newlyInfected(t,out,real)


% 
% param
% 
% % figure(5)
% % plot_chik_residual(t,out,real);
% 
% 
%  figure(2)
% plot_susceptible_proportions(param,real,array_names, t, lb,ub, functions)

% total_infected = chik_cumu_infect_real(real)
% time = chik_percent_real(real, .1, total_infected)
% hold on
% chik_plot_data(real)
% plot(time,real(time),'o');

% figure(1)
% country_names = {'Saint Martin', 'Saint Barthelemy', 'Saint Kitts and Nevis', 'Antigua', 'Monserrat', 'Guadeloupe','Anguilla'};
% country_epstart(country_names)
% 
% figure(2)
% country_names = {'Guadeloupe','Dominica','Martinique','Saint Lucia','Barbados','Saint Vincent and the Grenadines','Grenada','French Guiana'};
% country_epstart(country_names)
% 
% figure(3)
% country_names = { 'Saint Martin', 'Saint Barthelemy','Guadeloupe'};
% country_epstart(country_names)
% country_names = { 'Saint Martin', 'Saint Barthelemy','Guadeloupe', 'Dominica','Dominican Republic','Martinique','French Guiana'};
% country_epstart(country_names)
