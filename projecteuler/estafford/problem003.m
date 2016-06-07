n = 600851475143;
maxPrime = 1;

for i = 1:n
    if mod(600851475143,i) == 0
        isPrime = true;
        for l = 1:i
            if mod(i,l) == 0
                isPrime = false;
            end
        end
        
        if isPrime
            maxPrime = i;
        end
    end
end

maxPrime