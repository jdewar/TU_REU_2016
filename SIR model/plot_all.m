function [ ] = plot_all()
db = create_database();
    for i = 1:50
        data = db(i);
        figure(i)
        plot_data(data.count);
        count = data.count_linear;
        str = sprintf('%s %g',data.name, (count(end)/data.population));
        title(str);
        
    end

end

