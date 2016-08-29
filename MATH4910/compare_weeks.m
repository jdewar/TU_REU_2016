function [val] = compare_weeks(real, model, start, endWeek)
difference = model(start:endWeek,5) - real(start:endWeek)';

val = sum((difference.^2));

end

