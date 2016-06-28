%%% Main script for running sir model

function [] = chikungunya_model()
%% 2014 Initial Conditions
close all; clc; clf; set(0,'DefaultFigureWindowStyle','docked');
addpath('../data');


country = 'French Guiana';
[real2014, pop, name, firstWeek2014] = get_data(country);
full_count = combine_data(country);
real = full_count;
init_infected_h = real(1);
tend = length(real);
max_K = pop * 2;
tspan = [(firstWeek2014*7):7:((tend+firstWeek2014-1)*7)];
<<<<<<< HEAD
% tend = (tend+firstWeek2014-1);
 tspan_full_count = (firstWeek2014*7):7:((length(full_count)+firstWeek2014-1)*7);
 tspan_predictions = [(firstWeek2014*7):7:((tend+firstWeek2014-1)*7)];
 %tspan_predictions = tspan_full_count;
=======
tend = (tend+firstWeek2014-1);
tspan_full_count = (firstWeek2014*7):7:((length(full_count)+firstWeek2014-1)*7);
tspan_predictions = [(firstWeek2014*7):7:((length(real2014)+firstWeek2014-1)*7)];
tspan_predictions = tspan_full_count;
tfuture = tend+3;
>>>>>>> origin/master


%% Param & Function Struct
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
     'H0', pop;
     'prop_K', 1;
     'max_K', max_K;
     'init_cumu_infected', init_infected_h;
    }';
params = struct(param_struct{:});
array_names = param_struct(1,:);

field1 = 'K_v';  value1 = @chik_K_v;
functions = struct(field1,value1);

%% Plot Cumulative vs. Newly Infected
 figure()
% subplot(1,2,1)
 chik_plot_data(full_count, tspan_full_count)
% 
% subplot(1,2,2)
% newly_infected = get_newly_infected_count(real);
% plot(tspan,newly_infected)

%% Plot ODE Solutions
% figure()
% init = chik_init_conditions(params, tspan);
% [t_model,out_model] = chik_balanced_solve([0 400], init, params, functions);
% plot_chik_model(t_model,out_model)

%% Optimization & Plot - Original Obj Fn
lb = struct2array(params,array_names);
ub = struct2array(params,array_names);

 [lb, ub] = range(lb, ub, 'sigma_h', .1, 50, array_names);
 [lb, ub] = range(lb, ub, 'H0', params.H0 * .01, params.H0, array_names);
 [lb, ub] = range(lb, ub, 'max_K', params.max_K * .01, params.max_K*10, array_names);
 [lb, ub] = range(lb, ub, 'init_cumu_infected', .001, mean(real2014)* .95, array_names);


% lb = [0.24,0.24,1/6,1/(70*365),1/3,.3,1/14,1/11,.1,0.5, params.H0 * .01, params.prop_K, params.max_K, .001];
% ub = [0.24,0.24,1/6,1/(70*365),1/3,.3,1/14,1/11,50,0.5, params.H0, params.prop_K, params.max_K, mean(real)* .95];

c = 1;
for i = 1:length(lb)
    if lb(i) ~= ub(i)
        optimized{c} = array_names{i};
        c = c+1;
    end
end
%optimized;

obj_fn1 = @(parray)chik_obj_fn(parray, real, array_names, tspan_predictions, functions);
opt_params1 = optimizer(obj_fn1, lb, ub, params)


percent_pop1 = opt_params1.H0/pop * 100

init1 = chik_init_conditions(opt_params1, tspan_predictions);
[t1,out1] = chik_balanced_solve(tspan_predictions, init1, opt_params1, functions);

%val_real = chik_cmp_real_model(out, full_count)

figure()
subplot(1,2,1)
chik_plot_both(tspan_predictions, out1, full_count);
hold on
plot([tend,tend], [0,max(full_count)]);
plot([tfuture,tfuture], [0,max(full_count)]);

difference1 = prediction_diff(out1, full_count, tfuture)

%R01 = chik_calc_R0(opt_params1, functions, t(1))

%% Optimization & Plot - New Obj Fn

obj_fn2 = @(parray)chik_obj_fn_recent(parray, real, array_names, tspan_predictions, functions);
opt_params2 = optimizer(obj_fn2, lb, ub, params)

percent_pop2 = opt_params2.H0/pop * 100

init2 = chik_init_conditions(opt_params2, tspan_predictions);
[t2,out2] = chik_balanced_solve(tspan_predictions, init2, opt_params2, functions);

%val_recent = chik_cmp_recent(out, full_count)

subplot(1,2,2)
chik_plot_both(tspan_predictions, out2, full_count);
hold on
plot([tend,tend], [0,max(full_count)]);
plot([tfuture,tfuture], [0,max(full_count)]);
difference2 = prediction_diff(out2, full_count, tfuture)

%R02 = chik_calc_R0(opt_params2, functions, t(1))

%% Plot Objective Function
% figure()
% subplot(1,2,1)
% chik_plot_both(tspan_predictions, out, full_count);
%  
% subplot(1,2,2)
% opt_params1.H0 = 632200;
% [t,out] = chik_balanced_solve(tspan_predictions, init, opt_params1, functions);
% chik_plot_both(t, out, real);
% 
% figure()
% r = linspace(lb(11), ub(11), 100);
% [param,val] = chik_plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, tspan, functions, 'H0', r);
% hold on
% plot([opt_params1.H0,opt_params1.H0], [0,max(val)]);

% figure()
% r = linspace(lb(9), ub(9), 100);
% [param,val] = chik_plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, tspan, functions, 'sigma_h', r);
% hold on
% plot([opt_params1.sigma_h,opt_params1.sigma_h], [0,max(val)]);
% 
% figure()
% r = linspace(lb(13), ub(13), 100);
% [param,val] = chik_plot_obj_fn(struct2array(opt_params1, array_names), real, array_names, tspan, functions, 'max_K', r);
% hold on
% plot([opt_params1.max_K,opt_params1.max_K], [0,max(val)]);


%% Sensitivity Analysis

%Q1 = @(opt_params1)chik_Q_cumu_infect (opt_params1, out, t, functions);
% Q2 = @(params)chik_Q_time_to_percent(params,out(end,5), tspan,init, .01, functions);
% Q3 = @(params)chik_obj_fn(struct2array(params, array_names), real, array_names, tspan_predictions, functions);
%figure()
%chik_plot_contour(Q3,opt_params1,linspace(1,200,40), linspace(1, 20, 40));
%
%sensitivity_H0  = chik_sensitivity_analysis(Q1,opt_params1,'H0')
%sensitivity_sigma_h  = chik_sensitivity_analysis(Q1,opt_params1,'sigma_h')
%sensitivity_max_K  = chik_sensitivity_analysis(Q1,opt_params1,'max_K')

%sensitivity_init_cumu_infected  = chik_sensitivity_analysis(Q1,opt_params1,'init_cumu_infected')

% r = linspace(lb(13), ub(13), 100);
% figure()
% [param,val] = chik_plot_obj_fn(struct2array(opt_params1, array_names), full_count, array_names, tspan_predictions, functions, 'max_K', r);
% hold on
% plot([opt_params1.max_K,opt_params1.max_K], [0,max(val)]);
% r = linspace(lb(11), ub(11), 100);
% min(val)

% figure()
% [param,val] = chik_plot_obj_fn(struct2array(opt_params1, array_names), full_count, array_names, tspan_predictions, functions, 'H0', r);
% hold on
% plot([opt_params1.H0,opt_params1.H0], [0,max(val)]);
% r = linspace(lb(9), ub(9), 100);
% min(val)

% figure()
% [param,val] = chik_plot_obj_fn(struct2array(opt_params1, array_names), full_count, array_names, tspan_predictions, functions, 'sigma_h', r);
% hold on
% plot([opt_params1.sigma_h,opt_params1.sigma_h], [0,max(val)]);
% 
% min(val)


%% table of sensitivities
% sensitivities = table_of_sensitivities(params,functions, firstWeek2014, full_count,tspan_full_count, array_names, lb, ub);
% sensitivities

%% Guadeloupe sensitivity of sigma_h by week
% sensitivity = [0.0140,0.0181,0.0036,0.0418,0.0425,0.0437,0.0376,0.0421];
% plot(sensitivity)

%% Calculate Biting Rates
% [rate_vh, rate_hv] = chik_calc_biting_rates(opt_params1, out);

%% Plotting K_v - Not Needed
% figure()
% plot(0:1:365, chik_K_v(params.prop_K, params.max_K, 0:1:365))
% xlabel('Days'); ylabel('Mosquito Carrying Capacity'); title('Seasonal K_v')

%% Optimizing Newly Infected - Not Needed
%new_data = get_data(country,'linear_newinf');
% obj_fn2 = @(parray)chik_obj_fn(parray, new_data, array_names, tspan, functions);
% opt_params2 = optimizer(obj_fn2, nonlincon, lb, ub, params)
% 
% init = chik_init_conditions(opt_params2, tspan);
% [t,out] = chik_balanced_solve(tspan, init, opt_params2, functions);
% 
% subplot(1,2,2)
% chik_plot_both_NewlyInfected(t,out,new_data);% newly infected


%% 2015 Initial Conditions
% country = 'French Guiana';
% [real2014, pop2014,name,firstWeek2014] = get_data(country);
% [real, pop, name, firstWeek] = get_data2015(country);
% init_infected_h = real(1);
% tend = length(real);
% total_pop_h = pop*.14;
% max_K = pop * 10;
% tspan = (firstWeek*7):7:((tend+firstWeek-1)*7); % tspan not size of real data
% tspan_full_count = (firstWeek2014*7):7:((tend+length(real2014)+firstWeek2014-1)*7);

%% Param & Function Struct
% param_struct = ...
%     {'beta_hv', 0.24;
%      'beta_vh', 0.24;
%      'gamma_h', 1/6;
%      'mu_h', 1/(70*365);
%      'nu_h', 1/3;
%      'psi_v', 0.3;
%      'mu_v', 1/14;
%      'nu_v', 1/11;
%      'sigma_h', 19;
%      'sigma_v', 0.5;
%      'H0', total_pop_h;
%      'prop_K', 1;
%      'max_K', max_K;
%      'init_cumu_infected', init_infected_h;
%     }';
% params = struct(param_struct{:});
% array_names = param_struct(1,:);
% 
% field1 = 'K_v';  value1 = @chik_K_v;
% functions = struct(field1,value1);

%% Plot Cumulative vs. Newly Infected
% figure()
% newly_infected = get_newly_infected_count(real);
% subplot(1,2,1)
% full_count = combine_data(real2014,newly_infected);
% chik_plot_data(full_count, tspan_full_count);
% 
% subplot(1,2,2)
% newly_infected_combined = get_newly_infected_count(full_count);
% plot(tspan_full_count,newly_infected_combined)

%% Optimization & Plot
% lb = [0.24,0.24,1/6,1/(70*365),1/3,.3,1/14,1/11,.1,0.5, params.H0, params.prop_K*.01, params.max_K, .001];
% ub = [0.24,0.24,1/6,1/(70*365),1/3,.3,1/14,1/11,50,0.5, params.H0, params.prop_K, params.max_K*10, mean(real)* .95];
%  
% obj_fn1 = @(parray)chik_obj_fn(parray, full_count, array_names, tspan_full_count, functions);
% opt_params1 = optimizer(obj_fn1, lb, ub, params);
%  
% init = chik_init_conditions(opt_params1, tspan_full_count);
% [t,out] = chik_balanced_solve(tspan_full_count, init, opt_params1, functions);
% 
% figure()
% chik_plot_both(t, out, full_count);

%% Plot Objective Function
% figure()
% subplot(1,2,1)
% chik_plot_both(t, out, full_count);
% 
% subplot(1,2,2)
% range = linspace(lb(14), ub(14), 40);
% chik_plot_obj_fn(struct2array(opt_params1, array_names), full_count, array_names, t, functions, 'init_cumu_infected', range)
% 

%% Unused Functions (for 2014 data)
% figure()
% plot_chik_residual(t, out, new_data);

% figure()
% plot_chik_residual(t,out,real_data);

% total_infected = chik_cumu_infect_real(real_data)
% time = chik_percent_real(real_data, .1, total_infected)
% hold on
% chik_plot_data(real_data)
% plot(time,real(time),'o');

% figure()
% plot_susceptible_proportions(params, real_data, t, lb, ub, functions) % this won't work given balancing errors

% figure()
% country_names = {'Saint Martin', 'Saint Barthelemy', 'Saint Kitts and Nevis', 'Antigua', 'Monserrat', 'Guadeloupe','Anguilla'};
% plot_country_epstart(country_names)

% figure()
% country_names = {'Guadeloupe','Dominica','Martinique','Saint Lucia','Barbados','Saint Vincent and the Grenadines','Grenada','French Guiana'};
% plot_country_epstart(country_names)

% figure()
% country_names = { 'Saint Martin', 'Saint Barthelemy','Guadeloupe'};
% plot_country_epstart(country_names)
% country_names = { 'Saint Martin', 'Saint Barthelemy','Guadeloupe', 'Dominica','Dominican Republic','Martinique','French Guiana'};
% plot_country_epstart(country_names)



end