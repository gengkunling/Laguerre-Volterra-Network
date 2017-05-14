function plotParams(LVN, monitor, SA)
M = LVN.M;

%% Plot the actual inputs and outputs, predicted outputs
Nsubfig = 3;
figure
t = (1:LVN.Nd) / LVN.fs;
t0 = M / LVN.fs;
subplot(Nsubfig, 1, 1)
plot(t, LVN.x, 'linewidth', 2);

ylabel('x', 'fontsize', 12);
xlim([t0, t(end)]);
xlabel('s');

subplot(Nsubfig, 1, Nsubfig - 1)
plot(t, LVN.y, 'linewidth', 2)
ylabel('y', 'fontsize', 12)
xlim([t0, t(end)]);
subplot(Nsubfig, 1, Nsubfig)
plot(t, LVN.ye, 'linewidth', 2)
ylabel('ye', 'fontsize', 12)
xlim([t0, t(end)]);



%% Plot the NMSE vs. iterations
figure
t = 1:length(monitor.nmse);
plot(t, monitor.nmse, 'b', 'linewidth', 2)
hold on
plot(t, monitor.cost, 'r', 'linewidth', 2)
xlabel('iteration #');
legend('NMSE', 'cost')
ylim([0 4])
disp('--------------------------------------------');

%% Plot the change of Alphas, W and TH Vs. iteration
figure
plot(t, monitor.A, 'linewidth', 2);
ylabel('Alpha');
xlabel('iteration #');

figure
plot(t, monitor.Y0, 'linewidth', 2);
ylabel('Y0');
xlabel('iteration #');


%%?Plot Tracking curves of W
TOTAL_ITR = SA.TOTAL_ITR;
figure
cnt = 1;
L = LVN.L;
H = LVN.H;
W = monitor.W;
for l = 1:L
    for j = 1:H
        subplot(L, H, cnt)
        plot(t, reshape(W(l, j, :), TOTAL_ITR, 1), 'linewidth', 2);
        cnt = cnt + 1;
    end
end
suptitle('W Tracking curves ');

%%?Plot Tracking curves of C
C = monitor.C;
figure
cnt = 1;
Q = LVN.Q;
H = LVN.H;
for l = 1:Q
    for j = 1:H
        subplot(Q, H, cnt)
        plot(t, reshape(C(l, j, :), TOTAL_ITR, 1), 'linewidth', 2);
        cnt = cnt + 1;
    end
end
suptitle('C tracking curves');



