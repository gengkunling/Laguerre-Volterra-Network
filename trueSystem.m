clc
clear all
close all


load data_single_input.mat

colors = [0 0 1; 1 0 0; 0 0.5 0; 0.9 0.5 0; 0 0 0];

% Get PDMs
M = getM(alpha);
L = size(W, 1);
H = size(W, 2);
Q = size(C, 1);
impulse = zeros(M, 1);
impulse(1) = 1;
LB = getV(alpha, L, impulse);
PDMs = LB * W;

% Normalization of PDMs
[PDMs, LVN_Norm_Const] = normalize(PDMs);

for h = 1:H
    W(:, h) = W(:, h)./LVN_Norm_Const(h);
end

for q = 1:Q
    C(q, :) = C(q, :).*(LVN_Norm_Const).^q;
end

% Plot time domain PDMs
figure
subplot(211)


for h = 1:H
    t = (1:M) /fs;
    set(gca, 'ColorOrder', colors(h,:));
    plot(t, PDMs(:,h), 'linewidth', 2);
    hold on
end
legend('PDM1', 'PDM2', 'PDM3', 'PDM4', 'PDM5', 'PDM6', 'PDM7', 'PDM8', 'PDM9');
xlabel('time (s)', 'fontsize', 12);

% Plot frequency Domain PDMs
subplot(212)
NFFT = 2^nextpow2(M) * 4;
f = fs / 2 * linspace(0,1,NFFT/2+1);

F_PDM = [];
F_PDM_mag = [];
for h = 1:H
    F_PDM(:, h) = fft(PDMs(:, h),NFFT)/M;
    F_PDM_mag(:, h) = abs(F_PDM(1:NFFT/2+1, h));
    set(gca, 'ColorOrder', colors(h,:));
    plot(f, F_PDM_mag(:, h), 'linewidth', 2);
    hold on
end
xlabel('frequency (Hz)', 'fontsize', 12);
suptitle('True PDMs ');



K1 = zeros (M, 1);
for m = 1:M
    for h = 1:H
        K1(m) = K1(m) + C(1, h) * PDMs(m, h);
    end
end

K2 = zeros (M, M);
for m1 = 1:M
    for m2 = 1:M
        for h = 1:H
            K2(m1, m2) = K2(m1, m2) + C(2, h) * PDMs(m1, h) * PDMs(m2, h);
        end
    end
end

% Plot the ANFs of the System
figure
V = getV(alpha, L, x);
U = V * W;
for h = 1:H
    u_mean = mean(U(:, h));
    u_std = std(U(:, h));
    low = u_mean - u_std;
    up = u_mean + u_std;
    u = low:1e-4:up;
    len = length(u);
    y_ANF = zeros(1, len);
    c = C(:, h);
    for q = 1:Q
        y_ANF = y_ANF + c(q)*u.^q;
    end
    f = polyfit(u, y_ANF, 1);
    set(gca, 'ColorOrder', colors(h,:));
    plot(u, y_ANF, 'linewidth', 2);
    hold on
end
title('True Associated Nonlinear Functions (ANFs)', 'fontsize', 14);
legend('ANF1', 'ANF2', 'ANF3', 'ANF4', 'ANF5', 'ANF6','ANF7', 'ANF8', 'ANF9' );



% Plot the Kernels of the system
figure
subplot(211)
t = [1:length(K1)] / fs;
plot(t, K1,'b', 'linewidth', 2);
xlabel('time (sec)');
ylabel('k1');
title('True First Order Kernels', 'fontsize', 14);


subplot(212)
colormap jet
mesh(t, t, K2, 'EdgeColor','b');
xlabel('m1 (sec)'); ylabel('m2 (sec)'); zlabel('k2');
title('True Second Order Kernels', 'fontsize', 14);



