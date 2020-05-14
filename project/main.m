% --- PROJEKT KRETSEN ---
% @author Viola Söderlund & Jakob Carlsson
% @version 2020-05-14

load constants.mat;

% --- ASSESS OSCILLATION PERIOD ---

% Seeking the frequency (fq) and period (p) of the circuit, where
% fq = 1 / p

% I is periodic, viz
% I(t) = A*sin(B*x + C), where
% - Amplitude: A
% - Period: 2*pi/B
% - Phase Shift: -C/B
% => I'(t) = A*B*cos(B*t + C)
% => I''(t) = -A*B^2*sin(B*t + C)

% Given the relationships,
% U = L(t)*I' <=> U' = L(t)*I''
% I = -C*U' <=> I = -(L*C*I'') <=> 1/(-C*L) * I = I''

% => 1/(-C*L) * A*sin(B*x + C) = -A*B^2*sin(B*t + C)
% <=> -B^2 = 1/(-C*L)
% <=> B = sqrt(1/(C*L))

disp('Perioden p och frekvensen fq om man antar konstant L = L0 = 0,7');

% If
L = L0;
% then
p = 2*pi / sqrt(1/(C*L))
fq = 1 / p




% --- CURRENT GRAPHS ---

% Defining y' = F(t, y) where
% y(t) = [U(t); I(t)]
%      = [-C * I'(t); L(I) * U'(t)]
% => y'(t) = [I'(t); U'(t)]
%          = [U(t)/(-C); I(t)/L(I)]
%          = F(t, y)

% Runge-Kutta:

h = 0.000001;
num_p = 2;

figure('Name', 'Plotter av I(t) med olika U0', 'NumberTitle', 'off');

for i = 1:length(U0)
    [x, I, U] = rk4f(F, U0(i), num_p, h);
    
    plot(x, I);
    hold on;
    plot(x, zeros(1, length(x)), '--', 'HandleVisibility', 'off'); % x-axis
    hold on;
end

legend('220 V', '1500 V', '2300 V', 'Location', 'northeast');



% --- SHOW CONSTANT CAPACITANCE ---

h = [1e-6 1e-4];
p = 40;

for i=1:length(h)
    %calculate
    [x220, I220, U220] = rk4f(F, 220, p, h(i));
    [x1500, I1500, U1500] = rk4f(F, 1500, p, h(i));
    [x2300, I2300, U2300] = rk4f(F, 2300, p, h(i));

    % pre-allocate
    E220 = x220;
    E1500 = x1500;
    E2300 = x2300;

    for n=1:length(x220)
        E220(n) = (1/2)*C*U220(n)^2 + (1/2)*L0*I0^2*log(I0^2 + I220(n)^2); % log is the nl
    end

    for n=1:length(x1500)
        E1500(n) = (1/2)*C*U1500(n)^2 + (1/2)*L0*I0^2*log(I0^2 + I1500(n)^2);
    end

    for n=1:length(x2300)
        E2300(n) = (1/2)*C*U2300(n)^2 + (1/2)*L0*I0^2*log(I0^2 + I2300(n)^2);
    end

    figure('Name', strcat('E(t) vid olika U0, där steglängden h=', num2str(h(i))), 'NumberTitle', 'off');
    plot(x220, E220)
    hold on;
    plot(x1500, E1500)
    plot(x2300, E2300)
    legend('220 V', '1500 V', '2300 V', 'Location', 'northeast');
end




% --- INTERPOLATION ---

h = 0.000001;
num_p = 1;

disp('-----------------------')
disp('Ustart är det U0 som nästkommande värden gäller. Imax är strömmens maxvärde och T är perioden/svängningstiden.')

for i = 1:length(U0)
    Ustart = U0(i)
    
    [x, I, U] = rk4f(F, Ustart, num_p, h);
    [Imax, T] = plif(x, I)
end




% --- ASSESS VOLTAGE FOR FREQUENCY ---

% Seeking U* = U_ for given frquency fq = 400, where
% fq = 1 / T

% Since (refers to assess_max_and_period)
%   period T for U0 = 2300 < seeked T, and
%   period T for U0 = 1500 > seeked T

x0_left = 2300;
x0_right = 1500;

disp('-----------------------')
disp('U_ är det värde på U0 som ger frekvensen 400 Hz, och I_max är strömmens maxvärde i det fallet.')

U_ = smf(x0_left, x0_right, F)

% Fault check:

% fq = 400;
% correct_T = 1 / fq
% 
% T = get_period_f(U, F);
% calculated_T = T

h = 0.000001;
num_p = 1;

[x, I, U] = rk4f(F, U_, num_p, h);
[Imax, T] = plif(x, I);

I_max = Imax




% --- ASSESS VOLTAGE FOR FREQUENCY WITH INSECURE CONSTANTS ---

L0_LOW = L0 * 0.95;
L0_HIGH = L0 * 1.05;
C_LOW = C * 0.95;
C_HIGH = C * 1.05;

param_values = [-1 0; 1 0; 0 -1; 0 1; -1 -1; -1 1; 1 -1; 1 1];

% Single parameter difference
[U_, I_max] = get_voltage(L0_LOW, C, F_insec);
insec = [U_ I_max];
[U_, I_max] = get_voltage(L0_HIGH, C, F_insec);
insec = [insec; U_ I_max];
[U_, I_max] = get_voltage(L0, C_LOW, F_insec);
insec = [insec; U_ I_max];
[U_, I_max] = get_voltage(L0, C_HIGH, F_insec);
insec = [insec; U_ I_max];

% Double parameter difference
[U_, I_max] = get_voltage(L0_LOW, C_LOW, F_insec);
insec = [insec; U_ I_max];
[U_, I_max] = get_voltage(L0_LOW, C_HIGH, F_insec);
insec = [insec; U_ I_max];
[U_, I_max] = get_voltage(L0_HIGH, C_LOW, F_insec);
insec = [insec; U_ I_max];
[U_, I_max] = get_voltage(L0_HIGH, C_HIGH, F_insec);
insec = [insec; U_ I_max];

% Secure values
[U_, I_max] = get_voltage(L0, C, F_insec)

disp('[U_ I_max] relative to insecure parameters [L0 C]:');
[insec param_values]

U_insec = insec(:, 1);
I_max_insec = insec(:, 2);

diff = @(v1, v2) abs(v1 - v2) / ((v1 + v2)/2) * 100;

for i = 1:length(U_insec)
    U_insec(i) = diff(U_insec(i), U_);
    I_max_insec(i) = diff(I_max_insec(i), I_max);
end

disp('Percentage difference U_ relative to insecure parameters [L0 C]:');
[U_insec param_values] 
disp('Percentage difference I_max relative to insecure parameters [L0 C]:');
[I_max_insec param_values]

function [U_, I_max] = get_voltage(L0, C, F_insec)
    F = @(t, y) F_insec(t, y, L0, C);

    % Seeking U* = U_ for given frquency fq = 400, where
    % fq = 1 / T

    % Since (refers to assess_max_and_period)
    %   period T for U0 = 2300 < seeked T, and
    %   period T for U0 = 1500 > seeked T

    x0_left = 2300;
    x0_right = 1500;

    U_ = smf(x0_left, x0_right, F);

    % Fault check:

    % fq = 400;
    % correct_T = 1 / fq
    % 
    % T = get_period_f(U, F);
    % calculated_T = T

    h = 0.000001;
    num_p = 1;

    [x, I, U] = rk4f(F, U_, num_p, h);
    [Imax, T] = plif(x, I);

    I_max = Imax;
end
