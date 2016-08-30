function [ value ] = math4910_cmp_recent( model, infected_real )
difference = model(1:length(infected_real'),5) - infected_real';
recent = model(end-5:end',5) - infected_real(end-5:end)';
value = sum(difference.^2)+sum(recent.^2);


end

