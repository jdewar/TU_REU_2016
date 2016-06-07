% 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
% What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
num = 0;
for i = 1:1000000000
    isAnswer = true;
    for j = 1:20
        if mod(i,j) ~= 0
            isAnswer = false;
        end
    end
    if isAnswer
        num = i;
        break
    end
end

num