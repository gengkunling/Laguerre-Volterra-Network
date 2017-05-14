function newLVN = getNewParamVals(LVN)

Nparam = LVN.Nparam;
Nw = LVN.Nw;
Nc = LVN.Nc;
newLVN = LVN;

r = floor(Nparam * rand(1)) + 1;
tmp = sign(rand(1) - 0.5);

if r <= 1
    % updata A in subLVN #k
    sA = LVN.sA;
    newA = LVN.A +  tmp * sA;
    [newA, idxA]= clampA(newA, sA);
    newLVN.V = LVN.V_all(:, :, idxA);
    newLVN.A = newA;
elseif r > 1 && r <= 1 + Nw
    % updata W(j) in subLVN #k
    j = (r - 1);
    W = LVN.W;
    sW = LVN.sW;
    C = LVN.C;
    Q = LVN.Q;
    newW = W;
    newW(j) = W(j) + tmp * sW(j);
    % Nomalize newW and scaling C accordingly 
    [newW, norm_factor] = normalize(newW); % Normalize weights
    for q = 1:Q
        newC(q, :) = C(q, :).*(norm_factor).^q;
    end
    newLVN.W = newW;
    newLVN.C = newC;
elseif r > 1 +Nw && r <= 1 + Nw + Nc
    % updata C(j) in subLVN #k
    j = r - 1 - Nw;
    C = LVN.C;
    sC = LVN.sC;
    newC = C;
    newC(j) = C(j) + tmp * sC(j);
    newLVN.C = newC;
else
    % update Y0
    newLVN.Y0 = LVN.Y0 + tmp * LVN.sY0;
end

