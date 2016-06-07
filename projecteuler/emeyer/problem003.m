n=600851475143;
for a=1:n; %a is the iteration of all numbers from 1 to our value
    if mod(n,a)==0 %this finds all factors of our value by finding at which a's the mod=0
        x=a; %outputs factors
        for b=1:x;
            if mod(x,b)~=0
                y=b;
            end
        end
    end
end
y


%prime function