function V = getV(alpha, L, x)
% Get the output of the Laguerre filter banks 

N = length(x);
beta = sqrt(alpha); 
V = zeros(N, L);

V(1, 1) = sqrt(1-alpha) * x(1);
 
for n = 2:N
    V(n ,1) = beta * V(n-1, 1) + sqrt(1-alpha) * x(n);
end
 
 
for j = 2:L
    V(1, j) = sqrt(alpha) * V(1, j-1);
    for n = 2:N
        V(n, j)= beta * V(n-1, j) + beta * V(n, j-1) - V(n-1, j-1);
    end
end

