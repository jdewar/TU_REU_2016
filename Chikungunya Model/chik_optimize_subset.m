function [ country_params ] = chik_optimize_subset(params)
country_names = {'Guadeloupe','Dominica','Dominican Republic','French Guiana','Saint Kitts and Nevis','Curacao'};
for i = 1:length(country_names)
    [real,pop,name] = get_data(country_names{i});
    tend = length(real);
    init_infected_h = real(1);
    total_pop_h = pop;
    K_v = total_pop_h * 10;
    t = [0:7:(tend*7)]

    params.H0 = total_pop_h;
    params.K_v = K_v;
    params.init_infected = init_infected_h;

    init = [total_pop_h - params.init_infected;0;params.init_infected;0;params.init_infected;params.K_v;0;1;1];

    array_names = {'beta_hv', 'beta_vh', 'gamma_h', 'mu_h', 'nu_h', 'psi_v', 'mu_v', 'nu_v', 'sigma_h', 'sigma_v', 'H0','K_v', 'init_infected'};

    fn = @(x)chik_obj_fn(x,real,params,array_names,t,init);

    nonlincon = @(x)chik_R0_nonlin(x);

    lb = [0.24,0.24,0,1/(70*365),1/3,.3,1/14,1/11,0,0.5, total_pop_h, K_v, params.init_infected *.001];
    ub = [0.24,0.24,20,1/(70*365),1/3,.3,1/14,1/11,50,0.5, total_pop_h, K_v, params.init_infected*10];

    [x] = fmincon(fn, (lb+ub)/2, [],[],[],[],lb,ub,nonlincon);

    country_params(i) = array2struct(params, x, array_names); 

end


end

