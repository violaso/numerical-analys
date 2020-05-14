% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load mysterysound1.mat;

% --- INVESTIGATE MYSTERY SOUND ---

% Plot sound:

p = 2*pi;

h = p / length(v);
x = 0:h:p-h;
    
plot(x, v);
hold on;
plot(x, zeros(1, length(x)), '--', 'HandleVisibility', 'off'); % x-axis

legend('mysterysound1', 'Location', 'northeast');