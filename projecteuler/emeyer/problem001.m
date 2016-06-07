a=0;
for b=1:999 %b is iteration from 1 to 999
if mod(b,3)==0 %find all numbers up to 999 divisible by 3
    a=a+b; %a sums the number by adding a to the values that we want (b) and creating a running sum
elseif mod(b,5)==0 %find all numbers up to 999 divisible by 5 if they are not divisible by 3
    a=a+b; 
end
end
a %calls final a value