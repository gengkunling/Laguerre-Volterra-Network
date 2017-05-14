function M = getM(alpha) 
% Get the memory length according to alpha

M = (-30 - log(1-alpha)) ./ log(alpha);
M = ceil(M);