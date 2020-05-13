% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load constants.mat;

% --- CURRENT GRAPTHS ---

% Defining y' = F(t, y) where
% y(t) = [U(t); I(t)]
%      = [-C * I'(t); L(I) * U'(t)]
% => y'(t) = [I'(t); U'(t)]
%          = [U(t)/(-C); I(t)/L(I)]
%          = F(t, y)

% Runge-Kutta:

h = 0.000001;
num_p = 2;

for i = 1:length(U0)
    [x, I, U] = rk4f(F, U0(i), num_p, h);
    
    plot(x, I);
    hold on;
    plot(x, zeros(1, length(x)), '--', 'HandleVisibility', 'off'); % x-axis
    hold on;
end

legend('220 V', '1500 V', '2300 V', 'Location', 'northeast');