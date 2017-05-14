function plotKernels(LVN)


W = LVN.W;
C = LVN.C;
PDMs = LVN.PDMs;
T = length(PDMs);
H = LVN.H;

K1 = zeros (T, 1);
for m = 1:T
    for h = 1:H
        K1(m) = K1(m) + C(1, h) * PDMs(m, h);
    end
end

K2 = zeros (T, T);
for m1 = 1:T
    for m2 = 1:T
        for h = 1:H
            K2(m1, m2) = K2(m1, m2) + C(2, h) * PDMs(m1, h) * PDMs(m2, h);
        end
    end
end

figure
subplot(211)
t = [1:length(K1)] ./ LVN.fs;
plot(t, K1,'b', 'linewidth', 2);
xlabel('time (sec)');
ylabel('K1');
title('First Order Kernel Estimated by LVN', 'fontsize', 14);


subplot(212)
colormap jet
mesh(t, t, K2, 'EdgeColor','b');
xlabel('m1 (sec)'); ylabel('m2 (sec)'); zlabel('K2');

title('Second Order Kernel Estimated by LVN', 'fontsize', 14);

