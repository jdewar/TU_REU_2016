function [t,out, val] = balance_and_solve(t_in, init, param)
balance_init = init;
balance_init(2) = .0001;
balance_init(4) = balance_init(2);
balance_init(1) = balance_init(1) + init(2) - balance_init(2);

options = odeset('Events',@(t,Y)balancing_event(t, Y, init(4)));

t_balance = 100000; % how long we're willing to wait to balance
[~,Y,te] = output([0 t_balance], balance_init, param, options);
new_init = Y(end,:)';

options = odeset('Events',@(t,Y)peak_infected_event(t, Y, param));

[t,out,val] = output(t_in, new_init, param, options);
end