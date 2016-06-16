function [t,out] = sir_balanceANDsolve(t_in, init, param)
       balance_init = init;
       balance_init(2) = .001;
       balance_init(1) = balance_init(1) + init(2) - balance_init(2);
   
       
       options = odeset('Events',@(t,Y)sir_balancing_event(t, Y, init(2))); 
       [t,Y, te, ye, ie] = sir_output([0 1000], balance_init, param, options);
       if numel(te) == 0 && R0_calc(param) > 1
           [Y(end, 2), R0_calc(param)]
       end
       new_init = Y(end,:)';
       %new_init(4) = new_init(2);
       
       [t,out] = sir_output(t_in, new_init, param, []);

end

