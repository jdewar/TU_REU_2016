a=1;
b=2;
d=0;
for i=3:32 %i is iteration from 3 to 32 since c initially is 3, 32 is highest fib value<4000000
    c=a+b; %c is the fibonacci number formed by adding each a and b value
    a=b; %set a equal to second fib number
    b=c; %set b equal to sum
    
    if mod(c,2)==0
        d=c+d; %d is running sum of all of the fibonacci numbers divisible by 2
    end
end
d+2