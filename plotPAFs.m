function plotPAFs(LVN)

colors =  distinguishable_colors(10);

U = LVN.V * LVN.W;
H = LVN.H;
Q = LVN.Q;
C = LVN.C;

figure
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

title('PAFs Estimated by LVN', 'fontsize', 14);

legend('PAF1', 'PAF2', 'PAF3', 'PAF4', 'PAF5', 'PAF6','PAF7', 'PAF8', 'PAF9' );
