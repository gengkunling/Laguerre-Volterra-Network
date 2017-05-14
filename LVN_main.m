clc;
clear all;
close all;

tic

% Load Data
load('data.mat')
% Initializations::
% LVN Structure Parameters
lambda = 0.01; % Regulization strength parameter for sparse LVN
L = 4; H = 2; Q = 2;
M = 80; % Data length needed to be cut out

% Simulated Aneealing Related Parameters
SA.Tmpt = 100;
SA.MAX_GLOBAL_ITR = 2000;
SA.MAX_LOCAL_ITR = 5e2;
SA.TOTAL_ITR = SA.MAX_GLOBAL_ITR * SA.MAX_LOCAL_ITR;
SA.COOL_CONST = 0.99;

% Step size
sA = 1e-2; sW = 1e-2 * ones(L, H); sC = 1e-2 * ones(Q, H);
sY0 = 1e-2;

% Construct LVN
LVN = initializeLVN(x, y, Q, L, H, sA, sW, sC, sY0, fs, M, lambda);

% Moniter important parameters
monitor.A = zeros(1, SA.TOTAL_ITR);
monitor.nmse = zeros(1, SA.TOTAL_ITR);
monitor.cost = zeros(1, SA.TOTAL_ITR);
monitor.Y0 = zeros(1, SA.TOTAL_ITR);
monitor.W = zeros(LVN.L, LVN.H, SA.TOTAL_ITR);
monitor.C = zeros(LVN.Q, LVN.H, SA.TOTAL_ITR);


%% Simulated Annealing
LVN = forwardProp(LVN);
bar = waitbar(0,'My Progress Bar');
local_itr = 1;
for global_itr = 1:SA.MAX_GLOBAL_ITR
    SA.Tmpt = SA.Tmpt * SA.COOL_CONST;
    for local_itr = 1:SA.MAX_LOCAL_ITR
        i = local_itr + (global_itr - 1) * SA.MAX_LOCAL_ITR;
        
        % Propose New Parameters values and compute new SSE
        newLVN = getNewParamVals(LVN);
        newLVN = forwardProp(newLVN);
        
        % Update by Metropolis acceptance algorithm
        cost = LVN.cost;
        newCost = newLVN.cost;
        if newCost < cost
            p = 1;
        else
            p = exp((cost - newCost)/SA.Tmpt);
        end
        Update = rand(1) <= p;
        if Update == 1
            LVN = newLVN;
        end
        
        % Monitor Values
        monitor.A(:, i) = LVN.A;
        monitor.nmse(i) = LVN.nmse;
        monitor.cost(i) = LVN.cost;
        monitor.Y0(:, i) = LVN.Y0;
            monitor.W(:, :, i) = LVN.W;
            monitor.C(:, :, i) = LVN.C;
    end
    
    % Show progress bar
    percent = global_itr/SA.MAX_GLOBAL_ITR;
    bar = waitbar(percent, bar,['Progress: ',num2str(percent * 100), '%']);
end

toc
delete(bar);
warning off

% Plot the monitor parameters
plotParams(LVN, monitor, SA)

% Plot PDMs
LVN = plotPDMs(LVN);

% Plot ANFs
plotPAFs(LVN)

% Plot kernels
plotKernels(LVN)

% Show results
showResults(LVN)

save results.mat LVN monitor SA

