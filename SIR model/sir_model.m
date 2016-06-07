
%%% Main script for running sir model

%% Setting parameters and initial conditions
close all;
%parameters
field1 = 'beta';  value1 = 0.024;
field2 = 'c';  value2 = 9;
field3 = 'gamma';  value3 = 0.1;

param = struct(field1,value1,field2,value2,field3,value3);

real = get_data();
init_infected = real(1);
tend = length(real);
total_pop = 466000;


%initial conditions
init = [total_pop - init_infected;init_infected;0;init_infected];

%% solving
[t,out] = sir_balanceANDsolve([0:1:tend], init, param);

% plotting
figure(1)

subplot(1,2,1)
[t_model,out_model] = sir_balanceANDsolve([0 100], init, param);
plot_sir_model(t_model,out_model)

subplot(1,2,2)
real_data = get_data();
plot_data(real_data)

figure(2)
plot_both(t,out,real_data);

val = sir_obj_fn([param.beta,param.c,param.gamma],real_data,param,{'beta','c','gamma'},t,init);

fn = @(x)sir_obj_fn(x,real_data,param,{'beta','c','gamma'},t,init);
params = [10,10,10];

[x] = fmincon(fn, params, [],[],[],[],[0.001,0.001,0.001],[1,20,10],@R0_calc);

param.beta = x(1);
param.c = x(2);
param.gamma = x(3);

%Check that R0 is greater than 1
R0 = (param.beta*param.c)/param.gamma;
if (R0 <=1)
    display('R0 is less than 1')
    return
end


[t,out] = sir_balanceANDsolve([0:1:tend], init, param);

figure(3)
plot_both(t,out,real_data);

figure(4)
Q = @(params)sir_time_to_10percent(params,total_pop, [0:1:tend],init);
sir_sensitivity_analysis(Q, param,'c');

