function answer=problem001()

n = 999;

answer = cumu_sum(n,3) + cumu_sum(n,5) - cumu_sum(n,15);

end


function sum = cumu_sum(n,k)
    m = floor((n - 1) / k);
	sum = k * m * (m + 1) / 2;
end