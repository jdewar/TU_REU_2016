function [ ] = plot_country_epstart(country_names)
for i = 1:length(country_names)
    real = get_data(country_names{i});
    total_infected = chik_cumu_infect_real(real);
    values(i) = chik_percent_real(real, .1, total_infected);
end

bar(values);
set(gca,'XTickLabel',country_names)


end

