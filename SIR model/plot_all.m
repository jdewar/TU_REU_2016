function [ ] = plot_all()
db = create_database();
    for i = 1:50
        data = db(i);
        figure(i)
        count = data.count_confirmed;
        plot_data(count);
        str = sprintf('%s %g',data.name, (count(end)/data.population));
        title(str);
        
    end

end

