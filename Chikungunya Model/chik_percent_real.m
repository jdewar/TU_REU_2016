function [time] = chik_percent_real(real_data, percent, total_infected)
time = 0;
for i = 1:length(real_data)
    if (real_data(i) - (percent* total_infected) > - (percent* total_infected)/4) && (real_data(i) - (percent* total_infected) < (percent* total_infected)/4)
        time = i;
        break;
    end
end
end