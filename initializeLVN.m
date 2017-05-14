function LVN = initializeLVN(x, y, Q, L, H, sA, sW, sC, sY0, fs, M, lambda)
% build the structure and intilizations of the parameters  for subLVN
Nd = length(x);                           % data length
LVN.Nd = Nd;
LVN.x = x;                                % input of the real data
LVN.y = y;                                % output of the real data
LVN.ye = zeros(LVN.Nd, 1);                % estimated output
LVN.fs = fs;                              % sampling frequency
LVN.z = zeros(1, Nd);                     % output of the subLVN
LVN.Q = Q;                                % order of system nonlinearity
LVN.L = L;                                % No. of Laguerre basic function
LVN.H = H;                                % No. of hidden units/PDMs
LVN.W = -1 + 2 * rand(L, H);              % weight matrix of subLVN
LVN.C = -1 + 2 * rand(Q, H);              % polynomial coeeficient matrix of subLVN
LVN.Y0 = 0;                               % constant bias of the system
LVN.A = 0.5;                              % crtitical parameter alpha
LVN.V = zeros(Nd, L);                     % outputs of the filter bank
LVN.sA = sA;                              % step size of updating A
LVN.sW = sW;                              % step size of updating W
LVN.sC = sC;                              % step size of updating C
LVN.sY0 = sY0;                            % step size of updating Y0
LVN.M = M;                                % Memory length of the system (length of data need to be cut off)
LVN.lambda = lambda;                      % Regularization strength

% Calculate all filter bank outputs Vs for different alphas
nA = 1 / sA;
LVN.V_all = zeros(Nd, L, nA);
for i = 1:nA
    iA = i * sA;
    LVN.V_all(:, :, i) = getV(iA, L, x);
end
[LVN.A, idxA]= clampA(LVN.A, LVN.sA);
LVN.V = LVN.V_all(:, :, idxA);

LVN.Nw = L * H;                                            % no. of weights
LVN.Nc = Q * H;                                            % no. of coefficients
LVN.Nparam =  LVN.Nw + LVN.Nc + 2;                % No. of all parameters