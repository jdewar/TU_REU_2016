
%%% Main script for running sir model

%% Setting parameters and initial conditions
addpath('../data');
[real, pop] = get_data('Virgin Islands');
init_infected = real(1)
tend = length(real);
total_pop = pop;

close all;
%parameters
field1 = 'beta';  value1 = 0.024;
field2 = 'c';  value2 = 9;
field3 = 'gamma';  value3 = 0.1;
field4 = 'init_infected'; value4 = init_infected;

param = struct(field1,value1,field2,value2,field3,value3,field4,value4);

%initial conditions
init = [total_pop - param.init_infected;param.init_infected;0;param.init_infected];
array_names = {'beta','c','gamma','init_infected'};
param_array = [param.beta,param.c,param.gamma,param.init_infected];

%% solving
[t,out] = sir_balanceANDsolve([0:1:tend], init, param);

%plot_all
% %plotting
%figure(1)

[t_model,out_model] = sir_balanceANDsolve([0 200], init, param);
%plot_sir_model(t_model,out_model)

% figure()
% plot_data(real)

% figure()
% plot_both(t,out,real);

val = sir_obj_fn(param_array,real,array_names,t,init);

fn = @(x)sir_obj_fn(x,real,array_names,t,init);
params = [10,10,10,10];

lb = [1,0.001,0.001,param.init_infected*.001]
ub = [1,20,10,param.init_infected*100]
[parray] = fmincon(fn, params, [],[],[],[],lb,ub,@R0_calc);

param.beta = parray(1);
param.c = parray(2);
param.gamma = parray(3);
param.init_infected = parray(4);
param

%Check that R0 is greater than 1
% R0 = (param.beta*param.c)/param.gamma;
% if (R0 <=1)
%     display('R0 is less than 1')
%     return
% end


[t,out] = sir_balanceANDsolve([0:1:tend], init, param);
new_init = out(1,1:4)'

figure()
 plot_both(t,out,real);
 
figure()
range = [lb(2):ub(2)]
sir_plot_obj_fn(parray, real, array_names, t, new_init, 'c', range);
% % 
% figure(4)
%  Q = @(params)sir_cumu_infect(params,total_pop, [0:1:tend],new_init);
%  sir_sensitivity_analysis(Q, param,'beta');
%  sir_plot_sensitivity(Q, 'beta',.01:.01:.1, param);
%  ylabel('cumulative infected');
% % 
% % figure(5)
% %  Q = @(params)sir_time_to_percent(params,total_pop, [0:1:tend],new_init,.01);
% %  sir_sensitivity_analysis(Q, param,'c')
% %  sir_sensitivity_analysis(Q, param,'gamma')
% %  sir_plot_sensitivity(Q, 'c',1:20, param);
% %  ylabel('time to 1% infected');
% 
%  figure(6)
%  sir_plot_contour(Q,1:20,1:20, param);
%  
%  figure(7)
%  residual = residual_calc(init,real)
%  plot(t,residual,'o')
