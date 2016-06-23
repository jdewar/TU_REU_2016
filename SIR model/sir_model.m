function [] = sir_model()
%% Setting parameters and initial conditions
addpath('../data');
country = 'Dominica Republic';
[real_full, pop] = get_data(country);
real = real_full(1:25);
[real2015] = get_data2015(country);
figure()
plot(1:length(real2015), real2015, '*');
drawnow
% full_count = combine_data(country);
% init_infected = real(1);
% tend = length(real);
% total_pop = pop;
% tspan = [1:tend];
% %tspan_predictions = [1:length(full_count)];
% tspan_predictions = [1:length(real_full)];
% close all;
% %parameters
% field1 = 'beta';  value1 = 1;
% field2 = 'c';  value2 = 1;
% field3 = 'gamma';  value3 = 1/2;
% field4 = 'init_cumu_infected'; value4 = init_infected;
% 
% param = struct(field1,value1,field2,value2,field3,value3,field4,value4);
% 
% %initial conditions
% %init = sir_init_conditions(param, tspan, total_pop);
% init = [1000,1,0,1];
% array_names = {'beta','c','gamma','init_cumu_infected'};
% param_array = [param.beta,param.c,param.gamma,param.init_cumu_infected];
% 
% %% solving
% 
% %figure()
% % [t_model,out_model] = sir_balanceANDsolve([0 1000], init, param);
% % R0 = (param.beta*param.c)/param.gamma
% % plot_sir_model(t_model,out_model)
% 
% %  figure()
% %  plot_data(real)
% %  drawnow
% fn = @(x)sir_obj_fn(x,real,param,array_names,tspan_predictions,total_pop);
% lb = [1,0.001,0.001,.01];
% ub = [1,200,200,mean(real)* .95];
% 
% half = (lb+ub)/2;
% options = optimset('Algorithm', 'sqp');
% [parray] = fmincon(fn, half, [],[],[],[],lb,ub, [], options);
% 
% val = sir_obj_fn(param_array,real, param,array_names,tspan,total_pop);
% 
% param.beta = parray(1);
% param.c = parray(2);
% param.gamma = parray(3);
% param.init_cumu_infected = parray(4);
% 
% % %Check that R0 is greater than 1
% % R0 = (param.beta*param.c)/param.gamma;
% % if (R0 <=1)
% %     display('R0 is less than 1')
% %     return
% % end
% 
% 
% new_init = sir_init_conditions(param, tspan_predictions, total_pop);
% [t,out] = sir_balanceANDsolve(tspan_predictions, new_init, param);
% 
% figure()
% %plot_both(tspan_predictions,out,full_count);
% %hold on
% %plot([tend,tend], [0,max(full_count)]);
% plot_both(tspan_predictions,out,real_full);
% hold on
% plot([tend,tend], [0,max(real_full)]);
% 
% 
% % %  
% % % figure(2)
% % % range = linspace(lb(4),ub(4), 40);
% % % sir_plot_obj_fn(parray, real,param, array_names, t, total_pop, 'init_cumu_infected', range);
% % 
% % % % 
% % % figure(4)
% % %  Q = @(params)sir_cumu_infect(params,total_pop, [0:1:tend],new_init);
% % %  sir_sensitivity_analysis(Q, param,'beta');
% % %  sir_plot_sensitivity(Q, 'beta',.01:.01:.1, param);
% % %  ylabel('cumulative infected');
% % % % 
% % % figure()
% % % Q = @(params)sir_cumu_infect(params,out, t, new_init);
% % % % sir_sensitivity_analysis(Q, param,'c')
% % % % sir_sensitivity_analysis(Q, param,'gamma')
% % % sir_plot_sensitivity(Q, 'gamma',1:20, param);
% % % ylabel('cumulative infected');
% % % 
% % % figure()
% % % Q = @(params)sir_cumu_infect(params,out, t, new_init);
% % % % sir_sensitivity_analysis(Q, param,'c')
% % % % sir_sensitivity_analysis(Q, param,'gamma')
% % % sir_plot_sensitivity(Q, 'c',1:20, param);
% % % ylabel('cumulative infected');
% % 
% % 
% % figure()
% % Q = @(params)sir_cumu_infect(params, t, total_pop);
% % % sir_sensitivity_analysis(Q, param,'c')
% % % sir_sensitivity_analysis(Q, param,'gamma')
% % sir_sensitivity_analysis(Q, param,'init_cumu_infected')
% % sir_plot_sensitivity(Q, 'init_cumu_infected',1:(mean(real)* .95), param);
% % %ylabel('cumulative infected');
% % % 
% % %  figure(6)
% % %  sir_plot_contour(Q,1:20,1:20, param);
% % %  
% % %  figure(7)
% % %  residual = residual_calc(init,real)
% % %  plot(t,residual,'o')
% % 
% % 
% % % param = 
% % % 
% % %              beta: 1
% % %                 c: 3.525457468235504
% % %             gamma: 3.486563794602791
% % %     init_infected: 1300
% % % 
% % % 
% % % ans =
% % % 
% % %     -6.219152650581727e-07
% 
% end