function [ difference ] = prediction_diff(model, data, t)
model(t,5);
data(t);
difference = abs(model(t,5) - data(t));

end

