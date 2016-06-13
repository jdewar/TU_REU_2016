function [t,out] = chik_balanceANDsolve(t_in, init, param, functions)
       balance_init = init;
       balance_init(3) = .001;
       balance_init(1) = balance_init(1) + init(3) - balance_init(3);
       
       options = odeset('Events',@(t,Y)chik_balancing_event(t, Y, init(3)));
       bal_fn = functions;
       fixed_K_v = functions.K_v(param.min_K, param.max_K, t_in(1));
       bal_fn.K_v = @(kmin,kmax,t)fixed_K_v;
       
       [t,Y, te,ye,ie] = chik_output([0 10000], balance_init, param, options, bal_fn);
       
      if numel(te) == 0
          R0 = chik_R0_calc(param);
          error([num2str(R0),' / ',num2str(param.min_K/param.max_K), ' / ',num2str(init(3)) ])
      end
        
       new_init = Y(end,:)';
       new_init(5) = new_init(3);
       
       [t,out] = chik_output(t_in, new_init, param, [], functions);

end

