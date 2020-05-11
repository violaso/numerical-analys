% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

% --- CONSTANTS ---

% Inductance [Wb/A (Weber/ampere) = H (Henry)]
% - The ratio of the induced voltage to the rate of change of current.
% - The relationship between the magnetic flux and the current.
L0 = 0.7;

% Current [A (ampere)]
I0 = 1;

% Capacitance [C/V (Coulomb/volt) = F (Farad)]
% - The ratio of the change in electric charge of a system, to the corresponding change in its electric potential.
% - Measure of the ability to store electrical charge.
C = 0.5 * 10^6;

% --- RELATIONSHIPS ---

% The relationships given by the project instructions,
% U(t) = L(I) * I'(t)
% I(t) = -C * U'(t)
% - diverge.

% By switching -C and L, the relationsships are balanced.
% Since the new relationships fits with the described results of the
% instructions, these are used instead.
% U(t) = -C * I'(t)
% I(t) = L(I) * U'(t)

% L(I) = L0 * I0^2/(I0^2+I^2) = 0.7 * 1/(1+I^2) <= 0.7

% --- ASSESS OSCILLATING PERIOD ---

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
% U = -C*I' <=> U' = -C*I''
% I = L*U' <=> I = -(L*C*I'') <=> 1/(-C*L) * I = I''

% => 1/(-C*L) * A*sin(B*x + C) = -A*B^2*sin(B*t + C)
% <=> -B^2 = 1/(-C*L)
% <=> B = sqrt(1/(C*L))

% If
L = L0;
% then
p = 2*pi / sqrt(1/(C*L))
fq = 1 / p

% When L = L0 or t = 0,
P = p;

% --- CURRENT GRAPTHS ---

% Defining y' = F(t, y) where
% y(t) = [U(t); I(t)]
%      = [L(I) * I'(t); -(C * U'(t))]
% => y'(t) = [U'(t); I'(t)]
%          = [I(t)/(-C); U(t)/L(I)]
%          = F(t, y)

% Runge-Kutta:

L = @(I) L0 * I0^2/(I0^2+I^2);
F = @(t, y) [y(2)/(-C) y(1)/L(y(1))];% = [I'(t); U'(t);]

[x, y] = runge_kutta(F, 220);
hold on;
[x, y] = runge_kutta(F, 1500);
hold on;
[x, y] = runge_kutta(F, 2300);

legend('220 V', '1500 V', '2300 V', 'Location', 'northeast');

% --- INTERPOLATION ---

function [Imax, T] = interpolate(x, y)
    % Piecewise linear interpolation
end

function [x, y] = runge_kutta(F, U0)
    I0 = 0;
    yn = [I0 U0];
    y = yn;
    
    h = 0.1;
    tn = 0;
    x = tn; 
    
    counter = 1;

    while counter < 5
        s1 = F(tn, yn);
        s2 = F(tn + h/2, yn + h/2*s1);
        s3 = F(tn + h/2, yn + h/2*s2);
        s4 = F(tn + h, yn + h*s3);

        old = yn(1);
        yn = yn + h/6*(s1 + 2*s2 + 2*s3 + s4);
        
        if (old < 0 && yn(1) > 0) || (old > 0 && yn(1) < 0) || yn(1) == 0
           counter = counter + 1; 
        else 
            y = [y; yn];
        
            tn = tn + h;
            x = [x; tn];
        end
    end
    
    y = y(:, 1);
    
    plot(x, y);
    hold on;
    plot(x, zeros(1, length(x)), '--', 'HandleVisibility', 'off'); % x-axis
end