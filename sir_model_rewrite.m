%%% SIR Model Rewrite

function sir_model_rewrite( )
%% Get Data
addpath('../data')
[count, pop, name] = get_data('Guadeloupe');  %retrieves infected number, population, and country name from get_data
init_cumu_inf = count(1);  %sets initial cumulative infected to value of first infected
tend = length(count);  %sets tend to fit the length of data
tdata = [1:tend];  %sets time range as values between 1 and last data point
time = [0 50];
close all;

%% Plot Data
figure(1)
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
figure (2)
[t, soln] = solve_rhs_equations (time, init, param, []);
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
figure (3)
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
ub = [1,   200,   200,  300];
[new_param] = fmincon(@(param)objective_function(bal_soln, count, param), new_init, [], [], [], [], lb, ub, []);

param.beta = new_param(1);
param.c = new_param(2);
param.gamma = new_param(3);
param.init_cumu_inf = new_param(4);

for i = 1:length(new_param);
    name = new_param{i};
    param.(name) = new_param(i);
end

[t, opt_soln] = solve_rhs_equations(time, new_init, new_param, []);


%% Plot Optimized Model & Data
figure (4)
hold on
plot(t, opt_soln(:,4), 'r');
plot(count, '*')
title(name)
xlabel('Time')
ylabel('Population')
legend('Model', 'Data')
end 


%% RHS Equations
    function[out] = rhs_equations(time, init, param)
out = zeros(size(init)); %sets place for all outputs of rhs
s = init(1);
i = init(2);
r = init(3);
cumu_i = init(4);

n = s + i + r; %total human population is sum of susceptible, infected, recovered
lambda = param.beta * param.c * (i/n) %sets value for lambda

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

    
%% Balancing Function
function [value, isterminal, direction] = balancing_function(time, out, init_cumu_inf)
value = out(4) - init_cumu_inf;
isterminal = 1;
direction = 1;
end


%% Objective Function
function [difference] = objective_function (bal_soln, count, param)
squared_diff = (bal_soln(:,4) - (count)').^2;
difference = sum(squared_diff);
end
