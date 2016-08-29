function [] = plot_mosquito(t,Y, data)

t1 = t'./7;
plot(t1(1:length(data)), Y(1:length(data),6)+ Y(1:length(data),7)+Y(1:length(data),8), 'c')

title('Mosquito population') % add carrying capacity to plot



end

