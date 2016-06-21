function [ ] = plot_all_newly_infected()
no_data_2015 = {'United States','Grenada', 'Suriname', 'Curacao', 'Dominica', 'Haiti', 'Saint Kitts and Nevis', 'Sint Maarten', 'Saint Lucia', 'Saint Vincent and the Grenadines'};
db = create_database();
db2015 = create_database_2015();
country_names = {db.name};
    for i = 1:50
        [data2014, ~, name, firstWeek2014] = data_from_entry(db(i));
        tspan = (firstWeek2014*7):7:((length(data2014)+firstWeek2014-1)*7); % tspan not size of real data
        for j = 1:length(no_data_2015)
           if strcmp(name, no_data_2015{j}) == 1
               newly_infected = get_newly_infected_count(data2014);
               sum_data = sum_data + data2014;
               hold all
               chik_plot_NewlyInfected(tspan,newly_infected)
               str = sprintf('%s',name);
               title(str);
           else
               [data2015] = data_from_idx_2015(db2015, i);
               tspan_full_count = (firstWeek2014*7):7:((length(data2015)+length(data2014)+firstWeek2014-1)*7);
        
               newly_infected = get_newly_infected_count(data2015);
              
               full_count = combine_data(data2014,newly_infected);

        
               newly_infected_combined = get_newly_infected_count(full_count);
       
               hold all
               chik_plot_NewlyInfected(tspan_full_count,newly_infected_combined)
             
           end
        end
        

        
    end

end