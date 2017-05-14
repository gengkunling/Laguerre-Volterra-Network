clc;
clear all;
close all;

% Parameters for generate the data
N = 1024;
NoiseFree = 0;
SNR = 0;
alpha = 0.7; 
fs = 20;
y0 = 0; 
W = [1 0 1 1 ; -1 1 2 0.5]';
C = [1 -1; 1 0.5;]';
L = size(W, 1); H = size(W, 2); Q = size(C, 1);

% Generate input x and noise-free output z
x = randn(N, 1);
V = getV(alpha, L, x);
z = zeros(N, 1) + y0;
for i = 1:N
    v = V(i, :);
    u = v * W;
    for q = 1:Q
        for h = 1:H
            z(i) = z(i) + C(q, h) * u(h) .^ q;
        end
    end
end

% Add noise and generate the system output y
Pz = mean(z.^2);
Pn = Pz / 10^(SNR/10);
n = sqrt(Pn)*randn(N, 1);

if NoiseFree == 0
    y = z + n;
else
    y = z;
end

% Save the data
alpha;
if NoiseFree == 1
noise = 'noiseFree';
else
    noise = ['SNR = ', int2str(SNR)];
end
save('data.mat', 'x', 'y', 'noise', 'W', 'C', 'y0', 'alpha', 'fs');


