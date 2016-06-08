
%%% Main script for running sir model

%% Setting parameters and initial conditions
close all;

[real,pop,name] = get_data('Guateloupe');
init_infected_h = real(1);
tend = length(real);
total_pop_h = pop;
K_v = total_pop_h * 10;

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
init = [total_pop_h - param.init_infected;0;param.init_infected;0;param.init_infected;K_v;0;1;1];

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
% real_data = chik_get_data();
% chik_plot_data(real_data)

figure(3)
[t,out] = chik_balanceANDsolve([0:7:(tend*7)], init, param);
new_init = out(1,:);
new_init

%chik_plot_both(t,out,real);
array_names = {'beta_hv', 'beta_vh', 'gamma_h', 'mu_h', 'nu_h', 'psi_v', 'mu_v', 'nu_v', 'sigma_h', 'sigma_v', 'H0','K_v', 'init_infected'};

fn = @(x)chik_obj_fn(x,real,param,array_names,t,new_init);

nonlincon = @(x)chik_R0_nonlin(x);

lb = [0.24,0.24,0,1/(70*365),1/3,.3,1/14,1/11,50,0.5, total_pop_h, K_v, param.init_infected *.1];
ub = [0.24,0.24,2,1/(70*365),1/3,.3,1/14,1/11,50,0.5, total_pop_h, K_v, param.init_infected*10];

[x] = fmincon(fn, (lb+ub)/2, [],[],[],[],lb,ub,nonlincon);

param = array2struct(param, x, array_names); 


[t,out] = chik_balanceANDsolve([0:7:tend*7], init, param);

figure(4)
% subplot(1,2,1)
chik_plot_both(t,out,real);


figure(5)
plot_chik_residual(t,out,real);

