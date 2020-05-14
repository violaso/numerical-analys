% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-12

% --- CONSTANTS ---

% Inductance [Wb/A (Weber/ampere) = H (Henry)]
% - The ratio of the induced voltage to the rate of change of current.
% - The relationship between the magnetic flux and the current.
L0 = 0.7;

% Current-dependent inductance [H (Henry)]
L_insec = @(I, L0) L0 * I0^2/(I0^2+I^2);
L = @(I) L_insec(I, L0);

% Current [A (ampere)]
I0 = 1;

% Voltage [V (volt)]
U0 = [220 1500 2300];

% Capacitance [C/V (Coulomb/volt) = F (Farad)]
% - The ratio of the change in electric charge of a system, to the corresponding change in its electric potential.
% - Measure of the ability to store electrical charge.
C = 0.5 * 10^(-6);

% The relationship between current and voltage
% y' = F(t, y), where y = [I(t) U(t)].
% - U(t) = -C * I'(t)
% - I(t) = L(I) * U'(t)
F_insec = @(t, y, L0, C) [y(2)/L_insec(y(1), L0) y(1)/(-C)];
F = @(t, y) F_insec(t, y, L0, C);% = [I'(t); U'(t);] 

save numerical-analys/project/constants.mat L0 L I0 U0 C F L_unsec F_unsec;