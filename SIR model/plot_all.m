function [ ] = plot_all()
db = create_database();
    for i = 1:50
        data = db(i);
        figure(i)
        count = data.count;
        plot_data(count);
        str = sprintf('%s %g',data.name, (count(end)/data.population)*100);
        title(str);
        
    end

end

