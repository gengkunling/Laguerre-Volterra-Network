function LVN = plotPDMs(LVN)
fs = LVN.fs;
colors =  distinguishable_colors(10);


% Get PDMs
W = LVN.W;
C = LVN.C;
A = LVN.A;
M = getM(A);
L = size(W, 1);
H = size(W, 2);
Q = size(C, 1);
impulse = zeros(M, 1);
impulse(1) = 1;
LB = getV(A, L, impulse);
LVN_PDMs = LB * W;

% Normalization of PDMs
[LVN_PDMs, LVN_Norm_Const] = normalize(LVN_PDMs);

for h = 1:H
    W(:, h) = W(:, h)./LVN_Norm_Const(h);
end

for q = 1:Q
    C(q, :) = C(q, :).*(LVN_Norm_Const).^q;
end
LVN.W = W;
LVN.C = C;
LVN.PDMs = LVN_PDMs;


% Plot time domain PDMs
figure
subplot(211)
for h = 1:H
    t = (1:M) /fs;
    set(gca, 'ColorOrder', colors(h,:));
    plot(t, LVN_PDMs(:,h), 'linewidth', 2);
    hold on
end
legend('PDM1', 'PDM2', 'PDM3', 'PDM4', 'PDM5', 'PDM6', 'PDM7', 'PDM8', 'PDM9');
xlabel('time (ms)', 'fontsize', 12);

% Plot frequency Domain PDMs
subplot(212)
NFFT = 2^nextpow2(M) * 4;
f = fs / 2 * linspace(0,1,NFFT/2+1);

F_LVN = [];
F_LVN_mag = [];
for h = 1:H
    F_LVN(:, h) = fft(LVN_PDMs(:, h),NFFT)/M;
    F_LVN_mag(:, h) = abs(F_LVN(1:NFFT/2+1, h));
    set(gca, 'ColorOrder', colors(h,:));
    plot(f, F_LVN_mag(:, h), 'linewidth', 2);
    hold on
end
legend('PDM1', 'PDM2', 'PDM3', 'PDM4', 'PDM5', 'PDM6', 'PDM7', 'PDM8', 'PDM9');
xlabel('frequency (Hz)', 'fontsize', 12);

suptitle('PDMs Estimated by LVN');


