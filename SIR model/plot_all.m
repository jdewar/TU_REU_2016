function [ ] = plot_all()
db = create_database();
    for i = 1:50
        data = get_data(db(i).name);
        figure(i)
        plot_data(data);
        title(db(i).name);
    end

end

