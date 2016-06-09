
%%% Main script for running sir model

%% Setting parameters and initial conditions
close all;

[real,pop,name] = get_data('Martinique');
init_infected_h = real(1);
tend = length(real);
total_pop_h = pop * .2;
K_v = pop * 10;

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
field12 = 'K_v';     value12 = K_v;
field13 = 'init_infected'; value13 = init_infected_h;


param = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5, value5, field6,value6,field7,value7, field8,value8,field9,value9,field10,value10, field11,value11, field12,value12,field13,value13);

%chik_optimize_subset(param)

%initial conditions
init = get_init_conditions(param);

%% solving


 % plotting
% figure(1)
% [t_model,out_model] = chik_balanceANDsolve([0 400], init, param);
% size(out_model)
% plot_chik_model(t_model,out_model)
% param_array = struct2array(param,{'beta_hv', 'beta_vh', 'gamma_h', 'mu_h', 'nu_h', 'psi_v', 'mu_v', 'nu_v', 'sigma_h', 'sigma_v', 'H0','K_v', 'init_infected'});
% R0 = chik_R0_calc(param_array);
% 

% figure(2)

 %chik_plot_data(real)



figure(3)
subplot(1,2,1)
[t,out] = chik_balanceANDsolve([0:7:(tend*7)], init, param);

chik_plot_both(t,out,real);

array_names = {'beta_hv', 'beta_vh', 'gamma_h', 'mu_h', 'nu_h', 'psi_v', 'mu_v', 'nu_v', 'sigma_h', 'sigma_v', 'H0','K_v', 'init_infected'};

fn = @(x)chik_obj_fn(x,real,param,array_names,t);

nonlincon = @(x)chik_R0_nonlin(x);

lb = [0.24,0.24,.001,1/(70*365),1/3,.3,1/14,1/11,1  ,0.5, param.H0, param.K_v*.05, param.init_infected];
ub = [0.24,0.24,   1,1/(70*365),1/3,.3,1/14,1/11,100,0.5, param.H0, param.K_v, param.init_infected];

param_array = struct2array(param, array_names);

options = optimset('Algorithm','sqp');
[x] = fmincon(fn, (ub+lb)/2, [],[],[],[],lb,ub,nonlincon,options);

param = array2struct(param, x, array_names); 

%chik_R0_calc(x)

init = get_init_conditions(param);
[t,out] = chik_balanceANDsolve([0:7:tend*7], init, param);

subplot(1,2,2)
chik_plot_both(t,out,real);


param

% figure(5)
% plot_chik_residual(t,out,real);


% figure(4)
% plot_susceptible_proportions(param,real,array_names, t, lb,ub)

total_infected = chik_cumu_infect_real(real)
time = chik_percent_real(real, .1, total_infected)
hold on
chik_plot_data(real)
plot(time,real(time),'o');


