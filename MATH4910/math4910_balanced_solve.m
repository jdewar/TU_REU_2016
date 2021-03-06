function [t,out] = math4910_balanced_solve(t_in, init, param, functions)
balance_init = init;
balance_init(2) = .0001;
balance_init(3) = balance_init(2);
balance_init(1) = balance_init(1) + init(2) - balance_init(2);

options = odeset('Events',@(t,Y)math4910_balancing_event(t, Y, init(3)));
bal_fn = functions;
fixed_K_v = functions.K_v(param.prop_K, param.max_K, t_in(1));
bal_fn.K_v = @(kmin,kmax,t)fixed_K_v;

t_balance = 10000; % how long we're willing to wait to balance
[~,Y,te] = math4910_output([0 t_balance], balance_init, param, options, bal_fn);

% if numel(te) == 0
%     R0 = math4910_calc_R0(param, functions, t_in(1));
%     error(['Balance fail: ',num2str(R0),' / ',num2str(param.min_K/param.max_K),' / ',num2str(init(3))])
% end

new_init = Y(end,:)';
%new_init(5) = new_init(3);
[t,out] = math4910_output(t_in, new_init, param, [], functions);

end

