function [] = SEIR_SEI_Model()

country = 'Haiti';
[real, pop, name, firstWeek] = get_data(country);
init_infected_h = real(1);
tend = length(real);
total_pop_h = pop;
max_K = pop * 10;
tspan = (firstWeek*7):7:(55*7);
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
     'K_v',max_K;
     'init_cumu_infected', init_infected_h;
    }';
params = struct(param_struct{:});
array_names = param_struct(1,:);
%chik_plot_data(real, tspan)
init = chik_init_conditions(params, tspan);
%[t,out] = ode45(@(t,Y)rhs_seir_sei(t,Y,params), 0:400, init);

 
% hold on
% plot(t, out(:,1), 'g') 
% plot(t, out(:,2), 'b') 
% plot(t, out(:,3), 'r') 
% plot(t, out(:,4), 'k')
% legend('Exposed','Infected','Recovered', 'Cumulative Infected')
% hold off
% 
% xlabel('Time in Weeks')
% ylabel('Human Population')
% title('Human SEIR Dynamics')
% subplot(1,2,2)
% hold on
% plot(t, out(:,6), 'g') 
% plot(t, out(:,7), 'b')
% plot(t, out(:,8), 'r')
% legend('Susceptible','Exposed','Infected')
% 
% xlabel('Time in Weeks')
% ylabel('Mosquito Population')
% title('Mosquito SEI Dynamics')

% lb = [0.24,0.24,1/6,1/(70*365),1/3,.3,1/14,1/11,1 ,0.5, params.H0, params.K_v, 1];
% ub = [0.24,0.24,1/6,1/(70*365),1/3,.3,1/14,1/11,100,0.5, params.H0, params.K_v, 100];
% obj_fn1 = @(parray)chik_obj_fn(parray, real, array_names, tspan);
% opt_params1 = optimizer(obj_fn1, lb, ub, params)
% 
[t_model,out_model] = chik_balanced_solve([0 400], init, params);
plot_chik_model(t_model,out_model)

% range = linspace(lb(9), ub(9), 40);
% chik_plot_obj_fn(opt_params1, real, array_names, t, 'sigma_h', range)

end

function [out] = rhs_seir_sei(tspan,init,P)
out = zeros(size(init));
sh = init(1);
eh = init(2);
ih = init(3);
rh = init(4);
cumulative_ih = init(5);
%% Vectors
sv = init(6);
ev = init(7);
iv = init(8);
cumulative_iv = init(9);

%% Calculations
N_h = sh+eh+ih+rh;
N_v = sv+ev+iv;
lambda_h = (P.sigma_v*P.sigma_h*P.beta_hv*N_v)/(P.sigma_v*N_v + P.sigma_h *N_h) * (iv/N_v); 

out(1) = P.mu_h*P.H0 - lambda_h * sh - P.mu_h*sh;
out(2) = lambda_h*sh - (P.nu_h+P.mu_h)*eh;
out(3) = P.nu_h*eh - (P.gamma_h + P.mu_h)*ih;
out(4) = P.gamma_h*ih - P.mu_h*rh;
out(5) = P.nu_h*eh;

lambda_v = (P.sigma_v*P.sigma_h*P.beta_vh*N_h)/(P.sigma_v*N_v + P.sigma_h *N_h) * (ih/N_h); 

out(6) = (P.psi_v - (P.psi_v - P.mu_v)*(N_v/P.K_v))*N_v - lambda_v*sv - P.mu_v*sv;
out(7) = lambda_v*sv - (P.nu_v + P.mu_v)*ev;
out(8) = P.nu_v*ev - P.mu_v*iv;% Infected
out(9) = P.nu_v*ev;

end

function [ op_param, fval ] = optimizer(obj_fn, lb, ub, params)
%OPTIMIZER ...

names = fieldnames(params);

options = optimset('Algorithm','sqp'); % we think we like sqp, but we aren't sure.

init_parray = (ub+lb)/2; % this could be an input / randomized

[parray, fval] = fmincon(obj_fn, init_parray, [],[],[],[], lb, ub, [], options);

op_param = array2struct(parray, names); 

end

function val = chik_obj_fn(param_array, data, array_names, t_in)
%chik_obj_fn returns the value that the objective function optimizes over

params = array2struct(param_array, array_names);


new_init = chik_init_conditions(params, t_in);

[~,Y] = chik_balanced_solve(t_in, new_init, params); 
val = chik_cmp_real_model(Y, data);


end

function [] = chik_plot_obj_fn(params, data, array_names, t_in, param_name, range)
param_array = struct2array(params, array_names);
n = 1;
for i = 1:length(array_names)
    if strcmp(param_name,array_names{i}) == 1
        n = i;
        break;
    end
end

for i = 1:length(range)
    param_array(n) = range(i);
    param(i) = param_array(n);
    val(i) = chik_obj_fn(param_array, data, array_names, t_in);
end

plot(param,val)
xlabel(strcat(param_name,' value'));
ylabel('objective function value');

end

function [t,out] = chik_balanced_solve(t_in, init, param)
balance_init = init;
balance_init(3) = .0001;
balance_init(5) = balance_init(3);
balance_init(1) = balance_init(1) + init(3) - balance_init(3);

options = odeset('Events',@(t,Y)chik_balancing_event(t, Y, init(5)));


t_balance = 1000; % how long we're willing to wait to balance
[~,Y] = chik_output([0 t_balance], balance_init, param, options);


new_init = Y(end,:)';
[t,out] = chik_output(t_in, new_init, param, []);

end

function [t,out,te,ye,ie] = chik_output(t_in, Y, param, options)

dydt_fn = @(t,Y)rhs_seir_sei(t, Y, param);

if numel(options) ~= 0
    [t, out, te, ye, ie] = ode23s(dydt_fn, t_in, Y, options);
else
    
    [t, out] = ode23s(dydt_fn, t_in, Y);
end

end

function [value,isterminal,direction] = chik_balancing_event(t, Y, init_infected)
%CHIK_BALANCING_EVENT event halting at when reaching initial infected

value = Y(5) - init_infected; % infected at desired level
isterminal = 1; % stops graph when event is triggered
direction = 1; 

end

function param_array = struct2array(params, names)
%STRUCT2ARRAY Convert struct to array, using fields given in names

param_array = NaN(size(names));
for i = 1:length(names)
    name = names{i};
    param_array(i) = params.(name);
end

end

function params = array2struct(param_array, names)
%ARRAY2STRUCT Convert array to struct, using fields given in names

params = struct();
for i = 1:length(names)
    name = names{i}; 
    params.(name) = param_array(i);
end

end

function [init] = chik_init_conditions(param, t)
%CHIK_INIT_CONDITIONS Given tspan, return desired initial conditions

init = [...
    param.H0; ...
    0; ...
    10; ...
    0; ...
    10; ...
    param.K_v; ...
    0; ...
    0; ...
    0];

end

function [out, difference] = chik_cmp_real_model(model, infected_real)
%CHIK_CMP_REAL_MODEL returns sum squared difference of model and data
difference = model(1:length(infected_real'),5) - infected_real';

out = sum((difference.^2));

end

function [ ] = chik_plot_data(count, tspan)
%plot_data plots real data
hold on
title('Real Infected Count')
xlabel('Time in weeks')
ylabel('Population')
plot(tspan./7, count,'*')
legend('Total cases')

end

function [] = plot_chik_model(t,Y)
%Plot_sir_model
%   takes time span, t, and solved sir matrix, Y, and graphs

 subplot(1,2,1)
hold on
plot(t, Y(:,1), 'g') %plots susceptible graph
plot(t, Y(:,2), 'b') %plots exposed graph
plot(t, Y(:,3), 'r') %plots infected graph
plot(t, Y(:,4), 'k')
plot(t, Y(:,5), 'm')
legend('Susceptible','Exposed','Infected','Recovered', 'Cumulative Infected')
hold off

xlabel('Time in Weeks', 'fontsize', 16)
ylabel('Human Population', 'fontsize', 16)
title('Human SEIR Dynamics', 'fontsize', 16)


subplot(1,2,2)
hold on
plot(t, Y(:,6), 'g') 
plot(t, Y(:,7), 'b')
plot(t, Y(:,8), 'r')
legend('Susceptible','Exposed','Infected')

xlabel('Time in Weeks', 'fontsize', 16)
ylabel('Mosquito Population', 'fontsize', 16)
title('Mosquito SEI Dynamics', 'fontsize', 16)

end