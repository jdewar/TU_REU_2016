function [ ] = plot_all_newly_infected()
close all;
no_data_2015 = {'United States','Grenada', 'Suriname', 'Curacao', 'Dominica', 'Haiti', 'Saint Kitts and Nevis', 'Sint Maarten', 'Saint Lucia', 'Saint Vincent and the Grenadines', 'Canada'};
db = create_database();
db2015 = create_database_2015();
country_names = {db.name};
sum_data = zeros(1,107);
    for i = 1:50
        no2015 = false;
        [data2014, ~, name, firstWeek2014] = data_from_entry(db(i));
        
        if numel(firstWeek2014)~=1
            data2014 = zeros(1,55);
            firstWeek2014 = 1;
        end
        
        tspan = (firstWeek2014*7):7:((length(data2014)+firstWeek2014-1)*7); % tspan not size of real data
        for j = 1:length(no_data_2015)
           if strcmp(name, no_data_2015{j}) == 1
               newly_infected = get_newly_infected_count(data2014);
               c = 1;
               for k = 1:length(sum_data)
                   if k >= firstWeek2014 && c <= length(data2014)
                       sum_data(k) = newly_infected(c);
                       c = c+1;
                   end
               end
               hold all
               chik_plot_NewlyInfected(tspan,newly_infected)
               str = sprintf('%s',name);
               title(str);
               no2015 = true;
           end
        end
         if(no2015 == false)
               [data2015] = data_from_idx_2015(db2015, i);
               tspan_full_count = (firstWeek2014*7):7:((length(data2015)+length(data2014)+firstWeek2014-1)*7);
        
               newly_infected = get_newly_infected_count(data2015);
              
               full_count = combine_data(data2014,newly_infected);

        
               newly_infected_combined = get_newly_infected_count(full_count);
               
              
               c = 1;
               for k = 1:length(sum_data)
                   if (k >= firstWeek2014) && (c <= length(newly_infected_combined))
                       sum_data(k) = newly_infected_combined(c);
                       c = c+1;
                   end
               end
              

               hold all
               chik_plot_NewlyInfected(tspan_full_count,newly_infected_combined)
             
         end
    end
    
    figure()
    plot(sum_data)
   
end