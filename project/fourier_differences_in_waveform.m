% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load constants.mat;

% --- PLOT RESCALED CURRENT CURVE ---

h = 0.000001;

for i = 1:length(U0)
    [t, v] = vf(U0(i), F, h, 2);
    
    plot(t, v);
    hold on;
    plot(t, zeros(1, length(t)), '--', 'HandleVisibility', 'off'); % x-axis
    hold on;
end

legend('220 V', '1500 V', '2300 V', 'Location', 'northeast');