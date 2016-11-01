%% Main script for running model with no and high risk groups and no behavior change
close all; 
addpath('../data');
country = 'Guadeloupe';
[real2014, pop, name, firstWeek2014] = get_data(country);
full_count = real2014;
real = full_count;
init_infected_h = real(1);
tend = length(real);
max_K = pop * 2;
tspan = [(firstWeek2014*7):7:((tend+firstWeek2014-1)*7)];
tend = (tend+firstWeek2014-1);
tspan_full_count = (firstWeek2014*7):7:((length(full_count)+firstWeek2014-1)*7);
tspan_predictions = [(firstWeek2014*7):7:((tend+firstWeek2014-1)*7)];
tspan_predictions = tspan_full_count;
tfuture = tend+3;


%% Parameter values

param_struct = ...
    {'beta_h', 0.24;
     'beta_v', 0.24;
     'gamma_h', 1/6;
     'mu_h', 1/(70*365);
     'nu_h', 1/3;
     'psi_v', 0.3;
     'mu_v', 1/14;
     'nu_v', 1/11;
     'sigma_h', 19;
     'sigma_v', 0.5;
     'H0', pop;
     'theta', 1;
     'init_cumulative_infected', init_infected_h;
     'K_v' , pop * 2;
    }';
params = struct(param_struct{:});
array_names = param_struct(1,:);
%% Plot Cumulative vs. Newly Infected
%  figure()
%  subplot(1,2,1)
%  plot_data(full_count, tspan_full_count)
% 
% subplot(1,2,2)
% newly_infected = get_newly_infected_count(real);
% plot(tspan,newly_infected)

%% Plot ODE Solutions
figure()
init = [10000,1,0,1,100000,0,0,0];
params.H0 = 1000;
params.init_cumulative_infected = 1;
[t_model,out_model] = balance_and_solve([0 200], init, params);
plot_model(t_model,out_model)
drawnow