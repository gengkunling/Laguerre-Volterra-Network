function LVN = forwardProp(LVN)

M= LVN.M;


W = LVN.W;
C = LVN.C;
V = LVN.V;
U = V * W;
Q = LVN.Q;
if Q == 1
    z = U * C';
elseif Q == 2
    U2 = U .* U;
    z = U * C(1, :)' + U2 * C(2, :)';
elseif Q == 3
    U2 = U .* U;
    U3 = U2 .* U;
    z = U * C(1, :)' + U2 * C(2, :)' + U3 * C(3, :)';
else
    error('The order Q should not exceed 3!');
end
ssW = sum(abs(W(:)));
ssC = sum(abs(C(:)));

y = LVN.y;
ye = LVN.Y0 + sum(z, 2);
LVN.ye = ye;
err = y - ye;
err(1:M) = [];
LVN.nmse = sum (err .* err) / sum(y(M+1:end).^2);
LVN.cost = LVN.nmse + LVN.lambda * (ssW + ssC) ;


