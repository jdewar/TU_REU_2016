%%% SIR Model Rewrite

function sir_model_rewrite( )
%% Get Data
addpath('../data')
[count, pop, name] = get_data('Guadeloupe');  %retrieves infected number, population, and country name from get_data
init_cumu_inf = count(1);  %sets initial cumulative infected to value of first infected
tend = length(count);  %sets tend to fit the length of data
tdata = [1:tend];  %sets time range as values between 1 and last data point
close all;

%% Plot Data
figure()
plot(count, '*');  %plots data points from get_data
title(name);  %plots name of country as title
xlabel('Time');
ylabel('Total Number Infected');


%% Set Parameters
field1 = 'beta'; value1 = 1;
field2 = 'c'; value2 = 9;
field3 = 'gamma'; value3 = 1/6;
field4 = 'init_cumu_inf'; value4 = init_cumu_inf;

param = struct(field1,value1,field2,value2,field3,value3,field4,value4);

array_names = {'beta', 'c', 'gamma', 'init_cumu_inf'};
param_array = {param.beta, param.c, param.gamma, param.init_cumu_inf};
 
 
%% Initial Conditions
init = [pop - init_cumu_inf, init_cumu_inf, 0, init_cumu_inf];


%% Plot Unbalanced SIR Dyanmics
figure ()
[t, soln] = solve_rhs_equations (tdata, init, param, []);
hold on
plot(t, soln(:,1), 'g');
plot(t, soln(:,2), 'k');
plot(t, soln(:,3), 'b');
plot(t, soln(:,4), 'r');
title('SIR Unbalanced Population Dynamics')
xlabel('Time')
ylabel('Population')
legend('Susceptible', 'Infected', 'Recovered', 'Cumulative Infected')


%% Balancing
bal_init = init;
bal_init(2) = .001;
bal_init(4) = bal_init(2);
bal_init(1) = init(1) + init(2) - bal_init(2);

options = odeset('Events',@(time, out)balancing_function(time, out, init_cumu_inf));
[t, Y] = solve_rhs_equations(tdata, bal_init, param, options);
new_init = Y(end, :);
[t, bal_soln] = solve_rhs_equations(tdata, new_init, param, []);


%% Plot Balanced SIR Dynamics
figure ()
hold on
plot(t, bal_soln(:,1), 'g');
plot(t, bal_soln(:,2), 'k');
plot(t, bal_soln(:,3), 'b');
plot(t, bal_soln(:,4), 'r');
title('SIR Balanced Population Dynamics')
xlabel('Time')
ylabel('Population')
legend('Susceptible', 'Infected', 'Recovered', 'Cumulative Infected')


%% Optimizing
lb = [1, 0.001, 0.001, 0.01];
ub = [1,   200,   200, mean(count)* .95];
half = (lb + ub) / 2;
opt_func = @(param_array)objective_function(bal_soln, count, param, array_names, param_array, tdata, new_init);
options = optimset('Algorithm', 'sqp');
param
init_cumu_inf

[new_param] = fmincon(opt_func, half, [], [], [], [], lb, ub, [], options);

param.beta = new_param(1);
param.c = new_param(2);
param.gamma = new_param(3);
param.init_cumu_inf = new_param(4);
param

new_init = [pop - param.init_cumu_inf, param.init_cumu_inf, 0, param.init_cumu_inf]

[tdata, opt_soln] = solve_rhs_equations(tdata, new_init, param, []);


%% Plot Optimized Model & Data
figure ()
hold on
plot(tdata, opt_soln(:,4), 'r');
plot(count, '*')
title(name)
xlabel('Time')
ylabel('Population')
legend('Model', 'Data')
end 


%% RHS Equations
function[out] = rhs_equations(tdata, init, param)
out = zeros(size(init)); %sets place for all outputs of rhs
s = init(1);
i = init(2);
r = init(3);
cumu_i = init(4);

n = s + i + r; %total human population is sum of susceptible, infected, recovered
lambda = param.beta * param.c * (i/n); %sets value for lambda

out(1) = -lambda .* s; %change in susceptible population
out(2) = lambda * s - param.gamma * i; %change in infected population
out(3) = param.gamma * i; %change in exposed population
out(4) = lambda * s; %cumulative infected people (positive lambda)
end


%% Solve RHS Equations
function [t, soln] = solve_rhs_equations (time, init, param, options)
if numel(options) ~= 0
[t, soln, te, ye, ie] = ode45(@(time, init)rhs_equations(time, init, param), time, init, options);
else
[t, soln] = ode45(@(time, init)rhs_equations(time, init, param), time, init, options);
end
end


%% Calculate R0
function [R0] = calculate_R0 (params)
R0 = (params.beta * params.c) / params.gamma;
end

    
%% Balancing Function
function [value, isterminal, direction] = balancing_function(time, out, init_cumu_inf)
value = out(4) - init_cumu_inf;
isterminal = 1;
direction = 1;
end


%% Objective Function
function [difference] = objective_function (bal_soln, count, param, array_names, param_array, tdata, new_init)
    for i = 1:length(array_names)
        name = array_names{i}; 
        param.(name) = param_array(i);
    end
    
[t, out] = solve_rhs_equations (tdata, new_init, param, []);
squared_diff = (out(:,4) - (count)').^2;
difference = sum(squared_diff);

R0 = calculate_R0 (param);
c = 1.0001 - R0;

    if c>0
        difference = difference * (1+c);
    end
    
end
