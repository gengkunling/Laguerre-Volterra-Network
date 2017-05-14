function [y, NormConst] = normalize(y)
[Nr, Nc] = size(y);
NormConst = zeros(1, Nc);
for i = 1:Nc
    SS = sum(y(:, i).^2);
    NormConst(i) = sqrt(SS);
    y(:, i) = y(:, i)./NormConst(i);
end