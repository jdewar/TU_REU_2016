
palindrome=0;

for i=999:-1:100
    for j=999:-1:100
        num = i*j;
        str = num2str(num);
        if all(str==str(end:-1:1))==1 
            if num>palindrome
                palindrome = num;
            end
        end
    end
end
palindrome
