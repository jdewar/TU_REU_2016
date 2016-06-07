sum = 0;
for i = 1:(1000 - 1)
    if mod(i,3)==0
        sum = sum +i;
    elseif mod(i,5)==0
        sum = sum +i;
    end
end

sum