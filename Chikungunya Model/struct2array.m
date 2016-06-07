function [ param_array ] = struct2array(params,array_names )
%UNTITLED19 Summary of this function goes here
%   Detailed explanation goes here
for i = 1:length(array_names)
    name = array_names{i}; 
    param_array(i) = params.(name);
end

end

