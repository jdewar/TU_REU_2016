
%%% Main script for running sir model

%% Setting parameters and initial conditions
[real, pop] = get_data('Dominica');
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

%% solving
[t,out] = sir_balanceANDsolve([0:1:tend], init, param);

% %plotting
% figure(1)
% 
% subplot(1,2,1)
% [t_model,out_model] = sir_balanceANDsolve([0 200], init, param);
% plot_sir_model(t_model,out_model)
% 
% subplot(1,2,2)
% plot_data(real)

% figure(2)
% plot_both(t,out,real);

val = sir_obj_fn([param.beta,param.c,param.gamma,param.init_infected],real,param,{'beta','c','gamma','init_infected'},t,init);

fn = @(x)sir_obj_fn(x,real,param,{'beta','c','gamma','init_infected'},t,init);
params = [10,10,10,10];

[x] = fmincon(fn, params, [],[],[],[],[1,0.001,0.001,param.init_infected*.001],[1,20,10,param.init_infected *10],@R0_calc);

param.beta = x(1);
param.c = x(2);
param.gamma = x(3);
param.init_infected = x(4);

param

% %Check that R0 is greater than 1
% R0 = (param.beta*param.c)/param.gamma;
% if (R0 <=1)
%     display('R0 is less than 1')
%     return
% end


[t,out] = sir_balanceANDsolve([0:1:tend], init, param);

new_init = out(1,1:4)';

figure(3)
 plot_both(t,out,real);

figure(4)
 Q = @(params)sir_cumu_infect(params,total_pop, [0:1:tend],new_init);
 sir_sensitivity_analysis(Q, param,'gamma');
 sir_plot_sensitivity(Q, 'gamma',1:20, param);
 ylabel('cumulative infected');

figure(5)
 Q = @(params)sir_time_to_percent(params,total_pop, [0:1:tend],new_init,.01);
 sir_sensitivity_analysis(Q, param,'c')
 sir_sensitivity_analysis(Q, param,'gamma')
 sir_plot_sensitivity(Q, 'c',1:20, param);
 ylabel('time to 1% infected');

 figure(6)
 sir_plot_contour(Q,1:20,1:20, param);
