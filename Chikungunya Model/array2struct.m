function [ params] = array2struct(params, param_array,array_names )
%UNTITLED19 Summary of this function goes here
%   Detailed explanation goes here
for i = 1:length(array_names)
    name = array_names{i}; 
    params.(name) = param_array(i);
end

end