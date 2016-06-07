function [t,out] = chik_balanceANDsolve(t_in, init, param)
       balance_init = init;
       balance_init(3) = .001;
       balance_init(1) = balance_init(1) + init(3) - balance_init(3);
       
       options = odeset('Events',@(t,Y)chik_balancing_event(t, Y, init(3))); 
       [t,Y] = chik_output([0 1000], balance_init, param, options);
      
       new_init = Y(end,:)';
       new_init(5) = new_init(3);
       
       [t,out] = chik_output(t_in, new_init, param, []);

end

