function [] = sir_model()
%% Setting parameters and initial conditions
addpath('../data');
country = 'Guadeloupe';
[real_full, pop] = get_data(country);
real = real_full;
full_count = combine_data(country);
init_infected = real(1);
tend = length(real);
total_pop = pop;
tspan = [1:tend];
tspan_predictions = [1:length(real_full)];
close all;
%parameters
field1 = 'beta';  value1 = 1;
field2 = 'c';  value2 = 1;
field3 = 'gamma';  value3 = 1/2;
field4 = 'init_cumu_infected'; value4 = init_infected;

param = struct(field1,value1,field2,value2,field3,value3,field4,value4);


array_names = {'beta','c','gamma','init_cumu_infected'};
param_array = [param.beta,param.c,param.gamma,param.init_cumu_infected];

%% solving


figure()

fn = @(x)sir_obj_fn(x,real,param,array_names,tspan_predictions,total_pop);
lb = [1,0.001,0.001,.01];
ub = [1,50,50,mean(real)* .95];

half = (lb+ub)/2;
options = optimset('Algorithm', 'interior-point');
[parray, fval] = fmincon(fn, half, [],[],[],[],lb,ub, [], options);

val = sir_obj_fn(param_array,real, param,array_names,tspan,total_pop);
disp(fval)

param.beta = parray(1);
param.c = parray(2);
param.gamma = parray(3);
param.init_cumu_infected = parray(4);


param


new_init = sir_init_conditions(param, tspan_predictions, total_pop);
[t,out] = sir_balanceANDsolve(tspan_predictions, new_init, param);

figure()

plot_both(tspan_predictions,out,real_full);

figure()
fn2 = @(x)sir_obj_fn(struct2array(x,array_names),real,param,array_names,tspan_predictions,total_pop);

plot([1,5],[1,5],'k-')
hold on
ax = [2.2 4.2 1.7 3.8];
sir_plot_contour_j(fn2, linspace(ax(1),ax(2),200), linspace(ax(3),ax(4),200), param)
axis(ax)

beep