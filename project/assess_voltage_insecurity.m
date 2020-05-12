% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load constants.mat;

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