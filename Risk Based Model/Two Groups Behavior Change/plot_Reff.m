function[] = plot_Reff(t,Y,p)
Reff = zeros(size(t));
 i = 1;
while i < length(t)
   Reff(i) = calc_Reff(p,transpose(Y(i,:)));
    i = i + 1;
end
Reff
plot(t,Reff)