function [] = plot_mosquito(t,Y, data)
    t1 = t'./7;
    plot(t1(1:length(data)), Y(1:length(data),9), 'c')

end
