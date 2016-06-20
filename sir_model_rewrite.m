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
init = [pop - init_cumu_inf, init_cumu_inf, 0, init_cumu_inf]; %initial conditions [susceptible, infected, recovered, cumulative infected]


%% Plot Unbalanced SIR Dyanmics
figure ()
[t, soln] = solve_rhs_equations (tdata, init, param, []); %calls ode45 to solve odes
hold on
plot(t, soln(:,1), 'g'); %plot susceptible
plot(t, soln(:,2), 'k'); %plot infected
plot(t, soln(:,3), 'b'); %plot recovered
plot(t, soln(:,4), 'r'); %plot cumulative infected
title('SIR Unbalanced Population Dynamics')
xlabel('Time')
ylabel('Population')
legend('Susceptible', 'Infected', 'Recovered', 'Cumulative Infected')


%% Balancing
bal_init = init; %start with setting balanced init to original initial conditions
bal_init(2) = .0001; %set initial infected to small number
bal_init(4) = bal_init(2); %set initial cumulative infected to initial infected
bal_init(1) = init(1) + init(2) - bal_init(2); %set susceptible to (pop - inf) + inf - small number

options = odeset('Events',@(time, out)balancing_function(time, out, init_cumu_inf)); %use events function, calls balancing function
[t, Y] = solve_rhs_equations(tdata, bal_init, param, options); %calls solver to solve odes with new initial conditions
new_init = Y(end, :); %when event is triggered, endpoints become new_init
[t, bal_soln] = solve_rhs_equations(tdata, new_init, param, []); %solve again, starting with new_init and output balanced solution


%% Plot Balanced SIR Dynamics
figure ()
hold on
plot(t, bal_soln(:,1), 'g'); %plot susceptible
plot(t, bal_soln(:,2), 'k'); %plot infected
plot(t, bal_soln(:,3), 'b'); %plot recovered
plot(t, bal_soln(:,4), 'r'); %plot cumulative infected
title('SIR Balanced Population Dynamics')
xlabel('Time')
ylabel('Population')
legend('Susceptible', 'Infected', 'Recovered', 'Cumulative Infected')


%% Optimizing
lb = [1, 0.001, 0.001, 0.01]; %boundaries for parameters [beta, c, gamma, init_cumu_inf]
ub = [1,   200,   200, mean(count)* .95];
half = (lb + ub) / 2; %set this as starting point for optimization
opt_func = @(param_array)objective_function(soln, count, param, array_names, param_array, tdata, init); %call obj fn with inputs
options = optimset('Algorithm', 'sqp'); %choose some way of optimizing
param
init_cumu_inf

[new_param] = fmincon(opt_func, half, [], [], [], [], lb, ub, [], options); %fmincon optimizes using obj fn

%set parameters to new values
param.beta = new_param(1);
param.c = new_param(2);
param.gamma = new_param(3);
param.init_cumu_inf = new_param(4);
param

new_init = [pop - param.init_cumu_inf, param.init_cumu_inf, 0, param.init_cumu_inf]; %don't think this is necessary

[tdata, opt_soln] = solve_rhs_equations(tdata, new_init, param, []); %solve with new parameters and initial conditions


%% Plot Optimized Model & Data
figure ()
hold on
plot(tdata, opt_soln(:,4), 'r'); %plot cumu inf with data
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
if numel(options) ~= 0 %if solving with options, output te, ye, ie
[t, soln, te, ye, ie] = ode45(@(time, init)rhs_equations(time, init, param), time, init, options);
else %otherwise, solve normally
[t, soln] = ode45(@(time, init)rhs_equations(time, init, param), time, init, options);
end
end


%% Calculate R0
function [R0] = calculate_R0 (params)
R0 = (params.beta * params.c) / params.gamma;
end

    
%% Balancing Function
function [value, isterminal, direction] = balancing_function(time, out, init_cumu_inf)
value = out(4) - init_cumu_inf; %set function to trigger when init cumu rhs equation is equal to init cumu from data
isterminal = 1; %stops integrating when value = 0
direction = 1; %event happens when function increasing
end


%% Objective Function
function [difference] = objective_function (bal_soln, count, param, array_names, param_array, tdata, new_init)
    for i = 1:length(array_names)
        name = array_names{i}; 
        param.(name) = param_array(i); %change parameters from struct to array
    end
    
[t, out] = solve_rhs_equations (tdata, new_init, param, []); %call solutions from solver
squared_diff = (out(:,4) - (count)').^2; %squared difference between model and data
difference = sum(squared_diff); %take sum of squared diff, this value is what is being optimized

R0 = calculate_R0 (param); 
c = 1.0001 - R0; %need R0>1, need c to be negative

    if c>0
        difference = difference * (1+c); %if R0 is less than 1, add linear portion to optimizer so it is not flat
    end
    
end
